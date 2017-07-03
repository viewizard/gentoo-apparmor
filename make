# ------------------------------------------------------------------
#
#  Copyright (C) 2016,2017 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

# BUILD SYSTEM ONLY! Оставляем в профиле использование ix.
# Не при каких обстоятельствах данный пакет не должен присутствовать в
# конечной пользовательской системе или серверах.

#include <tunables/global>

profile make /usr/bin/{,g}make flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/ncurses>
  
  # CAPABILITIES ---------------------------------------
  capability mknod,
  capability sys_admin,
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(term) peer="make//shell",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/{,g}make					ixmr,	# Все правильно, запуск и mmap.
  @{shell}						Cx,
  /bin/uname						Px,
  /bin/rm						ix,	# FS ACCESS!
  /bin/ln						ix,	# FS ACCESS!
  /bin/cp						ix,	# FS ACCESS!
  /bin/mv						ix,	# FS ACCESS!
  /bin/echo						Px,
  /bin/expr						ix,	# FS ACCESS!
  /bin/grep						ix,	# FS ACCESS!
  /bin/chmod						ix,	# FS ACCESS!
  /bin/mkdir						ix,	# FS ACCESS!
  /bin/sed						ix,	# FS ACCESS!
  /bin/cat						ix,	# FS ACCESS!
  /bin/touch						ix,	# FS ACCESS!
  /usr/bin/gcc						ix,	# FIX ME! Вынести в отдельный профиль.
  /usr/bin/cmp						ix,	# FS ACCESS!
  /usr/bin/find						ix,	# FS ACCESS!
  /usr/@{CHOST}/gcc-bin/*/@{CHOST}-gcc			ix,	# FIX ME! Вынести в отдельный профиль.
  /usr/@{CHOST}/binutils-bin/[0-9]*/strip		ix,	# FIX ME! Вынести в отдельный профиль.
  /var/tmp/portage/genkernel/*/busybox-*/scripts/**	ix,	# genkernel-next
  
  # READS/WRITES ---------------------------------------
  /etc/env.d/gcc/{,**}					r,
  /lib{,32,64}/modules/{,**}				rw,
  /usr/src/@{kernel}/{,**}				ixrw,
  owner /var/log/genkernel.log				w,	# genkernel-next
  /var/tmp/portage/genkernel/*/busybox-*/{,**}		rw,	# genkernel-next
  
  # NOISY ----------------------------------------------
  deny /						r,
  
  profile shell @{shell} flags=(complain) {
    #include <abstractions/base>
    #include <abstractions/nameservice>
    #include <abstractions/perl>
    
    # CAPABILITIES ---------------------------------------
    capability mknod,
    
    # PSEUDO -------------------------------------------
    /dev/tty						rw,
    /dev/tty[0-9]*					rw,
    /dev/pts/[0-9]*					rw,
    @{PROC}/@{pid}/fd/					r,
    
    # EXECUTABLES --------------------------------------
    @{shell}						ixmr,	# Все правильно, запуск и mmap.
    /bin/uname						Px,
    /bin/sed						ix,	# FS ACCESS!
    /bin/rm						ix,	# FS ACCESS!
    /bin/wc						ix,	# FS ACCESS!
    /bin/mv						ix,	# FS ACCESS!
    /bin/dd						ix,	# FS ACCESS!
    /bin/tr						Px,
    /bin/ln						ix,	# FS ACCESS!
    /bin/cp						ix,	# FS ACCESS!
    /bin/pwd						ix,	# FS ACCESS!
    /bin/seq						ix,	# FIX ME! Вынести в отдельный профиль.
    /bin/cat						ix,	# FS ACCESS!
    /bin/cut						ix,	# FS ACCESS!
    /bin/gzip						ix,	# FS ACCESS!
    /bin/date						ix,	# FS ACCESS!
    /bin/dirname					Px,
    /bin/basename					Px,
    /bin/echo						Px,
    /bin/tail						ix,	# FS ACCESS!
    /bin/sort						ix,	# FS ACCESS!
    /bin/grep						ix,	# FS ACCESS!
    /bin/expr						ix,	# FS ACCESS!
    /bin/sleep						Px,
    /bin/mkdir						ix,	# FS ACCESS!
    /bin/kmod						Px,
    /bin/mktemp						ix,	# FS ACCESS!
    /bin/hostname					Px,
    /bin/touch						ix,	# FS ACCESS!
    /bin/head						ix,	# FS ACCESS!
    /bin/tar						ix,	# FS ACCESS!
    /bin/bzip2						ix,	# FS ACCESS!
    /usr/bin/diff					ix,	# FS ACCESS!
    /usr/bin/pod2html					ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/od						ix,	# FS ACCESS!
    /usr/bin/uniq					Px,
    /usr/bin/which					Px,
    /usr/bin/whoami					Px,
    /usr/bin/bc						ix,	# FS ACCESS!
    /usr/bin/cmp					ix,	# FS ACCESS!
    /usr/bin/git					ix,	# Не используем Px и Px -> git_root.
  								# FIX ME! Вынести в отдельный профиль.
    /usr/bin/svn					ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/gawk					ix,	# FS ACCESS!
    /usr/bin/find					ix,	# FS ACCESS!
    /usr/bin/pkg-config					Px,
    /usr/bin/xargs					ix,	# FS ACCESS!
    /usr/bin/gmake					Px,
    /usr/bin/gcc					ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/g++					ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/openssl					ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/libexec/gcc/@{CHOST}/*/*			ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/gcc-bin/*/*				ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/binutils-bin/*/*			ix,	# FIX ME! Вынести в отдельный профиль.
    /usr/src/@{kernel}/{,**}				ixr,	# FIX ME! Вынести в отдельный профиль.
    /var/tmp/portage/genkernel/*/busybox-*/**		ix,	# genkernel-next
    
    # READS/WRITES -------------------------------------
    /etc/ld.so.conf					r,
    /etc/ld.so.conf.d/{,*}				r,
    /etc/env.d/gcc/{,**}				r,
    /usr/libexec/gcc/@{CHOST}/{,**}.so*			mr,
    /usr/include/{,**}					r,
    /lib{,32,64}/modules/{,**}				rw,
    /usr/src/IMA/certs/*.x509				r,
    /usr/src/@{kernel}/{,**}				rw,
    /usr/src/@{kernel}/tools/gcc/**.so			m,
    
    # TEMP ---------------------------------------------
    owner /tmp/sh-thd.*					rw,
    owner /tmp/cc*.{s,c,res,o,le,ld}			rw,
    owner /tmp/cpiolist.*				rw,
    owner /tmp/tmp.*					rw,
    owner /tmp/depmod.*/{,**}				rw,
    owner /var/tmp/portage/genkernel/*/busybox-*/{,**}	rw,	# genkernel-next
    owner /var/tmp/portage/genkernel/initramfs-@{kernel_ver}.cpio r,	# genkernel-next
    owner /var/log/genkernel.log			w,	# genkernel-next
    
    # NOISY --------------------------------------------
    deny /.git/{,**}					r,
    deny @{HOME}/{,**}					r,
  }
}
