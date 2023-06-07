#[[ -f ~/.cache/wal/colors.Xresources]] && xrdb -merge -I$HOME ~/.cache/wal/colors.Xresources
picom &
dunst &
wal -R
xrdb -merge ~/.cache/wal/colors.Xresources
dwmblocks &
wmname "LG3D" &
setup_wacom.sh &
exec dwm 
