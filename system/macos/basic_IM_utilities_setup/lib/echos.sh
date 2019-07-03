#!//bin/bash

# ---------------------------------------------------------------------------- #
#   Colorized echo helpers and functions
#   Original work based on the echos.sh script by @author Adam Eivy:
#   https://github.com/atomantic/dotfiles/blob/master/lib_sh/echos.sh
# ---------------------------------------------------------------------------- #

# Colors
# ----------------------------------------------------------------
ESC_SEQ="\x1b["
COL_RESET=${ESC_SEQ}"39;49;00m"
COL_RED=${ESC_SEQ}"31;01m"
COL_GREEN=${ESC_SEQ}"32;01m"
COL_YELLOW=${ESC_SEQ}"33;01m"
COL_BLUE=${ESC_SEQ}"34;01m"
COL_MAGENTA=${ESC_SEQ}"35;01m"
COL_CYAN=${ESC_SEQ}"36;01m"
SEP_COLOR=${ESC_SEQ}"36;01m"

COL_DIM=${ESC_SEQ}"2;49;90m"
SEP_COLOR_DIM=${ESC_SEQ}"38;5;8m"
DIMDOTS=${ESC_SEQ}"2;49;90m..."${COL_RESET}

COL_PURPLE_BG=${ESC_SEQ}"38;2;0;0;0m"${ESC_SEQ}"48;2;110;0;255m"

# Variables
# ----------------------------------------------------------------
columns="$(tput cols)"
ov_sep="-------------------------------------------------"
open_vers_1="MacOS install script - v0.0.1"
open_vers_2="via https://github.com/ff4500/utilities"
open_title="We're going to run some tests to see what you already have setup on your system."

function ok() {
  echo -e "${COL_GREEN}[ok]${COL_RESET}" $1
}

function bot() {
  echo -e "\n${COL_GREEN}\[._.]/${COL_RESET} -" $1
}

function running() {
  echo -e "${COL_YELLOW} ⇒ ${COL_RESET}" $1 ": "
}

function action() {
  echo -e "\n${COL_YELLOW}[action]:${COL_RESET}\n ⇒ $1..."
}

function warn() {
  echo -e "${COL_YELLOW}[warning]${COL_RESET}" $1
}

function error() {
  echo -e "${COL_RED}[error]${COL_RESET}" $1
}

function seperator() {
  local sized=$(stty size | awk '{print $2}')
  local len=${sized}
  local ch="-"
  local TERM_WIDTH="$(printf '%*s' "${len}" | tr ' ' "${ch}")"

  echo -e "${SEP_COLOR}${TERM_WIDTH}${COL_RESET}"
}

function display_center() {
  while IFS= read -r line; do
    printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
  done < "$1"
}

function opening_title() {
  echo -e "${SEP_COLOR_DIM}"
  printf "%*s\n" $(((${#ov_sep}+$columns)/2)) "$ov_sep"
  printf "%*s\n" $(((${#open_vers_1}+$columns)/2)) "$open_vers_1"
  printf "%*s\n" $(((${#open_vers_2}+$columns)/2)) "$open_vers_2"
  printf "%*s\n" $(((${#ov_sep}+$columns)/2)) "$ov_sep"
  echo -e "${COL_RESET}";
  seperator
  printf "%*s\n" $(((${#open_title}+$columns)/2)) "$open_title"
  seperator
}
