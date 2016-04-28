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

# config for abstractions/program-work-with-disk-** (**-rk,rwk)
@{PROG_DIR}="**"
@{PROG_FILE}="**"

profile mc /usr/bin/mc {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk>
  
  capability setuid,
  
  /dev/tty rw,
  /dev/ptmx rw,
  /dev/pts/[0-9]* rw,
  owner @{PROC}/@{pid}/mountinfo r,
  
  /usr/bin/mc r,
  /usr/libexec/mc/cons.saver ix,
  /bin/bash Px -> bash_users,
  
  /etc/mc/{,**} r,
  /etc/terminfo/x/xterm r,
  /usr/libexec/mc/{,**} r,
  /usr/share/mc/{,**} r,
  
}


profile mc_root flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk>
  #include <abstractions/user-systemwide-files>
  
  capability setuid,
  
  /dev/tty rw,
  /dev/ptmx rw,
  /dev/pts/[0-9]* rw,
  owner @{PROC}/@{pid}/mountinfo r,
  
  /usr/bin/mc r,
  /usr/libexec/mc/cons.saver ix,
  /bin/bash Px -> bash_root,
  
  /etc/mc/{,**} r,
  /etc/terminfo/x/xterm r,
  /usr/libexec/mc/{,**} r,
  /usr/share/mc/{,**} r,
  
}
