# ------------------------------------------------------------------
#
#  Copyright (C) 2016-2018 Mikhail Kurinnoi
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

profile make@{p_root} /usr/bin/{,g}make@{t_root} flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/ncurses>
  
  # CAPABILITIES ---------------------------------------
  capability mknod,
  capability sys_admin,
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(term) peer="make@{p_root}//shell",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/{,g}make					mr,
  /usr/bin/{,g}make@{t_root}				ix,	# Все правильно, запуск и mmap.
  @{shell}@{t_root}					Cx,
  /bin/uname@{t_root}					Px,	# sys-apps/coreutils
  /bin/rm@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/ln@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/cp@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/mv@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/echo@{t_root}					Px,	# sys-apps/coreutils
  /bin/expr@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/grep@{t_root}					ix,	# sys-apps/grep		# FS ACCESS!
  /bin/chmod@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/mkdir@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/sed@{t_root}					ix,	# sys-apps/sed		# FS ACCESS!
  /bin/cat@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /bin/touch@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
  /usr/bin/gcc@{t_root}					ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  /usr/bin/cmp@{t_root}					ix,	# sys-apps/diffutils	# FS ACCESS!
  /usr/bin/find@{t_root}				ix,	# sys-apps/findutils	# FS ACCESS!
  /usr/bin/getconf@{t_root}				ix,	# sys-libs/glibc	# FS ACCESS!
  /usr/src/@{kernel}/{,**/}*@{t_root}			ix,	# sys-kernel/gentoo-sources
  /usr/@{CHOST}/gcc-bin/[0-9]*/@{CHOST}-gcc@{t_root}	ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  /usr/@{CHOST}/binutils-bin/[0-9]*/strip@{t_root}	ix,	# sys-devel/binutils	# FIX ME! Вынести в отдельный профиль.
  /var/tmp/portage/genkernel/*/busybox-*/scripts/{,**/}*@{t_root} ix,	# sys-kernel/genkernel-next
  
  # READS/WRITES ---------------------------------------
  /							r,
  /etc/env.d/gcc/{,**}					r,	# sys-devel/gcc
  /lib{,32,64}/modules/{,**}				rw,
  /usr/include/{,**}					r,
  /usr/share/gcc-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/gcc
  /usr/share/binutils-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/binutils
  /usr/src/@{kernel}/{,**}				rw,	# sys-kernel/gentoo-sources	# r - т.к. могут быть скрипты.
  owner /var/log/genkernel.log				w,	# sys-kernel/genkernel-next
  
  # USERS ----------------------------------------------
  owner /root/.rnd					w,	# dev-libs/openssl
  
  # TEMP -----------------------------------------------
  /var/tmp/portage/genkernel/*/busybox-*/{,**}		rw,	# sys-kernel/genkernel-next
  
  profile shell @{shell}@{t_root} flags=(complain) {
    #include <abstractions/base>
    #include <abstractions/nameservice>
    
    # CAPABILITIES ---------------------------------------
    capability mknod,
    capability sys_admin,
    
    # PSEUDO -------------------------------------------
    /dev/tty						rw,
    /dev/tty[0-9]*					rw,
    /dev/pts/[0-9]*					rw,
    owner @{PROC_D}/cmdline				r,
    owner @{PROC_D}/@{pid}/fd/				r,
    
    # EXECUTABLES --------------------------------------
    /usr/bin/gmake					r,
    @{shell}						mr,
    @{shell}@{t_root}					ix,	# Все правильно, запуск и mmap.
    /bin/uname@{t_root}					Px,	# sys-apps/coreutils
    /bin/sed@{t_root}					ix,	# sys-apps/sed		# FS ACCESS!
    /bin/rm@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/wc@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/mv@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/dd@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/tr@{t_root}					Px,	# sys-apps/coreutils
    /bin/ln@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/cp@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/pwd@{t_root}					Px,	# sys-apps/coreutils
    /bin/seq@{t_root}					ix,	# sys-apps/coreutils	# FIX ME! Вынести в отдельный профиль.
    /bin/cat@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/cut@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/gzip@{t_root}					ix,	# app-arch/gzip		# FS ACCESS!
    /bin/date@{t_root}					Px,	# sys-apps/coreutils
    /bin/dirname@{t_root}				Px,	# sys-apps/coreutils
    /bin/basename@{t_root}				Px,	# sys-apps/coreutils
    /bin/echo@{t_root}					Px,	# sys-apps/coreutils
    /bin/tail@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/sort@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/grep@{t_root}					ix,	# sys-apps/grep		# FS ACCESS!
    /bin/expr@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/sleep@{t_root}					Px,	# sys-apps/coreutils
    /bin/mkdir@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/kmod@{t_root}					ix,	# sys-apps/kmod
  								# Все правильно, ix. Чтобы установить модули ядра,
  								# ставим IMA hash в IMA policy для make//shell профиля.
    /bin/mktemp@{t_root}				ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/hostname@{t_root}				Px,	# sys-apps/net-tools
    /bin/touch@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/head@{t_root}					ix,	# sys-apps/coreutils	# FS ACCESS!
    /bin/tar@{t_root}					ix,	# app-arch/tar		# FS ACCESS!
    /bin/bzip2@{t_root}					ix,	# app-arch/bzip2	# FS ACCESS!
    /usr/bin/diff@{t_root}				ix,	# sys-apps/diffutils	# FS ACCESS!
    /usr/bin/pod2html@{t_root}				Px,	# dev-lang/perl
    /usr/bin/pod2text-[0-9]*-perl-[0-9]*@{t_root}	Px,	# dev-lang/perl
    /usr/bin/pod2man-[0-9]*-perl-[0-9]*@{t_root}	Px,	# dev-lang/perl
    /usr/bin/od@{t_root}				ix,	# sys-apps/coreutils	# FS ACCESS!
    /usr/bin/uniq@{t_root}				Px,	# sys-apps/coreutils
    /usr/bin/which@{t_root}				Px,	# sys-apps/which
    /usr/bin/whoami@{t_root}				Px,	# sys-apps/coreutils
    /usr/bin/bc@{t_root}				ix,	# sys-devel/bc		# FS ACCESS!
    /usr/bin/cmp@{t_root}				ix,	# sys-apps/diffutils	# FS ACCESS!
    /usr/bin/git@{t_root}				ix,	# dev-vcs/git		# Не используем Px.
  											# FIX ME! Вынести в отдельный профиль.
    /usr/bin/svn@{t_root}				ix,	# dev-vcs/subversion	# FIX ME! Вынести в отдельный профиль.
    /usr/bin/gawk@{t_root}				ix,	# sys-apps/gawk		# FS ACCESS!
    /usr/bin/find@{t_root}				ix,	# sys-apps/findutils	# FS ACCESS!
    /usr/bin/pkg-config@{t_root}			Px,	# dev-util/pkgconfig
    /usr/bin/stat@{t_root}				Px,	# sys-apps/coreutils
    /usr/bin/xargs@{t_root}				ix,	# sys-apps/findutils	# FS ACCESS!
    /usr/bin/gmake@{t_root}				Px,	# sys-devel/make
    /usr/bin/gcc@{t_root}				ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/bin/g++@{t_root}				ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/bin/openssl@{t_root}				ix,	# dev-libs/openssl	# FIX ME! Вынести в отдельный профиль.
    /usr/libexec/gcc/@{CHOST}/[0-9]*/*@{t_root}		ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/gcc-bin/[0-9]*/*@{t_root}		ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
    /usr/@{CHOST}/binutils-bin/[0-9]*/*@{t_root}	ix,	# sys-devel/binutils
								# FIX ME! Вынести в отдельный профиль.
    /usr/src/@{kernel}/{,**/}*@{t_root}			ix,	# sys-kernel/gentoo-sources
								# FIX ME! Вынести в отдельный профиль.
    /var/tmp/portage/genkernel/*/busybox-*/{,**/}*@{t_root} ix,	# sys-kernel/genkernel-next
    
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
    /usr/src/@{kernel}/scripts/gcc-plugins/*.so		m,	# sys-kernel/gentoo-sources
    
    # USERS --------------------------------------------
    owner @{ROOT_HOME_D}/.rnd				w,	# dev-libs/openssl
    owner @{ROOT_HOME_D}/.subversion/{,*}		r,	# dev-vcs/subversion
    
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
