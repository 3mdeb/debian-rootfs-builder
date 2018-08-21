debian-rootfs-builder
=====================

This project aims to help in building Debian rootfs package.

It connect Docker and Ansible to provide automation and isolation for
debootstrap and chroot operations.

usage
-----

Building rootfs with given kernel version, config and set of packages.

```
docker run --privileged --rm -v $PWD/.ccache:/home/debian/.ccache \
-v $PWD:/home/debian/scripts -t -i 3mdeb/debian-rootfs-builder \
ansible-playbook -vvv /home/debian/scripts/debian-rootfs.yml
```
