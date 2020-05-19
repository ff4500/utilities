#!/usr/bin/env bash

# User configuration
# ------------------------------------------------------------------------------
#
#
#
# ------------------------------------------------------------------------------

# User specified directories (no trailing slashes!)
# ------------------------------------------------------------------------------
base_dir="$HOME/Desktop/repo_archive"
source_repo_dir="repos"
output_dir="archive"
repo_list="${base_dir}/_src/repo_list.txt"
storage_dir="/Volumes/Dump/Backups/BaM/github"

# Other config things
# ------------------------------------------------------------------------------
title="Repo archiving utility v0.02"


# Variables for functions - Don't mess with these
# ------------------------------------------------------------------------------
source="${base_dir}/${source_repo_dir}"
output="${base_dir}/${output_dir}"

# Debugging
# ------------------------------------------------------------------------------
print_colors="no"

# Colors - source the colors.sh file
# ------------------------------------------------------------------------------
source ./_lib/colors.sh
