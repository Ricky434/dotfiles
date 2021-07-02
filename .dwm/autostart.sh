#!/bin/bash
xinput --set-prop "Logitech G203 Prodigy Gaming Mouse" 'libinput Accel Profile Enabled' 0, 1
nitrogen --restore
dunst&
dwmblocks &
picom --config ~/.config/picom/picom-dwm.conf &
/usr/lib/polkit-kde-authentication-agent-1 &
pkill redshift-gtk; redshift-gtk -t 6500:4700 &
nm-applet --indicator&
pasystray;
