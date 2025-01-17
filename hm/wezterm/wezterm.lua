local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.front_end = "WebGpu"
cfg.webgpu_power_preference = "HighPerformance"
cfg.scrollback_lines = 5000

cfg.color_scheme = "nightfox"
cfg.colors = {
	background = "black",
	tab_bar = {
		background = "#000000",
		active_tab = {
			bg_color = "black",
			fg_color = "white",
		},
		inactive_tab = {
			bg_color = "#151826",
			fg_color = "#aeafb0",
		},
		new_tab = {
			bg_color = "#07080d",
			fg_color = "#aeafb0",
		},
	},
}
cfg.use_fancy_tab_bar = false
cfg.hide_tab_bar_if_only_one_tab = true

local font = function(fam, size, scale, nobold)
	local f = fam
	local fe = { family = fam, assume_emoji_presentation = true }
	if type(fam) == "table" then
		f = { family = fam[1], weight = "Medium" }
		fe = { family = fam[1], weight = "Medium", assume_emoji_presentation = true }
	end
	local ff = wezterm.font_with_fallback(scale > 0 and {
		f,
		fe,
		{ family = "Symbols Nerd Font", scale = scale },
	} or { f, fe })
	cfg.font = ff
	cfg.font_size = size
	if nobold then
		cfg.font_rules = {}
		for _, a in ipairs({ "Normal", "Half", "Bold" }) do
			table.insert(cfg.font_rules, { intensity = a, italic = false, font = ff })
			table.insert(cfg.font_rules, { intensity = a, italic = true, font = ff })
		end
	end
end

font("kirsch", 12, 0.6, true)
-- font({ "Cozette" }, 9.75, 0.7)
-- font("JuliaMono Nerd Font Mono", 10, 1)
-- cfg.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- font({ "eldur" }, 9.75, 0.7)
-- font({ "Kirsch Nerd Font Mono" }, 12, 0, true)
-- font({ "jokull" }, 13.5, 0.7)
-- font({ "TamzenForPowerline" }, 9, 0.8)
-- font({ "creep2" }, 8, 0.7)
-- font("Greybeard 11px", 8, 0.8)
-- font({ "scientifica" }, 8, 0.7)
cfg.custom_block_glyphs = false
-- cfg.use_cap_height_to_scale_fallback_fonts = true
-- cfg.treat_east_asian_ambiguous_width_as_wide = true
-- cfg.cell_width = 0.5
-- cfg.line_height = 1.2
cfg.freetype_load_flags = "NO_HINTING"
-- cfg.freetype_load_target = "Mono"

cfg.disable_default_key_bindings = true
cfg.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
cfg.keys = {
	{ key = "Backspace", mods = "CTRL", action = act.SendString("\x17") },
	{ key = "C", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "2", mods = "LEADER|CTRL", action = act.EmitEvent("dbl-font") },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "H", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "J", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "K", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "L", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "n", mods = "LEADER", action = act.SpawnWindow },
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "s", mods = "LEADER|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "n", mods = "LEADER|CTRL", action = act.SpawnWindow },
	{ key = "w", mods = "LEADER|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "x", mods = "LEADER|CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "t", mods = "LEADER|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },

	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },
	{ key = "l", mods = "LEADER", action = act.ShowDebugOverlay },
}

local fnt_dpi = function(gui_window)
	local overrides = gui_window:get_config_overrides() or {}
	overrides.font_size = cfg.font_size * 96 / gui_window:get_dimensions().dpi
	gui_window:set_config_overrides(overrides)
end

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	-- gui_window:toggle_fullscreen()
	fnt_dpi(gui_window)
end)

wezterm.on("window-config-reloaded", fnt_dpi)

wezterm.on("dbl-font", function(window, pane)
	for _ = 1, 7 do
		window:perform_action(act.IncreaseFontSize, pane)
	end
end)

local auth = string.format("%s/.1password/agent.sock", wezterm.home_dir)
if #wezterm.glob(auth) == 1 then
	cfg.default_ssh_auth_sock = auth
end

return cfg
