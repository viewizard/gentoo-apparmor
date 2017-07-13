# ------------------------------------------------------------------
#
#  Copyright (C) 2017 Mikhail Kurinnoi
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 of the GNU General Public
#  License published by the Free Software Foundation.
#
# ------------------------------------------------------------------

#include <tunables/global>

profile perl.h2ph /usr/bin/h2ph flags=(complain) {
  #include <abstractions/base>
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/h2ph						mr,
}