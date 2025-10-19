riverctl rule-add ssd

# ZOOM
riverctl rule-add -app-id 'zoom' float
riverctl rule-add -app-id 'zoom' -title 'Zoom Meeting' no-float
riverctl rule-add -app-id 'zoom' -title 'Meeting' no-float

# GODOT
riverctl rule-add -app-id 'org.godotengine.Editor' float
riverctl rule-add -app-id 'org.godotengine.Editor' -title '* - Godot Engine' no-float

# THUNAR
riverctl rule-add -app-id 'Thunar' -title 'File Operation Progress' float

# FLOORP
riverctl rule-add -app-id 'floorp' tags $((1 << 0))
riverctl rule-add -app-id 'floorp' output $DP_EXTERNAL

# DISCORD
for id in discord vesktop; do
    riverctl rule-add -app-id $id tags $((1 << 8))
    riverctl rule-add -app-id $id output $DP_INTERNAL
done

# OBSIDIAN
riverctl rule-add -app-id 'obsidian' tags $((1 << 7))
riverctl rule-add -app-id 'obsidian' output $DP_INTERNAL

# SLACK
riverctl rule-add -app-id 'com.slack.Slack' tags $((1 << 8))
riverctl rule-add -app-id 'com.slack.Slack' output $DP_INTERNAL
