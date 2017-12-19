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

# Профиль ориентирован только на сборку ядра и initramfs.

#include <local/tunables.d/>

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
  /bin/uname						Px,	# sys-apps/coreutils
  /bin/rm						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/ln						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/cp						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/mv						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/echo						Px,	# sys-apps/coreutils
  /bin/expr						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/grep						ix,	# sys-apps/grep		# FS ACCESS!
  /bin/chmod						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/mkdir						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/sed						ix,	# sys-apps/sed		# FS ACCESS!
  /bin/cat						ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/touch						ix,	# sys-apps/coreutils	# FS ACCESS!
  /usr/bin/gcc						ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  /usr/bin/cmp						ix,	# sys-apps/diffutils	# FS ACCESS!
  /usr/bin/find						ix,	# sys-apps/findutils	# FS ACCESS!
  /usr/@{CHOST}/gcc-bin/[0-9]*/@{CHOST}-gcc		ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  /usr/@{CHOST}/binutils-bin/[0-9]*/strip		ix,	# sys-devel/binutils	# FIX ME! Вынести в отдельный профиль.
  /var/tmp/portage/genkernel/*/busybox-*/scripts/{,**/}* ix,	# sys-kernel/genkernel-next
  
  # READS/WRITES ---------------------------------------
  /							r,
  /etc/env.d/gcc/{,**}					r,	# sys-devel/gcc
  /lib{,32,64}/modules/{,**}				rw,
  /usr/share/gcc-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/gcc
  /usr/share/binutils-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/binutils
  /usr/src/@{kernel}/{,**}				rw,	# sys-kernel/gentoo-sources	# r - т.к. могут быть скрипты.
  /usr/src/@{kernel}/{,**/}*				ix,	# sys-kernel/gentoo-sources
  owner /var/log/genkernel.log				w,	# sys-kernel/genkernel-next
  
  # USERS ----------------------------------------------
  owner /root/.rnd					w,	# dev-libs/openssl
  
  # TEMP -----------------------------------------------
  /var/tmp/portage/genkernel/*/busybox-*/{,**}		rw,	# sys-kernel/genkernel-next
  
  profile shell @{shell} flags=(complain) {
    #include <abstractions/base>
    #include <abstractions/nameservice>
    #include <abstractions/perl>
    
    # CAPABILITIES ---------------------------------------
    capability mknod,
    capability sys_admin,
    
    # PSEUDO -------------------------------------------
    /dev/tty						rw,
    /dev/tty[0-9]*					rw,
    /dev/pts/[0-9]*					rw,
    owner @{PROC}/@{pid}/fd/				r,
    
    # EXECUTABLES --------------------------------------
    @{shell}						ixmr,	# Все правильно, запуск и mmap.
    /bin/uname						Px,	# sys-apps/coreutils
    /bin/sed						ix,	# sys-apps/sed		# FS ACCESS!
    /bin/rm						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/wc						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/mv						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/dd						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/tr						Px,	# sys-apps/coreutils
    /bin/ln						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/cp						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/pwd						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/seq						ix,	# sys-apps/coreutils	# FIX ME! Вынести в отдельный профиль.
    /bin/cat						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/cut						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/gzip						ix,	# app-arch/gzip		# FS ACCESS!
    /bin/date						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/dirname					Px,	# sys-apps/coreutils
    /bin/basename					Px,	# sys-apps/coreutils
    /bin/echo						Px,	# sys-apps/coreutils
    /bin/tail						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/sort						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/grep						ix,	# sys-apps/grep		# FS ACCESS!
    /bin/expr						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/sleep						Px,	# sys-apps/coreutils
    /bin/mkdir						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/kmod						Px,	# sys-apps/kmod
    /bin/mktemp						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/hostname					Px,	# sys-apps/net-tools
    /bin/touch						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/head						ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/tar						ix,	# app-arch/tar		# FS ACCESS!
    /bin/bzip2						ix,	# app-arch/bzip2	# FS ACCESS!
    /usr/bin/diff					ix,	# sys-apps/diffutils	# FS ACCESS!
    /usr/bin/pod2html					ix,	# dev-lang/perl		# FIX ME! Вынести в отдельный профиль.
    /usr/bin/od						ix,	# sys-apps/coreutils	# FS ACCESS!
    /usr/bin/uniq					ix,	# sys-apps/coreutils	# FS ACCESS!
    /usr/bin/which					Px,	# sys-apps/which
    /usr/bin/whoami					Px,	# sys-apps/coreutils
    /usr/bin/bc						ix,	# sys-devel/bc		# FS ACCESS!
    /usr/bin/cmp					ix,	# sys-apps/diffutils	# FS ACCESS!
    /usr/bin/git					ix,	# dev-vcs/git		# Не используем Px и Px -> git_root.
  											# FIX ME! Вынести в отдельный профиль.
    /usr/bin/svn					ix,	# dev-vcs/subversion	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/gawk					ix,	# sys-apps/gawk		# FS ACCESS!
    /usr/bin/find					ix,	# sys-apps/findutils	# FS ACCESS!
    /usr/bin/pkg-config					Px,	# dev-util/pkgconfig
    /usr/bin/stat					ix,	# sys-apps/coreutils
    /usr/bin/xargs					ix,	# sys-apps/findutils	# FS ACCESS!
    /usr/bin/gmake					Pxr,	# sys-devel/make	# Все правильно, r.
    /usr/bin/gcc					ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/bin/g++					ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/bin/openssl					ix,	# dev-libs/openssl	# FIX ME! Вынести в отдельный профиль.
    /usr/libexec/gcc/@{CHOST}/[0-9]*/*			ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/gcc-bin/[0-9]*/*			ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/binutils-bin/[0-9]*/*			ix,	# sys-devel/binutils	# FIX ME! Вынести в отдельный профиль.
    /usr/src/@{kernel}/{,**}				r,	# sys-kernel/gentoo-sources	# FIX ME! Вынести в отдельный профиль. r - т.к. могут быть скрипты.
    /usr/src/@{kernel}/{,**/}*				ix,	# sys-kernel/gentoo-sources	# FIX ME! Вынести в отдельный профиль.
    /var/tmp/portage/genkernel/*/busybox-*/{,**/}*	ix,	# sys-kernel/genkernel-next
    
    # READS/WRITES -------------------------------------
    /etc/ld.so.conf					r,
    /etc/ld.so.conf.d/{,*}				r,
    /etc/env.d/gcc/{,**}				r,	# sys-devel/gcc
    /usr/libexec/gcc/@{CHOST}/[0-9]*/**.so{,.[0-9]*}	mr,	# sys-devel/gcc
    /usr/include/{,**}					r,
    /usr/share/gcc-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/gcc
    /usr/share/binutils-data/@{CHOST}/[0-9]*/locale/**.mo r,	# sys-devel/binutils
    /lib{,32,64}/modules/{,**}				rw,
    /usr/src/IMA/certs/*.x509				r,
    /usr/src/@{kernel}/{,**}				rw,	# sys-kernel/gentoo-sources
    /usr/src/@{kernel}/tools/gcc/**.so			m,	# sys-kernel/gentoo-sources
    
    # USERS --------------------------------------------
    owner @{HOME}/.rnd					w,	# dev-libs/openssl
    owner @{HOME}/.subversion/{,*}			r,	# dev-vcs/subversion
    
    # TEMP ---------------------------------------------
    owner /tmp/@{TMP_SH}				rw,	# IMPROVE! Потом работать с xattr, чтобы ограничить только на процесс.
    owner /tmp/cc*.{s,c,res,o,le,ld}			rw,	# IMPROVE! Потом работать с xattr, чтобы ограничить только на процесс.
    owner /tmp/cpiolist.@{TMP6}				rw,
    audit owner /tmp/tmp.*				rw,	# FIX ME! audit 26.11.2017		# IMPROVE! Потом работать с xattr, чтобы ограничить только на процесс.
    audit owner /tmp/depmod.*/{,**}			rw,	# FIX ME! audit 26.11.2017
    owner /var/tmp/portage/genkernel/*/busybox-*/{,**}	rw,	# sys-kernel/genkernel-next
    owner /var/tmp/portage/genkernel/initramfs-@{kernel_ver}.cpio r,	# sys-kernel/genkernel-next
    owner /var/log/genkernel.log			w,	# sys-kernel/genkernel-next
  }
}
