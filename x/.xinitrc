[[ -f ~/.cache/wal/colors.Xresources]] && xrdb -merge -I$HOME ~/.cache/wal/colors.Xresources
picom &
greenclip daemon &
wal -R
xrdb -merge ~/.cache/wal/colors.Xresources
wmname "LG3D" &
onedrivemount &
onedrive --monitor&
setup_display
exec awesome 
