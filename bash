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
#@{PROG_DIR}="[^.]**"
#@{PROG_FILE}="[^.]*"
#@{PROG_FOLDERS}="{@{HOME},/mnt/,/media/,@{HOME}/.gvfs/}"

profile bash /bin/{bash,rbash,sh} flags=(complain) {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
#  #include <abstractions/user-systemwide-files>
#  #include <abstractions/program-work-with-disk-rwk>

  capability sys_tty_config,
  capability setuid,
  
  /bin/bash r,
  
  # FIX ME!
  /etc/acpi/default.sh Pux,
  /bin/tail Pux,
  /bin/date Pux,
  /bin/sed Pux,
  /bin/grep Pux,
  /bin/cut Pux,
  /bin/tty Pux,
  /bin/cat Pux,
  /bin/head Pux,
  /bin/egrep Pux,
  /bin/rm Pux,
  /bin/gzip Pux,
  /sbin/apparmor_parser Pux,
  /sbin/mdadm Pux,
  /sbin/blkid Pux,
  /usr/bin/cal Pux,
  /usr/bin/sensors Pux,
  /usr/bin/pumount Pux,
  /usr/bin/iceauth Pux,
  /usr/bin/pmount Pux,
  /bin/ls mix, # <abstractions/bash>
  /usr/bin/dircolors mix, # <abstractions/bash>
  /usr/bin/startxfce4 Pux,
  /usr/bin/xkbcomp Pux,
  /usr/bin/which Pux,
  /usr/bin/xdg-user-dirs-update Pux,
  /usr/bin/xrdb Pux,
  /usr/bin/xfce4-session Pux,
  /usr/bin/gksu Pux,
  /usr/sbin/run-crons Pux,
  /usr/sbin/logcheck Pux,
  /usr/lib64/python-exec/python-exec2 Pux,
  
  # FIX ME!
  audit /etc/X11/Sessions/** Pux,
  audit /opt/** Pux,
#  audit /bin/** Pux,
  audit /sbin/** Pux,
#  audit /usr/bin/** Pux,
  audit /usr/sbin/** Pux,
  audit /usr/local/bin/** Pux,
  audit /usr/local/sbin/** Pux,
  audit /usr/libexec/** Pux,
  audit /usr/lib{,32,64}/** Pux,
  audit /usr/share/hplip/** Pux,
  
  
  /etc/profile.env r,
  /etc/bash/bashrc r,
  /etc/bash/bashrc.d/ r,
  /etc/xdg/xfce4/xinitrc r,
  /etc/terminfo/x/xterm r,
  
  owner @{HOME}/.session.log w,
  
  # apparmor_parser
  capability mac_admin,
  /proc/sys/kernel/osrelease r,
  /etc/apparmor/parser.conf r,
  /sys/kernel/security/apparmor/ r,
  /sys/kernel/security/apparmor/** r,
  /sys/kernel/security/apparmor/{.replace,.remove} w,
  /etc/apparmor.d/** r,
  
}
