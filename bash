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
  #include <abstractions/user-tmp>
#  #include <abstractions/user-systemwide-files>
#  #include <abstractions/program-work-with-disk-rwk>

  capability sys_tty_config,
  capability setuid,
  capability kill,
  capability sys_ptrace,
  capability dac_override,
  
  @{PROC}/@{pid}/fd/ r,
  
  /bin/bash Pxr,
  /usr/bin/qgit4 Px,
  /sbin/{halt,poweroff,reboot} Px,
  /sbin/shutdown Px,
  /usr/bin/xautolock Px,
  
  # FIX ME!
  /etc/acpi/default.sh Pux,
  /bin/tail Pux,
  /bin/date Pux,
  /bin/sed Puxr,
  /bin/grep Puxr,
  /bin/cut Pux,
  /bin/tty Pux,
  /bin/cat Puxr,
  /bin/head Puxr,
  /bin/egrep Pux,
  /bin/rm Pux,
  /bin/gzip Pux,
  /bin/uname Puxr,
  /bin/env Pux,
  /bin/su Pux,
  /bin/ls mix, # <abstractions/bash>
  /bin/mktemp Puxr,
  /bin/expr Pux,
  /bin/basename Pux,
  /bin/dirname Pux,
  /bin/sort Pux,
  /bin/mv Pux,
  /bin/rmdir Pux,
  /bin/mkdir Pux,
  /bin/chmod Pux,
  /bin/hostname Puxr,
  /bin/bzip2 Puxr,
  /bin/tar Puxr,
  /bin/sort Puxr,
  /sbin/apparmor_parser Pux,
  /sbin/mdadm Pux,
  /sbin/blkid Pux,
  /sbin/ldconfig Puxr,
  /usr/bin/cal Pux,
  /usr/bin/sensors Pux,
  /usr/bin/pumount Pux,
  /usr/bin/iceauth Pux,
  /usr/bin/pmount Pux,
  /usr/bin/git Pux,
  /usr/bin/pamusb-check Pux,
  /usr/bin/dircolors mix, # <abstractions/bash>
  /usr/bin/startxfce4 Pux,
  /usr/bin/xkbcomp Pux,
  /usr/bin/which Puxr,
  /usr/bin/xdg-user-dirs-update Pux,
  /usr/bin/xrdb Pux,
  /usr/bin/xfce4-session Pux,
  /usr/bin/gksu Pux,
  /usr/bin/m4 Puxr,
  /usr/bin/c++ Pux,
  /usr/bin/x86_64-pc-linux-gnu-gcc Puxr,
  /usr/bin/x86_64-pc-linux-gnu-g++ Puxr,
  /usr/bin/cc Pux,
  /usr/bin/gmake Puxr,
  /usr/bin/uniq Puxr,
  /usr/bin/perl Puxr,
  /usr/bin/diff Puxr,
  /usr/bin/xargs Puxr,
  /usr/sbin/run-crons Pux,
  /usr/sbin/logcheck Pux,
  /usr/lib64/python-exec/python-exec2 Pux,
  /usr/lib64/portage/python2.7/misc-functions.s Pux,
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/readelf Puxr,
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/ar Puxr,
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/nm Puxr,
  /lib64/rc/sh/gendepends.sh Pux,
  
  # for portage only (!)
  owner /var/tmp/portage/** Uxrw,
  
  # FIX ME!
  audit /etc/X11/Sessions/** Pux,
  audit /opt/** Pux,
#  audit /bin/** Pux,
#  audit /sbin/** Pux,
#  audit /usr/bin/** Pux,
#  audit /usr/sbin/** Pux,
  audit /usr/local/bin/** Pux,
  audit /usr/local/sbin/** Pux,
  audit /usr/libexec/** Pux,
  audit /usr/lib{,32,64}/** Pux,
  audit /usr/share/hplip/** Pux,
  
  
  /etc/profile.env r,
  /etc/bash/bashrc r,
  /etc/bash/bashrc.d/ r,
  /etc/bash/bash_logout r,
  /etc/xdg/xfce4/xinitrc r,
  /etc/terminfo/x/xterm r,
  
  owner @{HOME}/.session.log w,
  
  /usr/portage/distfiles/.__portage_test_write__ w,
  /usr/share/sandbox/sandbox.bashrc r,
  
  # apparmor_parser
  capability mac_admin,
  /proc/sys/kernel/osrelease r,
  /etc/apparmor/parser.conf r,
  /sys/kernel/security/apparmor/ r,
  /sys/kernel/security/apparmor/** r,
  /sys/kernel/security/apparmor/{.replace,.remove} w,
  /etc/apparmor.d/** r,
  
}
