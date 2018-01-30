# ------------------------------------------------------------------
#
#  Copyright (C) 2017,2018 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <local/tunables.d/>

profile perl.h2ph /usr/bin/h2ph {
  #include <abstractions/base>
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/h2ph						mr,
}

profile perl.pod2html /usr/bin/pod2html {
  #include <abstractions/base>
  #include <abstractions/perl>
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/pod2html					r,
  /bin/pwd						Px,	# sys-apps/coreutils
  
  # READS/WRITES ---------------------------------------
  /var/tmp/portage/genkernel/**/pod2htmd.tmp		rw,	# DELEGATION! make, genkernel (собираем busybox)
  /var/tmp/portage/genkernel/**/docs/**			rw,	# DELEGATION! make, genkernel (собираем busybox)
  /var/log/genkernel.log				w,	# DELEGATION! make, genkernel (собираем busybox)
}

profile perl.pod2text /usr/bin/pod2text-[0-9]*-perl-[0-9]* {
  #include <abstractions/base>
  #include <abstractions/perl>
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/pod2text-[0-9]*-perl-[0-9]*			r,
  
  # READS/WRITES ---------------------------------------
  /var/tmp/portage/genkernel/**/docs/**			rw,	# DELEGATION! make, genkernel (собираем busybox)
  /var/log/genkernel.log				w,	# DELEGATION! make, genkernel (собираем busybox)
}

profile perl.pod2man /usr/bin/pod2man-[0-9]*-perl-[0-9]* {
  #include <abstractions/base>
  #include <abstractions/perl>
  
  # PSEUDO ---------------------------------------------
  /dev/tty[0-9]*					rw,
  /dev/pts/[0-9]*					rw,
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/pod2man-[0-9]*-perl-[0-9]*			r,
  
  # READS/WRITES ---------------------------------------
  /var/tmp/portage/genkernel/**/docs/**			rw,	# DELEGATION! make, genkernel (собираем busybox)
  /var/log/genkernel.log				w,	# DELEGATION! make, genkernel (собираем busybox)
}
