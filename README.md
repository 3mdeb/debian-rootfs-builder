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

```
docker run --privileged --rm -e
ANSIBLE_CONFIG=/home/debian/scripts/ansible.cfg -v $PWD:/home/debian/scripts -t
-i 3mdeb/debian-rootfs-builder ansible-playbook -i
"/home/debian/scripts/rootfs," /home/debian/scripts/debian-rootfs.yml
```

Performance optimization
------------------------

```
Tuesday 21 August 2018  16:01:58 +0000 (0:00:51.188)       0:42:09.618 ********
===============================================================================
linux-kernel --------------------------------------------------------- 1341.78s
packages -------------------------------------------------------------- 798.20s
debootstrap ----------------------------------------------------------- 327.46s
command ---------------------------------------------------------------- 51.19s
setup ------------------------------------------------------------------- 8.85s
config ------------------------------------------------------------------ 1.93s
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
total ---------------------------------------------------------------- 2529.40s
Tuesday 21 August 2018  16:01:58 +0000 (0:00:51.188)       0:42:09.617 ********
===============================================================================
packages : install packages ------------------------------------------- 798.20s
linux-kernel : make deb-pkg ------------------------------------------- 613.37s
linux-kernel : make deb-pkg ------------------------------------------- 565.16s
debootstrap : debootstrap second stage -------------------------------- 193.23s
debootstrap : debootstrap first stage --------------------------------- 115.25s
compress rootfs -------------------------------------------------------- 51.19s
linux-kernel : make mrproper ------------------------------------------- 30.88s
linux-kernel : decompress Linux "4.9.122" ------------------------------ 22.09s
linux-kernel : decompress Linux "4.14.65" ------------------------------ 20.01s
linux-kernel : get Linux "4.9.122" ------------------------------------- 19.28s
debootstrap : install packages ----------------------------------------- 18.97s
linux-kernel : get Linux "4.14.65" ------------------------------------- 17.15s
linux-kernel : remove everything except artifacts ---------------------- 14.65s
linux-kernel : make mrproper ------------------------------------------- 13.45s
linux-kernel : make olddefconfig ---------------------------------------- 9.12s
linux-kernel : remove everything except artifacts ----------------------- 6.58s
Gathering Facts --------------------------------------------------------- 4.62s
Gathering Facts --------------------------------------------------------- 4.23s
linux-kernel : make olddefconfig ---------------------------------------- 3.94s
linux-kernel : copy bzImage to known location --------------------------- 1.91s
Playbook run took 0 days, 0 hours, 42 minutes, 9 seconds
```

## Setting up apt-cacher

```
docker build -t apt-cacher -f Dockerfile.apt-cacher .
docker run -d -p 3142:3142 --name apt-cacher-run apt-cacher
docker logs -f apt-cacher-run
```
### Performance - first run

```
Tuesday 21 August 2018  22:48:46 +0000 (0:00:53.340)       0:26:40.226 ********
===============================================================================
linux-kernel --------------------------------------------------------- 1272.91s
debootstrap ----------------------------------------------------------- 265.41s
command ---------------------------------------------------------------- 53.34s
setup ------------------------------------------------------------------- 8.29s
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
total ---------------------------------------------------------------- 1599.95s
Tuesday 21 August 2018  22:48:46 +0000 (0:00:53.341)       0:26:40.225 ********
===============================================================================
linux-kernel : make deb-pkg ------------------------------------------- 608.31s
linux-kernel : make deb-pkg ------------------------------------------- 510.51s
debootstrap : debootstrap second stage -------------------------------- 194.68s
compress rootfs -------------------------------------------------------- 53.34s
debootstrap : debootstrap first stage ---------------------------------- 52.27s
linux-kernel : decompress Linux "4.14.65" ------------------------------ 25.45s
linux-kernel : make mrproper ------------------------------------------- 24.57s
linux-kernel : decompress Linux "4.9.122" ------------------------------ 22.61s
debootstrap : install packages ----------------------------------------- 18.45s
linux-kernel : get Linux "4.14.65" ------------------------------------- 17.44s
linux-kernel : get Linux "4.9.122" ------------------------------------- 16.96s
linux-kernel : make mrproper ------------------------------------------- 12.19s
linux-kernel : make olddefconfig --------------------------------------- 10.54s
linux-kernel : remove everything except artifacts ----------------------- 7.96s
linux-kernel : remove everything except artifacts ----------------------- 7.15s
Gathering Facts --------------------------------------------------------- 4.62s
Gathering Facts --------------------------------------------------------- 3.68s
linux-kernel : make olddefconfig ---------------------------------------- 3.63s
linux-kernel : copy bzImage to known location --------------------------- 1.67s
linux-kernel : copy bzImage to known location --------------------------- 1.58s
Playbook run took 0 days, 0 hours, 26 minutes, 40 seconds
```


### Performance - further iterations
