#!/usr/bin/env bash

# User configuration
# ------------------------------------------------------------------------------
#
#
#
# ------------------------------------------------------------------------------

# User specified directories (no trailing slashes!)
# ------------------------------------------------------------------------------
base_dir="~/Desktop/test"
source_repo_dir="repos"
output_dir="archive"
repo_list="${base_dir}/_src/repo_list.txt"

# Variables for functions - Don't mess with these
# ------------------------------------------------------------------------------
filelines="$(cat $repo_list)"
source="${base_dir}/${source_repo_dir}"
output="${base_dir}/${output_dir}"

# Debugging
# ------------------------------------------------------------------------------
print_colors="yes"

# Colors - source the colors.sh file
# ------------------------------------------------------------------------------
source ./_lib/colors.sh
