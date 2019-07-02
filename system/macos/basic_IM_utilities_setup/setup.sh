#!/bin/bash

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
running "Checking homebrew..."
install_homebrew
