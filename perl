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

profile perl.h2ph@{p_root} /usr/bin/h2ph@{t_root} {
  #include <abstractions/base>
  
  # EXECUTABLES ----------------------------------------
  /usr/bin/h2ph						mr,
}
