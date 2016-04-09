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

  /bin/** r,
  /sbin/** r,
  /usr/bin/** r,
  /usr/sbin/** r,
  /usr/x86_64-pc-linux-gnu/** r,

  /bin/bash Px,
  /bin/passwd Pxr,
  /bin/ping Px,
  /bin/env Px,
  /bin/mount Px,
  /bin/umount Px,
  /sbin/{halt,poweroff,reboot} Px,
  /sbin/shutdown Px,
  /usr/bin/newgrp Px,
  /usr/bin/mate-screensaver-command Px,
  /usr/bin/exo-open Px,
  /usr/bin/xautolock Px,
  /usr/bin/qgit4 Px,
  /usr/lib64/python-exec/python-exec2 Px,
  /usr/local/bin/* Px,
  /usr/local/sbin/* Px,
  
  # FIX ME!
  /etc/acpi/default.sh Pux,
  /etc/init.d/dbus Pux,
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
  /bin/uname pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /bin/su Pux,
  /bin/ls mix, # <abstractions/bash>
  /bin/mktemp Pux,
  /bin/expr Pux,
  /bin/basename Pux,
  /bin/dirname Pux,
  /bin/sort Pux,
  /bin/mv Pux,
  /bin/rmdir Pux,
  /bin/mkdir Pux,
  /bin/chmod Pux,
  /bin/hostname Pux,
  /bin/bzip2 Pux,
  /bin/tar Pux,
  /bin/sort Pux,
  /bin/ps Pux,
  /bin/tr Pux,
  /bin/nano Pux,
  /bin/ln Pux,
  /bin/sleep Pux,
  /sbin/apparmor_parser Pux,
  /sbin/mdadm Pux,
  /sbin/blkid Pux,
  /sbin/ldconfig pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
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
  /usr/bin/which Pux,
  /usr/bin/xdg-user-dirs-update Pux,
  /usr/bin/xrdb Pux,
  /usr/bin/xfce4-session Pux,
  /usr/bin/gksu Pux,
  /usr/bin/m4 Pux,
  /usr/bin/c++ Pux,
  /usr/bin/x86_64-pc-linux-gnu-gcc pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /usr/bin/x86_64-pc-linux-gnu-g++ pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /usr/bin/cc Pux,
  /usr/bin/gmake Pux,
  /usr/bin/uniq Pux,
  /usr/bin/perl Pux,
  /usr/bin/diff Pux,
  /usr/bin/xargs Pux,
  /usr/bin/emerge-webrsync Pux,
  /usr/bin/cmake pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /usr/bin/gawk Pux,
  /usr/bin/autom4te-2.69 Pux,
  /usr/bin/msgfmt Pux,
  /usr/bin/xsltproc Pux,
  /usr/bin/sdl-config Pux,
  /usr/bin/freetype-config Pux,
  /usr/bin/killall Pux,
  /usr/bin/gsettings Pux,
  /usr/bin/pamusb-agent Pux,
  /usr/sbin/run-crons Pux,
  /usr/sbin/logcheck Pux,
  /usr/sbin/migrate-pax Pux,
  /usr/lib64/portage/python2.7/misc-functions.sh pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /usr/lib64/portage/python2.7/ebuild.sh pux, #! px ! - ERROR: ld.so: object 'libsandbox.so' from LD_PRELOAD cannot be preloaded
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/readelf Pux,
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/ar Pux,
  /usr/x86_64-pc-linux-gnu/binutils-bin/*/nm Pux,
  /lib64/rc/sh/gendepends.sh Pux,
  
  # for portage only (!)
  /var/tmp/portage/** rwmklUx,
  
  # FIX ME!
#  audit /etc/X11/Sessions/** Pux,
#  audit /opt/** Pux,
#  audit /bin/** pux,
#  audit /sbin/** pux,
#  audit /usr/bin/** pux,
#  audit /usr/sbin/** pux,
#  audit /usr/libexec/** Pux,
#  audit /usr/lib{,32,64}/** pux,  
 
  
  /etc/profile.env r,
  /etc/bash/bashrc r,
  /etc/bash/bashrc.d/ r,
  /etc/bash/bash_logout r,
  /etc/xdg/xfce4/xinitrc r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
  /etc/ld.so.conf.d/ r,
  
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
