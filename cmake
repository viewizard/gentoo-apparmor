# ------------------------------------------------------------------
#
#  Copyright (C) 2017,2018 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <local/tunables.d/>

# предустановка для abstractions/fs/access-by-user-preset-rwk
@{USERS_DIR_rwk}="[^.]**"
@{USERS_FILE_rwk}="[^.]**"

profile cmake@{p_user} /usr/bin/cmake@{t_user} {
  #include <abstractions/base>
  #include <abstractions-user/fs/access-by-users-preset-rwk>
  
  # PTRACE ---------------------------------------------
  ptrace (trace) peer="cmake@{p_user}",
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  @{PROC_D}/						r,
  @{PROC_D}/@{pids}/stat				r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/cmake					mr,
  /usr/bin/cmake@{t_user}				Px,
  @{shell}@{t_user}					Cx,
  /usr/bin/cc@{t_user}					ix,
  /usr/bin/c++@{t_user}					ix,
  /usr/bin/gmake@{t_user}				ix,
  /usr/@{CHOST}/gcc-bin/[0-9]*/*@{t_user}		ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  /usr/@{CHOST}/binutils-bin/[0-9]*/*@{t_user}		ix,	# sys-devel/binutils
  /usr/libexec/gcc/@{CHOST}/[0-9]*/*@{t_user}		ix,	# sys-devel/gcc		# FIX ME! Вынести в отдельный профиль.
  
  # READS/WRITES ---------------------------------------
  /bin/							r,
  /opt/							r,
  /opt/bin/						r,
  /lib{,32,64}/						r,
  /usr/							r,
  /usr/bin/						r,
  /usr/lib{,32,64}/					r,
  /usr/local/						r,
  /usr/local/bin/					r,
  /usr/local/lib{,32,64}/				r,
  /usr/local/share/					r,
  /usr/@{CHOST}/lib/					r,
  /usr/@{CHOST}/gcc-bin/[0-9]*/				r,
  /etc/ld.so.conf					r,
  /etc/ld.so.conf.d/{,*}				r,
  /usr/include/{,**}					r,
  /usr/share/cmake/{,**}				r,
  /usr/share/gcc-data/@{CHOST}/[0-9]*/locale/**.mo	r,	# sys-devel/gcc
  /usr/share/binutils-data/@{CHOST}/[0-9]*/locale/**.mo r,	# sys-devel/binutils
  /usr/libexec/gcc/@{CHOST}/[0-9]*/**.so{,.[0-9]*}	mr,	# sys-devel/gcc
  
  # TEMP -----------------------------------------------
  owner /tmp/cc*.{s,c,res,o,le,ld}			rw,	# IMPROVE! Потом работать с xattr, чтобы ограничить только на процесс.
  
  profile shell @{shell}@{t_user} {
    #include <abstractions/base>
    
    # PSEUDO -------------------------------------------
    /dev/tty						rw,
    /dev/tty[0-9]*					rw,
    /dev/pts/[0-9]*					rw,
    
    # EXECUTABLES --------------------------------------
    @{shell}						mr,
    /bin/uname@{t_user}					Px,	# sys-apps/coreutils
    /bin/ps@{t_user}					Px,	# sys-process/procps
    /usr/bin/cmake@{t_user}				Px,
  }
}
