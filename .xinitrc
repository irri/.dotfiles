# .xinitrc

setxkbmap -layout se
xsetroot -cursor_name left_ptr

# xloadimage -onroot -fullscreen ~/.bg/masterpiece.png
feh --bg-scale ~/.bg/tokyo1.jpg

xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

# activate numlock
numlockx &

# To make urxvt use .Xresources
xrdb -merge ~/.Xresources

# Composite manager (used for transparancy in urxvt)
xcompmgr &

urxvt &
google-chrome &
skype &
spotify &
transmission-gtk &

exec xmonad
