#!/bin/sh
if [ -z "${DBUS_SESSION_BUS_ADDRESS-}" ] && type dbus-launch >/dev/null; then
  eval $(dbus-launch --sh-syntax --exit-with-session)
fi
picom  &
wal -R
xrdb -merge ~/.cache/wal/colors.Xresources
dwmblocks &
wmname "LG3D" &
udiskie &
exec awesome
