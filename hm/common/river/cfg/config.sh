for input in $(riverctl list-inputs | grep -i touchpad); do
    riverctl input $input natural-scroll enabled
    riverctl input $input scroll-factor 0.2
    riverctl input $input click-method clickfinger
    riverctl input $input middle-emulation enabled
    riverctl input $input disable-while-typing disabled
    riverctl input $input disable-while-trackpointing enabled
done

riverctl set-repeat 50 250
riverctl focus-follows-cursor normal
riverctl set-cursor-warp on-output-change
riverctl default-attach-mode below
