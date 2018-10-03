
# Shortcuts

    $ grep mod+ ~/.config/i3/config | grep -v '^#'

$mod+Return            Run terminal
$mod+d                 Run specified command
$mod+Shift+u           Run setxkbmap (to switch to native languages)
$mod+Shift+q           Close container
$mod+arrows/jkl;       Navigation between containers
$mod+Shift+arrows/jkl; Move active container
$mod+h                 Insert horizontally
$mod+v                 Insert vertically
$mod+r                 Switch to resize mode (use arrows to change size)
$mod+f                 Fullscreen
$mod+s                 Switch to layout stacking
$mod+w                 Switch to layout tabbed
$mod+e                 Switch to layout toggle split
$mod+Shift+space       Toggle tiling / floating
$mod+space             Change focus between tiling / floating windows
$mod+1..0              Switch to workspace
$mod+Shift+1..0        Move container to workspace
$mod+Shift+c reload    Reload config
$mod+Shift+r restart   Restart i3 inplace (preserves layout/session)
$mod+Shift+e           Exit i3
$mod+Shift+x           Lock screen

# Packages

    sudo apt install
        i3                 # i3 itself
        i3lock             # screen locker
        fonts-font-awesome # font
        feh                # to change wallpaper
        arandr             # multiple monitor configuration
        lxappearance       # configure UI
        i3blocks           # for status bar
        rofi               # run menu
        ~xbacklight~       # to change monitor brightness (doesn't work)
        light              # build manually by ~/bin/build/light.sh

# Wallpapers

By default the following command is executed to set wallpapers:

    feh --bg-scale ~/Pictures/wallpaper/default


