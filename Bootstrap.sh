#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_URL="git@github.com:TTlab-Azienda-AdAttiva/TT-lab-OSX-dotfiles.git"
REPO_PATH="$HOME/Documents/Privata/dotfiles"

# Loading librearies
for f in ./libs/*; do source $f; done
for f in ./packages/*; do source $f; done

# Get the sudo user
SUDO_USER=$(whoami)

# Get the OSX Version
OSX_VERS=$(sw_vers -productVersion)

# Clear Screen
/usr/bin/clear

# Avvio Bootstrap
start

# Controllo e Imposto Cartella Documenti
documents

# Controllo e Imposto Ssh
initssh

# Controllo la presenza delle chiavi Ssh
initsskeys

# Controllo la presenza di HomeBrew
initxcode
inithomebrew
initdotfiles

# Installo i pacchetti Base
install_packages

# installo oh-my-zsh
install_oh_my_zsh

# Message "Installo le App di base..."
# for app in ${APPSTORE[@]};
# do
#     InstallAppStore $app
# done

# fonts install
install_fonts

# Set OSX
setmacos

# Install MacOS Apps
install_apps

info "OSX Base bootstrapping done!"