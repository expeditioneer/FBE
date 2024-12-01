#!/usr/bin/env bash

# Workaround, see
# https://bugs.gentoo.org/680456
FEATURES="protect-owned -collision-protect -ipc-sandbox -network-sandbox -pid-sandbox" emerge $@