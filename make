# ------------------------------------------------------------------
#
#    Copyright (C) 2016 Mikhail Kurinnoi
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of version 2 of the GNU General Public
#    License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <tunables/global>
profile make /usr/bin/{,g}make flags=(complain) {
  #include <abstractions/base>
  
  /dev/pts/[0-9]* rw,
  
  /usr/bin/{,g}make rix,
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
  /usr/x86_64-pc-linux-gnu/gcc-bin/*/x86_64-pc-linux-gnu-gcc ix,
  
  /etc/env.d/gcc/{,**} r,
  /etc/terminfo/x/xterm r,
  /lib{,32,64}/modules/{,**} rw,
  /usr/src/linux-*-{hardened,gentoo}*/{,**} rwix,
  /usr/src/linux-*-{hardened,gentoo}*/arch/*/boot/bzImage w,
  
  # Noisy
  deny / r,
  
  
  profile shell flags=(complain) {
    #include <abstractions/base>
    #include <abstractions/nameservice>
    #include <abstractions/perl>
    #include <abstractions/user-tmp>
    
    /dev/tty rw,
    /dev/pts/[0-9]* w,
    @{PROC}/@{pid}/fd/ r,
    
    /bin/bash rix,
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
    /usr/libexec/gcc/x86_64-pc-linux-gnu/*/* ix,
    /usr/x86_64-pc-linux-gnu/gcc-bin/*/* ix,
    /usr/x86_64-pc-linux-gnu/binutils-bin/*/* ix,
    /usr/src/linux-*-{hardened,gentoo}*/{,**} rix,
    
    /etc/ld.so.conf r,
    /etc/ld.so.conf.d/{,*} r,
    /etc/env.d/gcc/{,**} r,
    /usr/libexec/gcc/x86_64-pc-linux-gnu/{,**}.so* rm,
    /usr/include/{,**} r,
    /lib{,32,64}/modules/{,**} rw,
    /usr/src/linux-*-{hardened,gentoo}*/{,**} rw,
    /usr/src/linux-*-{hardened,gentoo}*/tools/gcc/**.so m,
    /usr/share/pkgconfig/{,**} r,
    
    # Noisy
    deny @{HOME}/{,**} r,
  
  }
  
}
