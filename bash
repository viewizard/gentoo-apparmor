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
@{PROG_FOLDERS}="{@{HOME},/mnt/,/media/,@{HOME}/.gvfs/}"


profile bash_default /bin/{bash,rbash,sh} flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  
  /bin/bash r,
  /bin/sed ixr,
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


profile bash_root flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/user-systemwide-files>
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
  /bin/cut ixr,
  /bin/tty ixr,
  /bin/tr ixr,
  /bin/grep ixr,
  /bin/ps Pxr,
  /bin/env Pxr,
  /bin/sed ixr,
  /bin/gzip ixr,
  /bin/mount Pxr,
  /bin/umount Pxr,
  /bin/sleep ixr,
  /bin/passwd Pxr,
  /bin/uname ixr,
  /sbin/mdadm Pxr,
  /sbin/shutdown Pxr,
  /sbin/{halt,poweroff,reboot} Pxr,
  /sbin/cryptsetup Pxr,
  /sbin/openrc Pxr,
  /sbin/apparmor_parser Pxr,
  /usr/bin/pmount Pxr,
  /usr/bin/pumount Pxr,
  /usr/bin/startxfce4 Pxr,
  /usr/bin/which ixr,
  /usr/bin/git Px -> git_root,
  /usr/bin/exo-open Pxr,
  /usr/bin/killall Pxr,
  /usr/bin/pamusb-check Pxr,
  /usr/bin/gsettings Pxr,
  /usr/bin/revdep-rebuild{,.sh} Pxr,
  /usr/bin/whoami ixr,
  /usr/bin/id ixr,
  /usr/sbin/logcheck Puxr,
  /usr/sbin/aideinit Pxr,
  /usr/sbin/gdisk Pxr,
  /usr/sbin/smartctl Pxr,
  /usr/sbin/useradd Pxr,
  /usr/sbin/userdel Pxr,
  /usr/sbin/lspci Pxr,
  /usr/sbin/etc-update Pxr,
  /usr/local/bin/** Pxr,
  /usr/local/sbin/** Pxr,



  # FIX ME!
#  audit /etc/init.d/** Puxr,
#  audit /etc/X11/Sessions/** Puxr,
#  audit /opt/** Puxr,
#  audit /bin/** Puxr,
#  audit /sbin/** Puxr,
#  audit /usr/bin/** Puxr,
#  audit /usr/sbin/** Puxr,
#  audit /usr/libexec/** Puxr,
#  audit /usr/lib{,32,64}/** Puxr,
#  audit /lib64/rc/sh/**.sh Puxr,

  /etc/init.d/** Puxr,
  /etc/X11/Sessions/** Puxr,
  /opt/** Puxr,
  /bin/** Puxr,
  /sbin/** Puxr,
  /usr/bin/** Puxr,
  /usr/sbin/** Puxr,
  /usr/libexec/** Puxr,
  /usr/lib{,32,64}/** Puxr,
  /lib64/rc/sh/**.sh Puxr,
  
  /etc/profile.env r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
}
