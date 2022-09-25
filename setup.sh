#!/usr/bin/env sh

echo 'initializing dotfiles setup for Ubuntu...'
echo '___________________________________________'

echo 'installing git...'
sudo apt install -y git

echo 'downloading dotfiles from remote repository...'
git clone https://github.com/luanramosvicente/dotfiles.git ~/.dotfiles

# TODO: temporary pre setup for testing process
cd ./dotfiles
git checkout refactor
cd

. setup/setup-ubuntu.sh
