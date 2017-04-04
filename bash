# ------------------------------------------------------------------
#
#  Copyright (C) 2016,2017 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

# На самом деле это общий профиль для shell, если будет изменен
# shell c bash на другой - переименовать в shell.

#include <tunables/global>

# config for abstractions/program-work-with-disk-** (**-rk,rwk)
@{PROG_DIR}="**"
@{PROG_FILE}="**"

# профиль используется службами без аутентификации
profile shell_service @{shell} {
  #include <abstractions/base>
  #include <abstractions/shell>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  
  # EXECUTABLES ----------------------------------------
  @{shell}						mr,
  /bin/sed						ixr,
  /bin/uname						Pxr,
  /sbin/mdadm						Pxr,
  /usr/sbin/logcheck					Pxr,
}

# профиль всех пользователей, прошедших аутентификацию
# профиль терминала по умолчанию
profile shell_users {
  #include <abstractions/base>
  #include <abstractions/shell>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk-strict>
  
  # CAPABILITIES ---------------------------------------
  capability setuid,
  capability sys_tty_config,
  capability kill,
#  capability dac_read_search,					# FIX ME! 02.04.2017, зачем было нужно - непонятно.
#  capability dac_override,					# Крайне плохо будет их разрешать, т.к. нам нужен DAC.
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  @{shell}						ixmr,
  /bin/ls						ixr,
  /bin/ln						ixr,
  /bin/df						Pxr,
  /bin/rm						ixr,
  /bin/tty						Pxr,
  /bin/grep						ixr,
  /bin/ps						Pxr,
  /bin/passwd						Pxr,
  /bin/uname						Pxr,
  /bin/su						Pxr,
  /bin/rc-status					Pxr,
  /bin/sleep						Pxr,
  /usr/bin/which					Pxr,
  /usr/bin/git						Pxr,
  /usr/bin/sudo						Pxr,
  /usr/bin/whoami					Pxr,
  /usr/bin/id						Pxr,
  /usr/bin/startx{,fce4}				Pxr,
  /usr/bin/clear					Pxr,
  /usr/bin/wine						Pxr,
  /usr/bin/winecfg					Pxr,
  /usr/bin/pamusb-agent					Pxr,	# pam_usb
  /usr/bin/libnotify-notify-send			Pxr,
  
  # READS/WRITES ---------------------------------------
  /etc/profile.env					r,
  /etc/bash/bash_logout					r,
  /etc/terminfo/l/linux					r,
  /etc/terminfo/x/xterm					r,
}

# профиль специального пользователя root
profile shell_root {
  #include <abstractions/base>
  #include <abstractions/shell>
  #include <abstractions/consoles>
  #include <abstractions/nameservice>
  #include <abstractions/program-work-with-disk-rwk>
  #include <abstractions/user-systemwide-files>
  #include <abstractions/authentication-pam_usb>
  
  # CAPABILITIES ---------------------------------------
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
  
  # EXECUTABLES ----------------------------------------
  @{shell}						ixmr,
  /bin/ls						ixr,
  /bin/ln						ixr,
  /bin/df						Pxr,
  /bin/rm						ixr,
  /bin/cut						ixr,
  /bin/tty						Pxr,
  /bin/tr						Pxr,
  /bin/grep						ixr,
  /bin/ps						Pxr,
  /bin/env						ixr,
  /bin/sed						ixr,
  /bin/gzip						ixr,
  /bin/mount						Pxr,
  /bin/umount						Pxr,
  /bin/sleep						Pxr,
  /bin/passwd						Pxr,
  /bin/uname						Pxr,
  /bin/su						Pxr,
  /bin/cp						ixr,
  /bin/mv						ixr,
  /bin/chown						ixr,
  /bin/chmod						ixr,
  /bin/nano						ixr,
  /bin/kmod						Pxr,
  /bin/cat						ixr,
  /bin/dd						ixr,
  /bin/ping						Pxr,
  /bin/ifconfig						Pxr,
  /bin/rc-status					Pxr,
  /bin/date						Pxr,
  /bin/tail						ixr,
  /bin/netstat						Pxr,
  /bin/getfacl						Pxr,
  /bin/tar						ixr,
  /bin/head						ixr,
  /bin/tail						ixr,
  /bin/getfattr						ixr,
  /bin/setfattr						ixr,
  /bin/cpio						ixr,
  /bin/keyctl						ixr,
  /bin/mkdir						ixr,
  /bin/touch						ixr,
  /bin/lsblk						ixr,
  /sbin/mdadm						Pxr,
  /sbin/shutdown					Pxr,
  /sbin/{halt,poweroff,reboot}				Pxr,
  /sbin/cryptsetup					Pxr,
  /sbin/apparmor_parser					Pxr,
  /sbin/paxctl						ixr,
  /sbin/gradm						Pxr,
  /sbin/{,c}fdisk					Pxr,
  /sbin/lvm						Pxr,
  /sbin/mke2fs						Pxr,
  /sbin/mkswap						Pxr,
  /sbin/zpool						Pxr,
  /sbin/zfs						Pxr,
  /sbin/rc-update					Pxr,
  /sbin/fsck						Pxr,
  /sbin/rc-service					Pxr,
  /sbin/xtables-multi					Pxr,
  /sbin/blkid						Pxr,
  /usr/bin/which					Pxr,
  /usr/bin/git						Pxr -> git_root,
  /usr/bin/exo-open					Pxr,
  /usr/bin/killall					Pxr,
  /usr/bin/gsettings					Pxr,
  /usr/bin/revdep-rebuild{,.sh}				Pxr,
  /usr/bin/whoami					Pxr,
  /usr/bin/id						Pxr,
  /usr/bin/rsync					ixr,
  /usr/bin/htop						Pxr,
  /usr/bin/mc						Pxr -> mc_root,
  /usr/bin/eselect					Pxr,
  /usr/bin/ntpq						Pxr,
  /usr/bin/genkernel					Pxr,
  /usr/bin/{,g}make					Pxr,
  /usr/bin/stat						Pxr,
  /usr/bin/file						ixr,
  /usr/bin/lsusb					Pxr,
  /usr/bin/gpg{,2,-static}				Pxr,
  /usr/bin/find						ixr,
  /usr/bin/pamusb-check					Pxr,	# pam_usb
  /usr/bin/pamusb-agent					Pxr,	# pam_usb
  /usr/bin/nmap						Pxr,
  /usr/bin/wget						Pxr -> wget_root,
  /usr/bin/man						Pxr,
  /usr/bin/locale					ixr,
  /usr/bin/ldd						Pxr,
  /usr/bin/evmctl					Pxr,
  /usr/bin/gawk						ixr,
  /usr/bin/patch					ixr,
  /usr/bin/diff						ixr,
  /usr/bin/gcc-config					Pxr,
  /usr/sbin/logcheck					Pxr,
  /usr/sbin/aideinit					Pxr,
  /usr/sbin/gdisk					Pxr,
  /usr/sbin/smartctl					Pxr,
  /usr/sbin/useradd					Pxr,
  /usr/sbin/userdel					Pxr,
  /usr/sbin/lspci					Pxr,
  /usr/sbin/etc-update					Pxr,
  /usr/sbin/migrate-pax					Pxr,
  /usr/sbin/revdep-pax					Pxr,
  /usr/sbin/paxctl-ng					ixr,
  /usr/sbin/grub-mkconfig				Pxr,
  /usr/sbin/grub-install				Pxr,
  /usr/sbin/perl-cleaner				Pxr,
  /usr/sbin/python-updater				Pxr,
  /usr/sbin/iftop					Pxr,
  /usr/sbin/nettop					Pxr,
  /usr/sbin/firewall					Pxr,
  /usr/sbin/sysctl					Pxr,
  @{PYTHON_EXEC_WRAPPER}				Pxr -> python_exec_root,
  /usr/local/bin/**					Pxr,
  /usr/local/sbin/**					Pxr,
  /etc/init.d/*						Pxr,
  /usr/src/@{kernel}/scripts/*				Pxr,	# в профиле /etc/apparmor.d/kernel
  /usr/src/IMA/certs/*					Pxr,	# в профиле /etc/apparmor.d/kernel
  
  # AUDIT EXECUTABLES ----------------------------------
  audit deny /usr/bin/startx*				x,	# RBAC! Запрещаем запуск Xorg-server под root. У нас
  								# нет полноценной ветки профилей для запуска всех
  								# дочерних процессов.
  
  # READS/WRITES ---------------------------------------
  /etc/profile.env					r,
  /etc/terminfo/l/linux					r,
  /etc/terminfo/x/xterm					r,
}
