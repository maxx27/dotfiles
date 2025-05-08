fonts-powerline
https://github.com/powerline/fonts

Current:
    redshift  - f.lux for linux
    net-tools -
    docker

    xsel - copy to buffer from CLI
    nautilus-dropbox  - dropbox
    gconf-service
    xrdp - RDP access to linux
    snapd - snap

    xserver-xorg-input-synaptics

    ranger    - file browser in text mode
        python3 python3-pip
        trash-cli - delete into trash
        file
        pip3 install chardet
        atool
        mediainfo

    i3
    feh
    arandr
    rofi         - menu
    compton      - composite manager
    i3blocks     - status bar
    rxvt-unicode - terminal

    Fonts:
    fonts-font-awesome

In past:

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get install google-chrome-stable

# install powerline fonts

    # clone
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts


mkdir -p ~/src/_github
cd ~/src/_github
git clone git@github.com:magicmonty/bash-git-prompt.git --depth=1

sudo apt install gnome-session
sudo apt install unity-tweak-tool
sudo apt remove gnome-shell
sudo apt remove ubuntu-desktop
sudo apt remove gnome-desktop3-data
sudo apt-get install x11-apps
sudo apt purge nvidia*
lxappearance
ntfs-3g
rxvt-unicode
