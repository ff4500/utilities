#!/usr/bin/env bash

# User configuration
# ------------------------------------------------------------------------------
#
#
#
# ------------------------------------------------------------------------------

# User specified directories (no trailing slashes!)
# ------------------------------------------------------------------------------
base_dir="./news_articles"
news_dir="${base_dir}/news"
template_dir="${base_dir}/_templates"

# Variables for functions - Don't mess with these
# ------------------------------------------------------------------------------
user_parameter="$1"
p="${user_parameter}"
