riverctl map normal Super Return spawn wezterm
riverctl map normal Super+Shift Q close
riverctl map normal Super+Shift E exit

riverctl map normal Super D spawn 'tofi-run --output=$(river-bedload -print outputs | jq -r '\''.[] | select(.focused) | .name'\'') | xargs riverctl spawn'
riverctl map normal Super+Shift D spawn 'tofi-drun --output=$(river-bedload -print outputs | jq -r '\''.[] | select(.focused) | .name'\'') | xargs riverctl spawn'

riverctl map normal Super+Shift N spawn 'swaync-client -t -sw'

riverctl map normal Super J focus-view next
riverctl map normal Super K focus-view previous

riverctl map normal Super+Shift J swap next
riverctl map normal Super+Shift K swap previous

riverctl map normal Super Period focus-output next
riverctl map normal Super Comma focus-output previous

riverctl map normal Super+Shift Period send-to-output next
riverctl map normal Super+Shift Comma send-to-output previous

riverctl map normal Super Space zoom

riverctl map normal Super W send-layout-cmd wideriver '--layout monocle'
riverctl map normal Super S send-layout-cmd wideriver '--layout left --stack dwindle --ratio 0.5'
riverctl map normal Super E send-layout-cmd wideriver '--layout left --stack even --ratio 0.7'
riverctl map normal Super Up    send-layout-cmd wideriver '--layout top'
riverctl map normal Super Right send-layout-cmd wideriver '--layout right'
riverctl map normal Super Down  send-layout-cmd wideriver '--layout bottom'
riverctl map normal Super Left  send-layout-cmd wideriver '--layout left'

riverctl map normal Super H send-layout-cmd wideriver '--ratio -0.1'
riverctl map normal Super L send-layout-cmd wideriver '--ratio +0.1'

riverctl map normal Super+Shift H send-layout-cmd wideriver '--count +1'
riverctl map normal Super+Shift L send-layout-cmd wideriver '--count -1'

riverctl declare-mode move
riverctl declare-mode resize

for mode in normal resize; do
    riverctl map $mode Super M enter-mode move
done
riverctl map move Super M enter-mode normal
riverctl map move None Escape enter-mode normal
riverctl map move None H move left 100
riverctl map move None J move down 100
riverctl map move None K move up 100
riverctl map move None L move right 100

for mode in normal move; do
    riverctl map $mode Super R enter-mode resize
done
riverctl map resize Super R enter-mode normal
riverctl map resize None Escape enter-mode normal
riverctl map resize None H resize horizontal -100
riverctl map resize None J resize vertical 100
riverctl map resize None K resize vertical -100
riverctl map resize None L resize horizontal 100

riverctl map-pointer normal Super BTN_LEFT move-view
riverctl map-pointer normal Super BTN_RIGHT resize-view
riverctl map-pointer normal Super BTN_MIDDLE toggle-float

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))
    riverctl map normal Super $i set-focused-tags $tags
    riverctl map normal Super+Shift $i set-view-tags $tags
    riverctl map normal Super+Control $i toggle-focused-tags $tags
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
done

all_tags=$(((1 << 32) - 1))
riverctl map normal Super 0 set-focused-tags $all_tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags

riverctl map normal Super+Shift Space toggle-float
riverctl map normal Super F toggle-fullscreen

riverctl map normal None Print spawn 'flameshot screen'
riverctl map normal Shift Print spawn 'flameshot gui'

riverctl declare-mode passthrough
riverctl map normal Super F11 enter-mode passthrough
riverctl map passthrough Super F11 enter-mode normal

for mode in normal locked
do
    riverctl map $mode None XF86Eject spawn 'eject -T'

    riverctl map $mode None XF86AudioRaiseVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+'
    riverctl map $mode None XF86AudioLowerVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-'
    riverctl map $mode None XF86AudioMute         spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'

    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

    riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 10'
    riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 10'
done
