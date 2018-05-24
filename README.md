# AppArmor RBAC for Gentoo Linux

This project is part of protected desktop for organization infrastructure (including diskless node infrastructure), that also include IMA/EVM (with Gentoo binhost integration), IMA+AA integration and organization's network services with client's remote attestation (that are parts of another projects and not included in this one).

### Key features:
1. Best to deploy with Secure Boot (early boot AppArmor initialization before root mount and real init are supported).
2. Best to deploy with IMA/EVM (if you can make it to work), see Matthew Garrett's patch for AA+IMA integration.
3. All system processes covered by security profiles (including started before AppArmor initialization, kernel's processes, etc).
4. Full system coverage, unconfined processes are not allowed (only confined to confined transitions are allowed).
5. Inherited processes transition (ix/Ix) not allowed for better restrictions (with several exceptions).
6. Aimed to OpenRC (systemd not supported, since it much harder to isolate).
7. RBAC with uid/fsuid on all processes transitions (no need to worry about 12 named transitions AA's limit, since all transitions are 'named' by uid).
8. Profiles grouped by Gentoo packages names for easy manipulations (see utils folder).

### Notes:
1. Gentoo sys-apps/dbus package should be revised in order to build with "--enable-apparmor" configuration flag.
2. Project based on Ubuntu kernel AppArmor sources (vanilla kernel still don't have all features).
3. Project's AA profiles required patched kernel in order to work (see patches folder) and NOT compatible with Ubuntu/Suse kernel (and vice versa).
4. Documentation on Russian, may be translated to English in future (I didn't planned make it public, and don't have time for translation now).
