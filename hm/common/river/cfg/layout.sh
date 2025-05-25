riverctl background-color $COLOR_BG
riverctl border-color-focused $COLOR_FOC
riverctl border-color-unfocused $COLOR_UNFOC
riverctl border-width 1

riverctl default-layout wideriver
wideriver \
  --inner-gap 13 --outer-gap 13 --no-smart-gaps \
  --border-width 1 --border-width-monocle 1 \
  --border-color-focused $COLOR_FOC \
  --border-color-focused-monocle $COLOR_FOC \
  --border-color-unfocused $COLOR_UNFOC \
  > ~/wideriver.log 2>&1 &
