checkinstall

fonts-powerline
https://github.com/powerline/fonts

Current:
    redshift  - f.lux for linux
    ranger    - file browser in text mode
    nautilus-dropbox  - 
    dos2unix  -
    net-tools -
    p7zip-rar p7zip-full
    silversearcher-ag - search files
    gconf-service

    xserver-xorg-input-synaptics

    i3
    feh
    arandr
    rofi
    compton
    i3blocks
    rxvt-unicode - terminal

    Fonts:
    fonts-font-awesome

    groovy
    gradle

    wine-stable
    wine-development
    playonlinux

In past:
    htop       - performance monitor
    mc         - 
    terminator - pane terminal
    python-gpg - ???
    gparted    - disk partition manager

sudo add-apt-repository multiverse
sudo apt --fix-broken install

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install google-chrome-stable

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get install sublime-text



sudo apt remove/purge
    fonts-guru
    fonts-guru-extra
    fonts-kacst
    fonts-kacst-one
    fonts-khmeros-core
    fonts-lao
    fonts-lklug-sinhala
    fonts-lohit-guru
    fonts-nanum
    fonts-noto-cjk
    fonts-sil-abyssinica
    fonts-sil-padauk
    fonts-takao-pgothic
    fonts-thai-tlwg
    fonts-tibetan-machine
    fonts-tlwg-*

sudo apt install gnome-session
sudo apt install unity-tweak-tool
sudo apt remove gnome-shell
sudo apt remove ubuntu-desktop
sudo apt remove gnome-desktop3-data
sudo apt-get install x11-apps
sudo apt purge nvidia*
vlc
lxappearance
ntfs-3g
rxvt-unicode
gdebi-core
minicom
setserial
picocom
fzy
