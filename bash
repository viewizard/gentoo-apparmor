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
  
  /bin/bash mr,
  /bin/sed ixr,
  /bin/uname ixr,
  /sbin/mdadm Pxr,
  /usr/sbin/logcheck Pxr,
  
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
  
  /dev/tty[0-9]* rw,
  
  /bin/bash ixmr,
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
  /bin/rc-status Pxr,
  /bin/sleep ixr,
  /usr/bin/which ixr,
  /usr/bin/git Pxr,
  /usr/bin/sudo Pxr,
  /usr/bin/whoami ixr,
  /usr/bin/id ixr,
  /usr/bin/startxfce4 Pxr,
  /usr/bin/clear ixr,
  /usr/bin/wine Pxr,
  /usr/bin/winecfg Pxr,
  /usr/bin/pamusb-agent Pxr,
  /usr/bin/libnotify-notify-send Pxr,
  
  /etc/profile.env r,
  /etc/bash/bash_logout r,
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
  #include <abstractions/authentication-pam_usb>
  
  capability setuid,
  capability setgid,
  capability sys_admin,
  capability chown,
  capability fsetid,
  capability fowner,
  capability sys_tty_config,
  capability kill,
  capability dac_read_search,
  capability dac_override,
  
  /bin/bash ixmr,
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
  /bin/nano ixr,
  /bin/kmod Pxr,
  /bin/cat ixr,
  /bin/dd ixr,
  /bin/ping Pxr,
  /bin/ifconfig Pxr,
  /bin/rc-status Pxr,
  /bin/date Pxr,
  /bin/tail ixr,
  /bin/netstat Pxr,
  /bin/getfacl Pxr,
  /bin/tar ixr,
  /bin/head ixr,
  /bin/tail ixr,
  /bin/getfattr ixr,
  /bin/cpio ixr,
  /bin/keyctl ixr,
  /sbin/mdadm Pxr,
  /sbin/shutdown Pxr,
  /sbin/{halt,poweroff,reboot} Pxr,
  /sbin/cryptsetup Pxr,
  /sbin/apparmor_parser Pxr,
  /sbin/paxctl ixr,
  /sbin/gradm Pxr,
  /sbin/{,c}fdisk Pxr,
  /sbin/lvm Pxr,
  /sbin/mke2fs Pxr,
  /sbin/mkswap Pxr,
  /sbin/zpool Pxr,
  /sbin/zfs Pxr,
  /sbin/rc-update Pxr,
  /sbin/fsck Pxr,
  /sbin/rc-service Pxr,
  /sbin/xtables-multi Pxr,
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
  /usr/bin/rsync ixr,
  /usr/bin/htop Pxr,
  /usr/bin/mc Pxr -> mc_root,
  /usr/bin/eselect Pxr -> eselect_root,
  /usr/bin/ntpq Pxr,
  /usr/bin/genkernel Pxr,
  /usr/bin/{,g}make Pxr,
  /usr/bin/stat Pxr,
  /usr/bin/file ixr,
  /usr/bin/lsusb Pxr,
  /usr/bin/gpg{,2,-static} Pxr,
  /usr/bin/find ixr,
  /usr/bin/pamusb-agent Pxr,
  /usr/bin/nmap Pxr,
  /usr/bin/wget Pxr -> wget_root,
  /usr/bin/man Pxr,
  /usr/bin/locale ixr,
  /usr/bin/ldd Pxr -> glibc_ldd_root,
  /usr/bin/evmctl Pxr -> ima_evm_utils_evmctl_root,
  /usr/bin/gawk ixr,
  /usr/sbin/logcheck Pxr,
  /usr/sbin/aideinit Pxr,
  /usr/sbin/gdisk Pxr,
  /usr/sbin/smartctl Pxr,
  /usr/sbin/useradd Pxr,
  /usr/sbin/userdel Pxr,
  /usr/sbin/lspci Pxr,
  /usr/sbin/etc-update Pxr,
  /usr/sbin/migrate-pax Pxr -> elfix_migrate_pax_root,
  /usr/sbin/revdep-pax Pxr -> elfix_revdep_pax_root,
  /usr/sbin/paxctl-ng ixr,
  /usr/sbin/grub-mkconfig Pxr,
  /usr/sbin/grub-install Pxr,
  /usr/sbin/perl-cleaner Pxr,
  /usr/sbin/python-updater Pxr,
  /usr/sbin/iftop Pxr,
  /usr/sbin/nettop Pxr,
  /usr/lib{,32,64}/python-exec/python-exec2 Pxr -> python_exec_root,
  /usr/local/bin/** Pxr,
  /usr/local/sbin/** Pxr,
  /etc/init.d/* Pxr,
  /usr/src/linux-[0-9]*-hardened/scripts/sign-file Pxr,
  /usr/src/IMA/certs/* Pxr,  # в профиле /etc/apparmor.d/kernel
  
  # don't use by default
  #/usr/sbin/sysctl Pxr,
  
  /etc/profile.env r,
  /etc/terminfo/l/linux r,
  /etc/terminfo/x/xterm r,
  
}
