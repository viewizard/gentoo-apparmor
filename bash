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

profile bash /bin/{bash,rbash,sh} flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/user-systemwide-files>
  #include <abstractions/program-work-with-disk-rwk>


  capability setuid,
  capability sys_tty_config,
  capability kill,

  /bin/** r,
  /sbin/** r,
  /usr/bin/** r,
  /usr/sbin/** r,
  /usr/x86_64-pc-linux-gnu/** r,

  /bin/ls ix,
  /bin/ln ix,
  /bin/df ix,
  /bin/rm ix,
  /bin/cut ix,
  /bin/tty ix,
  /bin/tr ix,
  /bin/grep ix,
  /bin/ps Px,
  /bin/env Px,
  /bin/sed ix,
  /bin/gzip ix,
  /bin/mount Px,
  /bin/umount Px,
  /bin/sleep ix,
  /bin/passwd Px,
  /bin/uname ix,
  /sbin/mdadm Px,
  /sbin/shutdown Px,
  /sbin/{halt,poweroff,reboot} Px,
  /sbin/cryptsetup Px,
  /usr/bin/dircolors ix,
  /usr/bin/pmount Px,
  /usr/bin/pumount Px,
  /usr/bin/startxfce4 Px,
  /usr/bin/which ix,
  /usr/bin/git Px,
  /usr/bin/qgit4 Px,
  /usr/bin/exo-open Px,
  /usr/bin/killall Px,
  /usr/bin/pamusb-check Px,
  /usr/bin/gsettings Px,
  /usr/sbin/logcheck Pux,
  /usr/sbin/aideinit Px,
  /usr/sbin/gdisk Px,
  /usr/sbin/smartctl Px,
  /usr/sbin/useradd Px,
  /usr/sbin/userdel Px,
  /usr/local/bin/** Px,
  /usr/local/sbin/** Px,
  
  #/lib64/rc/sh/gendepends.sh Pux,


 
  # FIX ME!
#  audit /etc/init.d/** Pux,
#  audit /etc/X11/Sessions/** Pux,
#  audit /opt/** Pux,
#  audit /bin/** Pux,
#  audit /sbin/** Pux,
#  audit /usr/bin/** Pux,
#  audit /usr/sbin/** Pux,
#  audit /usr/libexec/** Pux,
#  audit /usr/lib{,32,64}/** Pux,
#  audit /lib64/rc/sh/**.sh Pux,

   /etc/init.d/** Pux,
   /etc/X11/Sessions/** Pux,
   /opt/** Pux,
   /bin/** Pux,
   /sbin/** Pux,
   /usr/bin/** Pux,
   /usr/sbin/** Pux,
   /usr/libexec/** Pux,
   /usr/lib{,32,64}/** Pux,
   /lib64/rc/sh/**.sh Pux,
   
  
  /etc/profile.env r,
  /etc/xdg/xfce4/xinitrc r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
  # apparmor_parser
  capability mac_admin,
  /proc/sys/kernel/osrelease r,
  /etc/apparmor/parser.conf r,
  /sys/kernel/security/apparmor/ r,
  /sys/kernel/security/apparmor/** r,
  /sys/kernel/security/apparmor/{.replace,.remove} w,
  /etc/apparmor.d/** r,
  
}
