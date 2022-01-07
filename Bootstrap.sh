#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Loading librearies
for f in ./libs/*; do source $f; done
for f in ./packages/*; do source $f; done
if [ "$(ls -A ./customs/packages/)" ]
then
    for f in ./customs/packages/*; do source $f; done
fi

# Get the sudo user
SUDO_USER=$(whoami)

# Get the OSX Version
OSX_VERS=$(sw_vers -productVersion)

# Clear Screen
/usr/bin/clear

# Title
TitleMSG

BOOTSTRAP_MODE=""

# Get the options
[ $# -eq 0 ] && Help exit
case $1 in
    -b) # Base
        BOOTSTRAP_MODE="Base";;
    -c) # Marketing
        BOOTSTRAP_MODE="Commerciale";;
    -d) # Developer
        BOOTSTRAP_MODE="Sviluppatore";;
    -h) # display Help
        Help
        exit;;
    *) # Invalid option
        ErrorMessage "ERRORE: Parametro errato"
        Help
        exit;;
esac

Message "Avvio Bootstrap Base..."

Message "Controllo e Imposto Cartella Documenti..."
InitDocuments

Message "Controllo e Imposto Ssh..."
InitSsh

Message "Controllo la presenza delle chiavi Ssh..."
InitSskKeys

Message "Controllo la presenza di HomeBrew..."
InitHomeBrew

Message "Installo i pacchetti Base..."
brew install ${PACKAGES[@]}
sudo -u $SUDO_USER brew install --cask ${CASKS[@]}

Message "Preparo i Font di defautl di sistema ..."
brew tap homebrew/cask-fonts
Message "Installo i Font Open Sans..."
brew install --cask font-open-sans
Message "Installo i Font FiraCode Nerd..."
brew install --cask font-fira-code-nerd-font

Message "Installo le App di base..."
InstallAppStore ${APPSTORE[@]}

case $BOOTSTRAP_MODE in
    Commerciale)
        Message "Avvio Bootstrap $BOOTSTRAP_MODE...";;
    Sviluppatore)
        Message "Avvio Bootstrap $BOOTSTRAP_MODE...";;
esac

Message "OSX bootstrapping done!"