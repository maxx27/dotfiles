checkinstall

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install google-chrome-stable

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install sublime-text

sudo add-apt-repository multiverse
sudo apt install gconf-service

sudo apt --fix-broken install

sudo apt remove fonts-thai-tlwg
sudo apt remove fonts-kacst-one
sudo apt purge fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lklug-sinhala fonts-lohit-guru fonts-guru fonts-nanum fonts-noto-cjk fonts-takao-pgothic fonts-tibetan-machine fonts-guru-extra fonts-lao fonts-sil-padauk fonts-sil-abyssinica fonts-tlwg-* && sudo apt autoremove
sudo apt purge fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lklug-sinhala fonts-lohit-guru fonts-guru fonts-nanum fonts-noto-cjk fonts-takao-pgothic fonts-tibetan-machine fonts-guru-extra fonts-lao fonts-sil-padauk fonts-sil-abyssinica fonts-tlwg-* && sudo apt autoremove
sudo apt remove fonts-lao fonts-lklug-sinhala fonts-sil-abyssinica fonts-sil-padauk fonts-tibetan-machine fonts-thai-tlwg

sudo apt install mc
sudo apt install terminator
sudo apt install gnome-session
sudo apt unity-tweak-tool
sudo apt install unity-tweak-tool
sudo apt remove gnome-shell
sudo apt remove ubuntu-desktop
sudo apt remove gnome-desktop3-data
sudo apt-get install x11-apps
sudo apt purge nvidia*
sudo apt search dropbox
sudo apt install nautilus-dropbox
sudo apt install python-gpg
sudo apt install htop
sudo apt install net-tools
sudo apt install dos2unix
sudo apt search compiz
sudo apt install groovy
sudo apt install gradle
sudo apt install i3
sudo apt install feh
sudo apt install arandr
sudo apt install vlc
sudo apt install fonts-font-awesome
sudo apt install xserver-xorg-input-synaptics
sudo apt install lxappearance
sudo apt install ntfs-3g
sudo apt install compton
sudo apt install i3blocks
sudo apt install rxvt-unicode
sudo apt install p7zip-rar p7zip-full
sudo apt install rofi
sudo apt-get install gdebi-core
sudo apt install wine-stable
sudo apt install wine-development
sudo apt install playonlinux
sudo apt install gparted
sudo apt install minicom
sudo apt install setserial
sudo apt install picocom
sudo apt install silversearcher-ag
sudo apt install fzy
