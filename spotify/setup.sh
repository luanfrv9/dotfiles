#!/usr/bin/env sh

echo "\n\n"
echo 'initializing setup for google spotify...'
echo '__________________________________________________________________________'

echo 'installing spotify...'
echo '__________________________________________________________________________'
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update -y
sudo apt install -y spotify-client