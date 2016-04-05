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
profile login /bin/login flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/authentication>


  capability dac_override,
  capability setuid,
  capability setgid,
  capability chown,
  capability fowner,
  capability fsetid,
  
  /dev/tty[0-9]* rw,
  @{PROC}/@{pid}/uid_map r,
  @{PROC}/@{pid}/loginuid rw,
  @{PROC}/@{pid}/mountinfo r,

  /bin/bash Px,
  
  # FIX ME!
  /usr/sbin/pmvarrun Pux,
  /usr/bin/ofl Pux,
  /bin/mount Pux,
  /bin/umount Pux,

  /etc/environment r,
  /etc/login.defs r,
  /etc/passwd r,
  /etc/shells r,
  /etc/security/limits.d/ r,
  
  /run/utmp rwk,
  
  /var/log/wtmp wk,
  /var/log/tallylog rw,
  /var/log/lastlog rwk,
  
}
