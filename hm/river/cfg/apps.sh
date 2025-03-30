# XWAYLAND
for_window [shell="xwayland"] title_format "[X] %title"

# ZOOM
riverctl rule-add -app-id 'zoom' -title 'zoom' float
riverctl rule-add -app-id 'zoom' -title 'Zoom' float
riverctl rule-add -app-id 'zoom' -title 'About' float
riverctl rule-add -app-id 'zoom' -title '*Settings*' float dimensions '960x700'
riverctl rule-add -app-id 'zoom' -title 'Zoom Meeting*' no-float
riverctl rule-add -app-id 'zoom' -title '*Workplace*' no-float

# GODOT
riverctl rule-add -app_id 'org.godotengine.Editor' float
riverctl rule-add -app_id 'org.godotengine.Editor' -title '* - Godot Engine' no-float

# THUNAR
riverctl rule-add -app_id 'Thunar' -title 'File Operation Progress' float

riverctl spawn swaync
riverctl spawn waybar
