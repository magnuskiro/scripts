~/repos/scripts/docking.sh
sleep 1

xscreensaver-command -lock &&
dbus-send --system --print-reply --dest=org.freedesktop.Hal \
    /org/freedesktop/Hal/devices/computer \
    org.freedesktop.Hal.Device.SystemPowerManagement.Suspend int32:0 \

