#!/bin/bash
sleep 3

cat > /etc/X11/xorg.conf.d/30-touchpad.conf << EOF
Section "InputClass"
        Identifier "touchpad libinput catchall"
        Driver "libinput"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
        Option "HorizontalScrolling" "on"
        Option "DisableWhileTyping" "True"
        Option "AccelProfile" "adaptive"
        Option "AccelSpeed" "0.05"
        Option "ClickMethod" "clickfinger"
        Option "MiddleEmulation" "True"
        Option "ScrollMethod" "twofinger"
#       Option "ScrollMethod" "edge"
        Option "SendEventsMode" "disabled-on-external-mouse"
EndSection
EOF

. functions.sh
printf_c " 	Finished	"
