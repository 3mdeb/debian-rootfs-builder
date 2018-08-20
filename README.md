debian-rootfs-builder
=====================

This project aims to help in building Debian rootfs package.

It connect Docker and Ansible to provide automation and isolation for
debootstrap and chroot operations.

usage
-----

Building rootfs with given kernel version, config and set of packages.

```
docker run --privileged --rm -v $PWD:/home/debian/scripts -t -i \
3mdeb/debian-rootfs-builder ansible-playbook -vvv -i \
"/home/debian/scripts/rootfs," /home/debian/scripts/debian-rootfs.yml
--extra-vars "version=<linux_version> config=<config_url>"
```

For example:

```
docker run --privileged --rm -v $PWD:/home/debian/scripts -t -i \
3mdeb/debian-rootfs-builder ansible-playbook -vvv -i \
"/home/debian/scripts/rootfs," /home/debian/scripts/debian-rootfs.yml
--extra-vars "version=4.14.65 config=https://raw.githubusercontent.com/pcengines/apu2-documentation/master/configs/config-4.14.59"
```
