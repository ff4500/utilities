#!/usr/bin/env bash

# TODO
# - Make ext var do something
# - Make images go to output dir when run

# Config
# ------------------------------------------------------------------------------
input_dir="$HOME/Desktop/append_fn"
ext="png"
output_dir="$HOME/Desktop/append_fn"

# Utilities
# ------------------------------------------------------------------------------
esc="\x1b["
reset=${esc}"39;49;00m"
red=${esc}"31;01m"
sep_color=${esc}"38;5;8m"

function sep() {
  local sized=$(stty size | awk '{print $2}')
  local len=${sized}
  local ch="-"
  local TERM_WIDTH="$(printf '%*s' "${len}" | tr ' ' "${ch}")"

  echo -e "${sep_color}${TERM_WIDTH}${reset}"
}

# Check if the output folder exists
# ------------------------------------------------------------------------------
# if [ ! -d "$output_dir" ]; then
#   mkdir -p "$output_dir"
# fi

# Check if the input folder exists. If so, cp and rename the file(s).
# ------------------------------------------------------------------------------
if [ ! -d "$input_dir" ]; then
  sep
  echo -e "  You don't have an input directory at ${red}${input_dir}${reset}."
  echo -e "  Create the directory, put your file(s) there and try again."
  sep
else
  for f in $input_dir/*.png; do
    cp "$f" "${f%.png}-x-small.png"
    cp "$f" "${f%.png}-small.png"
    cp "$f" "${f%.png}-medium.png"
    cp "$f" "${f%.png}-large.png"
    cp "$f" "${f%.png}-x-large.png"
  done
fi
