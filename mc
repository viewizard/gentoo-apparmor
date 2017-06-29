# ------------------------------------------------------------------
#
#  Copyright (C) 2016,2017 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <tunables/global>

profile mc /usr/bin/mc {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions/fs-access-by-pattern-filemanager>
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]						rw,
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
}

profile mc.cons.saver /usr/libexec/mc/cons.saver flags=(complain) {
  #include <abstractions/base>
  
  # CAPABILITIES ---------------------------------------
  capability setuid,
  
  # PSEUDO ---------------------------------------------
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/libexec/mc/cons.saver				mr,
}

profile mc_root flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/ncurses>
  #include <abstractions/fs-access-by-pattern-filemanager>
  #include <abstractions/fs-access-by-pattern-systemusers>
  
  # PSEUDO ---------------------------------------------
  /dev/tty						rw,
  /dev/tty[0-9]						rw,
  /dev/ptmx						rw,
  /dev/pts/[0-9]*					rw,
  owner @{PROC}/@{pid}/mountinfo			r,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/mc						mr,
  /usr/libexec/mc/cons.saver				Px,
  @{shell}						Px -> shell_root,
  
  # READS/WRITES ---------------------------------------
  /etc/mc/{,**}						r,
  /usr/libexec/mc/{,**}					r,
  /usr/share/mc/{,**}					r,
}
