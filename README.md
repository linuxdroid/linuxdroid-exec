# linuxdroid-exec
A `execve()` wrapper to fix problem with shebangs when running in Linuxdroid.

# Problem
A lot of Linux software is written with the assumption that `/bin/sh`, `/usr/bin/env`
and similar file exists. This is not the case on Android where neither `/bin/` nor `/usr/`
exists.

When building packages for Linuxdroid those hard-coded assumptions are patched away - but this
does not help with installing scripts and programs from other sources than Linuxdroid packages.

# Solution
Create an `execve()` wrapper that rewrites calls to execute files under `/bin/` and `/usr/bin`
into the matching Linuxdroid executables under `$PREFIX/bin/` and inject that into processes
using `LD_PRELOAD`.

# How to install
1. Install with `pkg install linuxdroid-exec`.
2. Exit your current session and start a new one.
3. From now on shebangs such as `/bin/sh` and `/usr/bin/env python` should work.

# Where is LD_PRELOAD set?
The `$PREFIX/bin/login` program which is used to create new Linuxdroid sessions checks for
`$PREFIX/lib/liblinuxdroid-exec.so` and if so sets up `LD_PRELOAD` before launching the login shell.
