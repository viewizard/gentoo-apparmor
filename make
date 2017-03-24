# ------------------------------------------------------------------
#
#    Copyright (C) 2016,2017 Mikhail Kurinnoi
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of version 2 of the GNU General Public
#    License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <tunables/global>
profile make /usr/bin/{,g}make flags=(complain) {
  #include <abstractions/base>
  
  /dev/tty[0-9]* w,
  /dev/pts/[0-9]* rw,
  
  /usr/bin/{,g}make ixmr,
  /bin/bash Cx -> shell,
  /bin/uname ix,
  /bin/rm ix,
  /bin/ln ix,
  /bin/cp ix,
  /bin/echo ix,
  /bin/expr ix,
  /bin/grep ix,
  /bin/mkdir ix,
  /usr/bin/gcc ix,
  /usr/@{CHOST}/gcc-bin/*/@{CHOST}-gcc ix,
  
  /etc/env.d/gcc/{,**} r,
  /etc/terminfo/x/xterm r,
  /lib{,32,64}/modules/{,**} rw,
  /usr/src/linux-[0-9]*-{hardened,gentoo}*/{,**} ixrw,
  /usr/src/linux-[0-9]*-{hardened,gentoo}*/arch/*/boot/bzImage w,
  
  # Noisy
  deny / r,
  
  
  profile shell flags=(complain) {
    #include <abstractions/base>
    #include <abstractions/nameservice>
    #include <abstractions/perl>
    
    /dev/tty rw,
    /dev/tty[0-9]* w,
    /dev/pts/[0-9]* w,
    @{PROC}/@{pid}/fd/ r,
    
    /bin/bash ixmr,
    /bin/uname ix,
    /bin/sed ix,
    /bin/rm ix,
    /bin/wc ix,
    /bin/mv ix,
    /bin/tr ix,
    /bin/ln ix,
    /bin/cp ix,
    /bin/pwd ix,
    /bin/seq ix,
    /bin/cat ix,
    /bin/cut ix,
    /bin/gzip ix,
    /bin/date ix,
    /bin/dirname ix,
    /bin/basename ix,
    /bin/tail ix,
    /bin/sort ix,
    /bin/grep ix,
    /bin/expr ix,
    /bin/mkdir ix,
    /bin/kmod Px,
    /bin/mktemp ix,
    /bin/hostname ix,
    /bin/touch ix,
    /bin/head ix,
    /bin/tar ix,
    /bin/bzip2 ix,
    /usr/bin/uniq ix,
    /usr/bin/which ix,
    /usr/bin/whoami ix,
    /usr/bin/bc ix,
    /usr/bin/cmp ix,
    /usr/bin/git ix,
    /usr/bin/svn ix,
    /usr/bin/gawk ix,
    /usr/bin/find ix,
    /usr/bin/pkg-config ix,
    /usr/bin/xargs ix,
    /usr/bin/gmake Px,
    /usr/bin/gcc ix,
    /usr/bin/g++ ix,
    /usr/bin/openssl ix,
    /usr/libexec/gcc/@{CHOST}/*/* ix,
    /usr/@{CHOST}/gcc-bin/*/* ix,
    /usr/@{CHOST}/binutils-bin/*/* ix,
    /usr/src/linux-[0-9]*-{hardened,gentoo}*/{,**} rix,
    
    /etc/ld.so.conf r,
    /etc/ld.so.conf.d/{,*} r,
    /etc/env.d/gcc/{,**} r,
    /usr/libexec/gcc/@{CHOST}/{,**}.so* mr,
    /usr/include/{,**} r,
    /lib{,32,64}/modules/{,**} rw,
    /usr/src/IMA/certs/*.x509 r,
    /usr/src/linux-[0-9]*-{hardened,gentoo}*/{,**} rw,
    /usr/src/linux-[0-9]*-{hardened,gentoo}*/tools/gcc/**.so m,
    /usr/share/pkgconfig/{,**} r,
    /var/tmp/portage/genkernel/initramfs-*-{hardened,gentoo}*.cpio r,
    
    owner /tmp/sh-thd.* rw,
    owner /tmp/cc*.{s,c,res,o,le,ld} rw,
    owner /tmp/cpiolist.* rw,
    owner /tmp/depmod.*/{,**} rw,
    
    # Noisy
    deny /.git/{,**} r,
    deny @{HOME}/{,**} r,
  
  }
  
}
