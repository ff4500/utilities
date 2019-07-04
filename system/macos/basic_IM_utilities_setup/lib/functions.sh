#!/usr/bin/env bash

function check_homebrew() {
  brew_check=$(command -v brew) > /dev/null 2>&1

  if [[ $? != 0 ]]; then
    echo -e "You don't have Homebrew installed. Installing..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
    fi
  else
    echo -e "Brew is already installed"
    read -r -p "Would you like to run brew update && upgrade? [y|N] " response
    if [[ $response =~ (y|yes|Y) ]]; then
      action "Updating homebrew..."
      brew update
      ok "Homebrew updated"
      action "Upgrading brew packages..."
      brew upgrade
      ok "Brews upgraded"
    else
      ok "Skipped brew package upgrades."
    fi
  fi
}

function check_brewcask() {
  cask_check=$(command -v brew cask --version) > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    echo -e "brew-cask is not installed"
  else
    echo -e "brew-cask is installed"
  fi
}

function check_iterm2 () {
  iterm_check=$(echo $TERM_PROGRAM) > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    echo -e "You don't have iterm2 installed. Installing..."
    require_cask iterm2
  else
    echo -e "iterm2 is already installed. Moving on."
  fi
}

function check_atom () {
  atom_check=$(command -v atom) > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    echo -e "You don't have Atom installed. Installing..."
    require_cask atom
  else
    echo -e "Atom is already installed. Moving on."
  fi
}

function check_im () {
  im_check=$(command -v convert) > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    echo -e "You don't have ImageMagick installed. Installing..."
    require_brew imagemagick
  else
    echo -e "ImageMagick is already installed. Moving on."
  fi
}


# source ./echos.sh

function require_cask() {
    running "brew cask $1"
    brew cask list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew cask install $1 $2"
        brew cask install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function require_brew() {
    running "brew $1 $2"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $1 $2"
        brew install $1 $2
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}
