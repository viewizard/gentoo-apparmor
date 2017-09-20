# ------------------------------------------------------------------
#
#  Copyright (C) 2016,2017 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <local/tunables.d/>

profile mc /usr/bin/mc {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions/fs/access-by-pattern-filemanager>
  #include <abstractions/X>
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(cont) peer="shell_users",
  signal (send) set=(cont) peer="mc.cons.saver",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/ptmx						rw,
  /dev/pts/[0-9]*					rw,
  owner @{PROC}/@{pid}/mountinfo			r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/mc						mr,
  /usr/libexec/mc/cons.saver				Px,
  @{shell}						Px -> shell_users,
  
  # READS/WRITES ---------------------------------------
  /etc/mc/{,**}						r,
  /usr/libexec/mc/{,**}					r,
  /usr/share/mc/{,**}					r,
  
  # TEMP -----------------------------------------------
  owner /tmp/mc-*/					w,	# * - user name.
}

profile mc.cons.saver /usr/libexec/mc/cons.saver {
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

profile mc_root {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions/fs/access-by-pattern-filemanager>
  #include <abstractions/fs/access-by-pattern-systemusers>
  #include <abstractions/X_sudo>				# RBAC! Вызывается через sudo в X-сессии пользователя.
  
  # CAPABILITIES ---------------------------------------
  capability dac_read_search,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  capability dac_override,					# RBAC! Вызывается через sudo в X-сессии пользователя.
  
  # SIGNAL ---------------------------------------------
  signal (send) set=(cont) peer="shell_root",
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]*					rw,
  /dev/ptmx						rw,
  /dev/pts/[0-9]*					rw,
  owner @{PROC}/@{pid}/mountinfo			r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/mc						mr,
  /usr/libexec/mc/cons.saver				Px,
  @{shell}						Px -> shell_root,
  /** rw,
  # READS/WRITES ---------------------------------------
  /etc/mc/{,**}						r,
  /usr/libexec/mc/{,**}					r,
  /usr/share/mc/{,**}					r,
}
