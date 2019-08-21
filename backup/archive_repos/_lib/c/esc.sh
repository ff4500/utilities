#!/usr/bin/env bash

# Color escape sequences - Required
# ------------------------------------------------------------------------------
esc_seq="\x1b["
reset="${esc_seq}39;49;00m"

# Color escape sequences - Required for RGB colors
# ------------------------------------------------------------------------------
esc_seq_fg="\x1b[38;2;"
esc_seq_bg="\x1b[48;2;"

# RGB black/white/grey base definitions - Required for RGB colors
# ------------------------------------------------------------------------------
c_black="0;0;0m"
c_white="255;255;255m"
c_light_grey="120;120;120m"
c_medium_grey="80;80;80m"
c_dark_grey="40;40;40m"

# Set variables for black/white foreground colors - Required for RGB colors
# ------------------------------------------------------------------------------
blk_fg="${esc_seq_fg}${c_black}"
wht_fg="${esc_seq_fg}${c_white}"
