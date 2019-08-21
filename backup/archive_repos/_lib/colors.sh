#!/usr/bin/env bash

# Sourced colors
# ------------------------------------------------------------------------------

source ./_lib/c/esc.sh
source ./_lib/c/base.sh

# UI colors
# ------------------------------------------------------------------------------
ui_base="${lightgrey_bg}"
ui_accent_light="${lightpurple}"
ui_accent_dark="${darkpurple}"
ui_text_normal=""
ui_text_muted="${lightgrey}"
ui_dialog_bg="${darkgrey_bg}"

# for var in "${!ui_@}"; do
#   printf '%s=%s\n' "$var" "${!var}"
# done
