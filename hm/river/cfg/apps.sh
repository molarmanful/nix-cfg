riverctl rule-add ssd

# ZOOM
riverctl rule-add -app-id 'zoom' -title 'zoom' float
riverctl rule-add -app-id 'zoom' -title 'Zoom' float
riverctl rule-add -app-id 'zoom' -title 'About' float
riverctl rule-add -app-id 'zoom' -title '*Settings*' float
riverctl rule-add -app-id 'zoom' -title '*Settings*' dimensions 960 700
riverctl rule-add -app-id 'zoom' -title 'Zoom Meeting*' no-float
riverctl rule-add -app-id 'zoom' -title '*Workplace*' no-float

# GODOT
riverctl rule-add -app-id 'org.godotengine.Editor' float
riverctl rule-add -app-id 'org.godotengine.Editor' -title '* - Godot Engine' no-float

# THUNAR
riverctl rule-add -app-id 'Thunar' -title 'File Operation Progress' float

# FLOORP
riverctl rule-add -app-id 'floorp' tags $((1 << 0))
riverctl rule-add -app-id 'floorp' output eDP-1

# DISCORD
for id in discord vesktop; do
    riverctl rule-add -app-id $id tags $((1 << 8))
    riverctl rule-add -app-id $id output DP-9
done

# OBSIDIAN
riverctl rule-add -app-id 'obsidian' tags $((1 << 7))
riverctl rule-add -app-id 'obsidian' output DP-9

# FLAMESHOT
riverctl rule-add -app-id 'flameshot' -title 'Save screenshot' float
