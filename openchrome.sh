#!/bin/bash

if [ $(whoami) != 'root' ]; then 
	echo 'Please run as root'
	exit 1
fi

grep -e '^ID*' /etc/os-release | grep -q 'alpine'
if [ $? == 0 ]; then
	echo 'Installing packages'
	apk add chromium pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-tools wireplumber
else
	echo 'You are not running Alpine derivate.
You have to install yourself Chromium'
fi

grep -v 'CHROMIUM_FLAGS' chromium.conf > /tmp/chromium.conf
echo 'CHROMIUM_FLAGS="--ozone-platform-hint=auto --oauth2-client-id=77185425430.apps.googleusercontent.com --oauth2-client-secret=OTJgUOQcT7lO7GsGZq2G4IlT --enable-chrome-browser-cloud-management --gtk-version=4 --enable-features=TouchpadOverscrollHistoryNavigation --disable-features=FFmpegAllowLists"' >> /tmp/chromium.conf
mv /tmp/chromium.conf /etc/chromium/chromium.conf

echo 'OpenChrome installed'
exit 0
