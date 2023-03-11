[[ -f ~/.cache/wal/colors.Xresources]] && xrdb -merge -I$HOME ~/.cache/wal/colors.Xresources
picom &
wal -R
xrdb -merge ~/.cache/wal/colors.Xresources
dwmblocks &
wmname "LG3D" &
onedrivemount &
exec dwm 
