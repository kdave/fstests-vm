#!/bin/sh

dir=/home/build

cd "$dir" || { echo "ERROR: cannot cd to $dir"; exit ;1 }

cd btrfs-progs
./autogen.sh
./configure --disable-documentation --disable-python
make -j 4
make test
make test-clean
cd ..

cd xfstests
autoreconf -vfi --include=m4
libtoolize -i
./configure
make -j 4

mkdir -p /tmp/test /tmp/scratch

echo '
export TEST_DEV=/dev/nvme1n1
export TEST_DIR=/tmp/test
export SCRATCH_DEV_POOL='/dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 /dev/nvme6n1 /dev/nvme7n1 /dev/nvme8n1 /dev/nvme9n1'
export LOGWRITES_DEV=/dev/nvme10n1
export SCRATCH_MNT=/tmp/scratch
export FSTYP=btrfs
export MKFS_OPTIONS='-K -f'
export MOUNT_OPTIONS=''

export USE_KMEMLEAK=yes
export DIFF_LENGTH=0
' > local.config

modprobe loop
modprobe btrfs

id fsgqa || useradd fsgqa
getent group fsgqa || groupadd fsgqa
mkdir -p /home/fsgqa

cat ./local.config
source ./local.config

./check -b -T
