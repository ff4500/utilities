#!/usr/bin/env bash

path="$(echo "${PWD##*/}")"
if [ $path = 'c' ]; then
  source ./esc.sh
fi

source ./_lib/functions.sh

# FF colors
# ------------------------------------------------------------------------------
# ff4500 - #ff4500
# lightpurple - #6e00ff
# darkpurple - #500096
# lightgrey - #787878
# darkgrey_01 - #3B3B3B
# darkgrey_02 - #323232
# black - #222222
# ------------------------------------------------------------------------------

# base color definitions (rgb)
# ------------------------------------------------------------------------------
base_ff4500="255;69;0m"
base_lightpurple="110;0;255m"
base_darkpurple="80;0;150m"
base_lightgrey="120;120;120m"
base_darkgrey_01="60;60;60m"
base_darkgrey_02="50;50;50m"
base_white="255;255;255m"
base_black="0;0;0m"
base_lime="0;255;0m"
base_aqua="0;255;255m"
base_red="255;0;0m"

l_grey_rgb="120;120;120m"
m_grey_rgb="80;80;80m"
d_grey_rgb="40;40;40m"

# Named colors
# ------------------------------------------------------------------------------
fg_ff4500="${esc_seq_fg}${base_ff4500}"
fg_lightpurple="${esc_seq_fg}${base_lightpurple}"
fg_darkpurple="${esc_seq_fg}${base_darkpurple}"
fg_lightgrey="${esc_seq_fg}${base_lightgrey}"
d_lightgrey="${esc_seq_fg}${base_lightgrey}"
fg_darkgrey_01="${esc_seq_fg}${base_darkgrey_01}"
fg_darkgrey_02="${esc_seq_fg}${base_darkgrey_02}"
fg_white="${esc_seq_fg}${base_white}"
fg_black="${esc_seq_fg}${base_black}"
fg_lime="${esc_seq_fg}${base_lime}"
fg_aqua="${esc_seq_fg}${base_aqua}"
fg_red="${esc_seq_fg}${base_red}"

# Named background colors
# ------------------------------------------------------------------------------
bg_ff4500="${esc_seq_fg}${c_white}${esc_seq_bg}${base_ff4500}"
bg_lightpurple="${esc_seq_fg}${c_white}${esc_seq_bg}${base_lightpurple}"
bg_darkpurple="${esc_seq_fg}${c_white}${esc_seq_bg}${base_darkpurple}"
bg_lightgrey="${esc_seq_fg}${c_white}${esc_seq_bg}${base_lightgrey}"
bg_darkgrey_01="${esc_seq_fg}${c_white}${esc_seq_bg}${base_darkgrey_01}"
bg_darkgrey_02="${esc_seq_fg}${c_white}${esc_seq_bg}${base_darkgrey_02}"
bg_white="${esc_seq_fg}${c_black}${esc_seq_bg}${base_white}"
bg_black="${esc_seq_fg}${c_white}${esc_seq_bg}${base_black}"
bg_lime="${esc_seq_fg}${c_black}${esc_seq_bg}${base_lime}"
bg_aqua="${esc_seq_fg}${c_black}${esc_seq_bg}${base_aqua}"
bg_red="${esc_seq_fg}${c_white}${esc_seq_bg}${base_red}"

# Color variations and special use cases
# ------------------------------------------------------------------------------
bg_lightpurple_w_grey="${esc_seq_fg}${c_dark_grey}${esc_seq_bg}${base_lightpurple}"
bg_lightpurple_w_blk="${esc_seq_fg}${c_black}${esc_seq_bg}${base_lightpurple}"

# Color tests - uncomment to print tests in the console
# ------------------------------------------------------------------------------

function print_ff() {
  clear
  echo
  echo -e "${fg_darkgrey_01}  -------------------------------------------------------  ${reset}"
  echo
  indent; indent; echo -e "${bg_darkpurple} Base colors: ${reset}"
  echo
  for var in "${!fg_@}"; do
    #printf '%s=%s\n' "$var" "${!var}"
    indent; indent; printf "${var} ${fg_lightgrey}(%s)${reset}: ${esc_seq_fg}${!var}${var}${reset}\n" "${!var:10}"
  done
  echo
  for var in "${!bg_@}"; do
    indent; indent; printf "${var}: ${!var} ${var} ${reset}\n"
  done
  echo
  echo -e "${fg_darkgrey_01}  --------------------------------------------------------  ${reset}"
  echo
  prompt_continue
}
if [ $path = 'c' ]; then
  print_ff
elif [ $path != 'c' ] && [ $print_colors = 'yes' ]; then
  print_ff
fi
