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


profile bash_default /bin/{bash,rbash,sh} {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  
  /bin/bash r,
  /bin/sed ixr,
  /bin/uname ixr,
  /sbin/mdadm Pxr,
  /usr/sbin/logcheck Puxr,
  
}


profile bash_users {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk>
  
  capability setuid,
  capability sys_tty_config,
  capability kill,
  capability dac_read_search,
  capability dac_override,
  
  /bin/bash ixr,
  /bin/ls ixr,
  /bin/ln ixr,
  /bin/df Pxr,
  /bin/rm ixr,
  /bin/tty ixr,
  /bin/grep ixr,
  /bin/ps Pxr,
  /bin/passwd Pxr,
  /bin/uname ixr,
  /bin/su Pxr,
  /usr/bin/which ixr,
  /usr/bin/git Px,
  /usr/bin/sudo Pxr,
  /usr/bin/whoami ixr,
  /usr/bin/id ixr,
  /usr/bin/startxfce4 Pxr,
  
  /etc/profile.env r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
}


profile bash_root {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk>
  #include <abstractions/user-systemwide-files>
  
  capability setuid,
  capability setgid,
  capability chown,
  capability fsetid,
  capability fowner,
  capability sys_tty_config,
  capability kill,
  capability dac_read_search,
  capability dac_override,
  
  /bin/bash ixr,
  /bin/ls ixr,
  /bin/ln ixr,
  /bin/df Pxr,
  /bin/rm ixr,
  /bin/cut ixr,
  /bin/tty ixr,
  /bin/tr ixr,
  /bin/grep ixr,
  /bin/ps Pxr,
  /bin/env ixr,
  /bin/sed ixr,
  /bin/gzip ixr,
  /bin/mount Pxr,
  /bin/umount Pxr,
  /bin/sleep ixr,
  /bin/passwd Pxr,
  /bin/uname ixr,
  /bin/cp ixr,
  /bin/mv ixr,
  /bin/chown ixr,
  /bin/chmod ixr,
  /sbin/mdadm Pxr,
  /sbin/shutdown Pxr,
  /sbin/{halt,poweroff,reboot} Pxr,
  /sbin/cryptsetup Pxr,
  /sbin/openrc Pxr,
  /sbin/apparmor_parser Pxr,
  /usr/bin/pmount Pxr,
  /usr/bin/pumount Pxr,
  /usr/bin/which ixr,
  /usr/bin/git Px -> git_root,
  /usr/bin/exo-open Pxr,
  /usr/bin/killall Pxr,
  /usr/bin/pamusb-check Pxr,
  /usr/bin/gsettings Pxr,
  /usr/bin/revdep-rebuild{,.sh} Pxr,
  /usr/bin/whoami ixr,
  /usr/bin/id ixr,
  /usr/bin/startxfce4 Pxr,
  /usr/bin/rsync ix,
  /usr/sbin/logcheck Puxr,
  /usr/sbin/aideinit Pxr,
  /usr/sbin/gdisk Pxr,
  /usr/sbin/smartctl Pxr,
  /usr/sbin/useradd Pxr,
  /usr/sbin/userdel Pxr,
  /usr/sbin/lspci Pxr,
  /usr/sbin/etc-update Pxr,
  /usr/lib64/python-exec/python-exec2 Pxr,
  /usr/local/bin/** Pxr,
  /usr/local/sbin/** Pxr,
  /etc/init.d/* Px,
  
  # FIX ME!
  /usr/bin/mc Puxr,
  /bin/nano Puxr,
  /usr/sbin/migrate-pax Puxr,
  /usr/sbin/paxctl-ng Puxr,
  /sbin/paxctl Puxr,
  
  /etc/profile.env r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
}
