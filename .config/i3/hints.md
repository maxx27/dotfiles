
# Shortcuts

    $ grep mod+ ~/.config/i3/config | grep -v '^#' | sort

$mod+Return            Run terminal
$mod+d                 Run specified command (dmenu)
$mod+Shift+u           Run setxkbmap (to switch to native languages)
$mod+Shift+q           Kill container

$mod+1..8              Switch to workspace 1..8
$mod+Shift+1..0        Move container to workspace
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

$mod+Shift+c reload    Reload config
$mod+Shift+r restart   Restart i3 inplace (preserves layout/session)
$mod+0                 Exit i3
$mod+9                 Lock screen

# Packages

    sudo apt install
        i3-gaps            # Manjaro, replaces `i3-wm`, includes `i3-nagbar`
        i3                 # Ubuntu

        # screen locker
        i3exit             # `blurlock`
        i3lock-color       # replace `i3lock`

        # status bar
        i3blocks
        volumeicon         # volumeicon

        # menu
        dmenu-manjaro      # `dmenu_recency`
        # TODO ~/.dmenurc
        morc_menu          # `morc_menu`
        bmenu              # `bmenu`
# Optional dependencies for morc_menu
#     wmutils: Spawn menu on cursor
#     xdotool: Spawn menu on cursor
#     dmenu-manjaro: Support for mouse, xft fonts and menu placing [installed]
#     rofi: Alternative frontend
#     zenity: Alternative frontend [installed]
#     rootmenu: Spawn menu by clicking desktop
        rofi               # `rofi` run menu

        # application
        zensu              # zensu (replacement for gksu)
        moc                # mocp - console player
        dunst              # notification deamon
        i3-scrot           # screenshot
        network-manager-applet # `nm-applet`
        xfce4-power-manager
        pamac-gtk          # pamac-tray
        clipit             # clipboard manager
        conky-i3           # start_conky_maia
        feh                # `feh` to change wallpaper
        nitrogen           # background browser and setter
        light              # to change monitor brightness
                           # Manjaro: light
                           # Ubuntu: build manually by ~/bin/build/light.sh
                           # xbacklight package doesn't work

        # terminal
        rxvt-unicode       # `urxvt`
        i3-scripts         # `terminal`, `fix_xcursor`

        # fonts
        fonts-font-awesome # (only Ubuntu)
        nerd-fonts-complete # (manjaro) yay -S nerd-fonts-complete
        gsfonts            # URWGothic-Book (manjaro)

        arandr             # multiple monitor configuration
        lxappearance       # configure UI (gnome application theme)


# Wallpapers

By default the following command is executed to set wallpapers:

    feh --bg-scale ~/Pictures/wallpaper/default


