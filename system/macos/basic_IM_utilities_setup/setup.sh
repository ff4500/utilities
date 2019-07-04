#!/usr/bin/env bash

# Install Homebrew
# ----------------------------------------------------------------
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#
# Install iterm2 and Atom
# ----------------------------------------------------------------
# brew cask install iterm2 atom
#
# Install ImageMagick
# ----------------------------------------------------------------
# brew install imagemagick

source ./lib/echos.sh
source ./lib/functions.sh

opening_title

# Install Homebrew
# ----------------------------------------------------------------
running "Checking on Homebrew..."
check_homebrew

seperator

# Install Homebrew Cask (for non-brew applications)
# ----------------------------------------------------------------
running "Checking on Homebrew Casks..."
check_brewcask

seperator

check_iterm2

seperator

check_atom

seperator

check_im
