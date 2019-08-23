#!/usr/bin/env bash

# Sourced colors
# ------------------------------------------------------------------------------

source ./_lib/c/esc.sh
source ./_lib/c/base.sh

# UI colors
# ------------------------------------------------------------------------------
ui_base="${bg_lightgrey}"
ui_accent_light="${fg_lightpurple}"
ui_accent_dark="${fg_darkpurple}"
ui_text_normal=""
ui_text_hl="${fg_ff4500}"
ui_text_muted="${fg_lightgrey}"
ui_dialog_bg="${bg_darkgrey_01}"
ui_highlight_bg="${bg_ff4500}"
ui_text_info="${fg_lime}"
ui_text_cmd="${fg_aqua}"

# for var in "${!ui_@}"; do
#   printf '%s=%s\n' "$var" "${!var}"
# done
