---@meta
---@module "oxwm"

-- [ Preferences ] -------------------------------------------------------------
local modkey = "Mod4"
local terminal = "st"
local colors = require("nord")

local tags = { " ", "󰊯 ", " ", " ", "󰙯 ", "󱇤 ", " ", "󰊴 ", " " }

oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey)
oxwm.set_tags(tags)

-- [ Appearance ] --------------------------------------------------------------
oxwm.border.set_width(2)
oxwm.border.set_focused_color(colors.lblue)
oxwm.border.set_unfocused_color(colors.sep)

oxwm.gaps.set_smart(true)
oxwm.gaps.set_inner(5, 5)
oxwm.gaps.set_outer(5, 5)

oxwm.bar.set_hide_vacant_tags(true)
oxwm.set_floating_position("center") -- for floating windows

-- [ Layouts ] -----------------------------------------------------------------
oxwm.set_tag_layout(1, "tiling")
oxwm.set_tag_layout(2, "scrolling")
oxwm.set_tag_layout(3, "normie")
oxwm.set_tag_layout(4, "grid")
oxwm.set_tag_layout(5, "monocle")

oxwm.set_layout("tiling")
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("monocle", "[M]")
oxwm.set_layout_symbol("scrolling", "[S]")
oxwm.set_layout_symbol("grid", "[G]")

-- [ Status Bar ] --------------------------------------------------------------
local ram = oxwm.bar.block.ram({
	format = "  {used}/{total} GiB",
	interval = 1,
	color = colors.red,
	underline = true,
})

local date = oxwm.bar.block.datetime({
	format = "󰸘 {}",
	date_format = "%a, %b %d - %-I:%M %P",
	interval = 1,
	color = colors.cyan,
	underline = true,
	click = "/usr/local/bin/st -c calender -e /usr/bin/calcurse",
})

local battery = oxwm.bar.block.battery({
	format = "󰁹 {percent}%",
	charging = "󱐋 {percent}%",
	discharging = "󰂃 {percent}%",
	full = "󰁹 Full",
	interval = 10,
	color = colors.green,
	underline = true,
	click = "st -e btop",
})

local sep = oxwm.bar.block.static({ text = "/", color = colors.sep })

oxwm.bar.set_font("JetBrainsMono Nerd Font:style=Bold:size=14")

oxwm.bar.set_blocks({
	sep,
	ram,
	sep,
	date,
	sep,
	battery,
})
oxwm.bar.set_position("top")
oxwm.bar.set_scheme_normal(colors.grey, colors.bg, colors.sep)
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
oxwm.bar.set_scheme_selected(colors.fg, colors.bg, colors.lavender)

-- [ Window Rules ] ------------------------------------------------------------
local r = oxwm.rule.add
r({ class = "floating", floating = true })
r({ class = "pop-up", floating = true })
r({ class = "gimp", floating = true })
r({ class = "Godot_Editor", floating = true })
r({ class = "blueman-manager", floating = true })
r({ class = "nmgui", floating = true })
r({ class = "calender", floating = true })

r({ class = "st-256color", tag = 1 })
r({ class = "gimp", tag = 6 })
r({ class = "brave-origin-beta", tag = 2 })
r({ class = "vlc", tag = 3 })
r({ class = "music", tag = 3 })
r({ class = "Telegram", tag = 5 })
r({ class = "libreoffice-writer", tag = 6 })
r({ class = "libreoffice-calc", tag = 6 })
r({ class = "libreoffice", tag = 6 })
r({ class = "Terraria.bin.x86_64", tag = 8 })
r({ class = "lsdlsrb2", tag = 8 })
r({ class = "itch", tag = 8 })
r({ class = "uzdoom", tag = 8 })
r({ class = "pcmanfm", tag = 9 })

-- [ Keybinds ] ----------------------------------------------------------------
local bind = oxwm.key.bind
bind({ modkey }, "Return", oxwm.spawn_terminal())
bind({ modkey }, "D", oxwm.spawn({ "rofi -show drun" }))
bind({ modkey }, "B", oxwm.spawn({ "brave-origin-beta" }))
bind({ modkey, "Shift" }, "B", oxwm.spawn({ "blueman-manager" }))
bind({ modkey }, "E", oxwm.spawn({ "pcmanfm" }))
bind({}, "Print", oxwm.spawn({ "sh", "-c", "~/.config/oxwm/screenshot.sh" }))

-- Client Controls
bind({ modkey }, "Q", oxwm.client.kill())
bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())
bind({ modkey }, "Left", oxwm.client.focus_stack(1))
bind({ modkey }, "Right", oxwm.client.focus_stack(-1))
bind({ modkey, "Shift" }, "Left", oxwm.client.move_stack(1))
bind({ modkey, "Shift" }, "Right", oxwm.client.move_stack(-1))
bind({ modkey, "Shift" }, "L", oxwm.spawn({ "betterlockscreen -l" }))

-- Layouts & Gaps
bind({ modkey }, "T", oxwm.layout.set("tabbed"))
bind({ modkey }, "N", oxwm.layout.cycle())
bind({ modkey }, "H", oxwm.set_master_factor(-5))
bind({ modkey }, "L", oxwm.set_master_factor(5))
bind({ modkey }, "I", oxwm.inc_num_master(1))
bind({ modkey }, "P", oxwm.inc_num_master(-1))
bind({ modkey }, "A", oxwm.toggle_gaps())

-- Essential WM Controls (Hot Reloading / Exit)
bind({ modkey, "Shift" }, "Q", oxwm.quit())
bind({ modkey, "Shift" }, "R", oxwm.restart())
bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())
bind({ modkey, "Control" }, "P", oxwm.spawn({ "powermenu" }))

-- Monitor Controls
bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
bind({ modkey }, "Period", oxwm.monitor.focus(1))
bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Tag Switching Logic
for i = 1, 9 do
	bind({ modkey }, tostring(i), oxwm.tag.view(i - 1))
	bind({ modkey, "Shift" }, tostring(i), oxwm.tag.move_to(i - 1))
	bind({ modkey, "Control" }, tostring(i), oxwm.tag.toggleview(i - 1))
	bind({ modkey, "Control", "Shift" }, tostring(i), oxwm.tag.toggletag(i - 1))
end

-- [ Media Keys (68% Keyboard: Mod + F#) ] -------------------------------------
bind(
	{ modkey },
	"F1",
	oxwm.spawn({ "sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute' 'Toggled audio...'" })
)
bind(
	{ modkey },
	"F2",
	oxwm.spawn({
		"sh",
		"-c",
		"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send -h string:x-dunst-stack-tag:volume 'Volume' 'Lowering...'",
	})
)
bind(
	{ modkey },
	"F3",
	oxwm.spawn({
		"sh",
		"-c",
		"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -h string:x-dunst-stack-tag:volume 'Volume' 'Raising...'",
	})
)
bind({ modkey }, "F5", oxwm.spawn({ "playerctl previous" }))
bind({ modkey }, "F6", oxwm.spawn({ "playerctl play-pause" }))
bind({ modkey }, "F7", oxwm.spawn({ "playerctl next" }))
bind({ modkey }, "F8", oxwm.spawn({ "playerctl stop" }))

-- [ Chords ] ------------------------------------------------------------------
oxwm.key.chord({ { { modkey }, "Space" }, { {}, "M" } }, oxwm.spawn({ "st -c music -e termusic" }))
oxwm.key.chord({ { { modkey }, "Space" }, { {}, "C" } }, oxwm.spawn({ "nmgui" }))
oxwm.key.chord({ { { modkey }, "Space" }, { {}, "S" } }, oxwm.spawn({ "Telegram" }))
oxwm.key.chord({ { { modkey }, "F" }, { {}, "D" } }, oxwm.spawn({ "st -e dotmgr" }))

-- [ Autostart ] ---------------------------------------------------------------
oxwm.autostart("xset r rate 300 35")
oxwm.autostart("fastcompmgr")
oxwm.autostart("feh --bg-fill ~/dotfiles/walls/nord/oxen.jpg")
oxwm.autostart("dunst")
oxwm.autostart("mate-polkit")
oxwm.autostart("xss-lock -- betterlockscreen -l")
