# ------------------------------------------------------------------
#
#  Copyright (C) 2016-2018 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <local/tunables.d/>

profile mc@{p_user} /usr/bin/mc@{t_user} {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions-user/fs/access-by-pattern-filemanager>
  #include <abstractions-user/X>
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(cont) peer="shell_users",
  signal (send) set=(cont) peer="mc.cons.saver@{p_user}",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/ptmx						rw,
  /dev/pts/[0-9]*					rw,
  owner @{PROC_D}/@{pid}/mountinfo			r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/mc						mr,
  /usr/libexec/mc/cons.saver@{t_user}			Px,
  @{shell}@{t_user}					Px -> shell_users,
  
  # READS/WRITES ---------------------------------------
  /etc/mc/{,**}						r,
  /usr/libexec/mc/{,**}					r,
  /usr/share/mc/{,**}					r,
  
  # TEMP -----------------------------------------------
  owner /tmp/mc-@{USER}/{,**}				w,
}

profile mc.cons.saver@{p_user} /usr/libexec/mc/cons.saver@{t_user} {
  #include <abstractions/base>
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/vcsa[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/libexec/mc/cons.saver				mr,
}

profile mc@{p_root} /usr/bin/mc@{t_root} {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions-root/fs/access-by-pattern-filemanager>
  #include <abstractions-root/fs/access-by-pattern-systemusers>
  #include <abstractions-root/X>
  #include <abstractions-sudo/X-connection-strict>		# RBAC! Нужно для запуска под root-ом через sudo
  								# с подключением к X-сессии пользователя.
  
  # CAPABILITIES ---------------------------------------
  capability dac_read_search,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  capability dac_override,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(cont) peer="shell_root",
  signal (send) set=(cont) peer="mc.cons.saver@{p_root}",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/ptmx						rw,
  /dev/pts/[0-9]*					rw,
  owner @{PROC_D}/@{pid}/mountinfo			r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/mc						mr,
  /usr/libexec/mc/cons.saver@{t_root}			Px,
  @{shell}@{t_root}					Px -> shell_root,
  
  # READS/WRITES ---------------------------------------
  /etc/mc/{,**}						r,
  /usr/libexec/mc/{,**}					r,
  /usr/share/mc/{,**}					r,
  
  # TEMP -----------------------------------------------
  owner /tmp/mc-root/{,**}				w,
}

profile mc.cons.saver@{p_root} /usr/libexec/mc/cons.saver@{t_root} {
  #include <abstractions/base>
  
  # CAPABILITIES ---------------------------------------
  capability setuid,
  capability dac_read_search,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  capability dac_override,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/vcsa[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/libexec/mc/cons.saver				mr,
}
