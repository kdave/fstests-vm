fstests automation
==================

mkosi config and setup scripts, based on openSUSE Tumbleweed, prepared
to run fstests in a VM

- `mkosi -f build`
- `mkosi vm`

Host:

- (build) mtools, dnf
- (vm) lot of space
- (ssh) socat

Troubleshooting:

- if it does not work, `mkosi clean` and try again
- if it does not work on openSUSE, try it on Fedora and check differences
- openSUSE wants to set up system for the first time and manually enter locale/country
  (fixed by /etc/vconsole.conf "KEYMAP=us")
- if it fails due to weird file errors (EBUSY) try setting `WorkspaceDirectory`
- same fs with sources, cache and output prevents problems and speeds things up

References:

- https://github.com/loemraw/fast-fstests
