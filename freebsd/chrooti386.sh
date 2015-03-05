#!/bin/sh

mount -t devfs devfs /compat/i386/dev
mount -t nullfs /usr/src /compat/i386/usr/src
mount -t nullfs /usr/ports /compat/i386/usr/ports
chroot /compat/i386 /bin/sh
service ldconfig start

export MACHINE=i386
export UNAME_p=i386
export UNAME_m=i386
