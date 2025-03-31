riverctl list-inputs | grep '^pointer-.*_Touchpad$' | while read -r input; do
    riverctl input $input natural-scroll enabled
    riverctl input $input scroll-factor 0.5
    riverctl input $input middle-emulation enabled
    riverctl input $input disable-while-typing disabled
    riverctl input $input disable-while-trackpointing enabled
done

riverctl set-repeat 50 250
