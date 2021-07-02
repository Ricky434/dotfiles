-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- require("awful.hotkeys_popup.keys")
require('awful.autofocus')
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ 
		preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors 
	})
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

beautiful.init( gears.filesystem.get_configuration_dir() .. "/themes/default/theme.lua")

terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

-- Set wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

local indicatori = require("widgets.indicatori")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
	
    -- Create the wibox
    s.mywibox = awful.wibar({ 
		position = beautiful.wibar_position, 
		screen = s, 
		height = beautiful.wibar_height,
		bg = "#00000000"
	})

    -- Add widgets to the wibox
    s.mywibox:setup {
		{
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				require("widgets.separator"),
				require("widgets.panel.menu"),
				require("widgets.panel.taglist")(s),
				require("widgets.separator"),
				s.mypromptbox,
			},
			require("widgets.panel.icon-only-tasklist")(s), -- Middle widget
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,

				indicatori["sep"],
				indicatori["cicon"],
				indicatori["cpu"],
				indicatori["sep"],

				indicatori["ricon"],
				indicatori["ram"],
				indicatori["sep"],

				indicatori["net"],
				indicatori["sep"],

				require("widgets.panel.systray-no-toggle")(),
				require("widgets.keyboard-indicator"),
				require("widgets.panel.layoutbox")(s),
				require("widgets.clock")(s),
				require("widgets.control-center")(s),
			},
		},
		bg = beautiful.bg_normal,
		-- shape = function (cr, width, height)
		-- 	gears.shape.partially_rounded_rect( cr, width, height, true, true, false, false, 50)
		-- end,
		widget = wibox.container.background
    }
end)

awesome.connect_signal(
	"panel::show",
	function ()
		for s in screen do
			s.mywibox.visible = true
		end
	end
)

awesome.connect_signal(
	"panel::hide",
	function ()
		for s in screen do
			s.mywibox.visible = false
		end
	end
)

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = require("configurations.keybindings.global")
clientkeys = require("configurations.keybindings.client")
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.

		awful.key(
			{ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}
		),
		-- Toggle tag display.
		awful.key(
			{ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}
		),
		-- Move client to tag.
		awful.key(
			{ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
			   end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}
		),
		-- Toggle tag on focused client.
		awful.key(
			{ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"}
		)
    )
end

-- #### funzioni copiate da google
local gmath = require("gears.math")
local function move_to_previous_tag()
    local c = client.focus
    if not c then return end
    local t = c.screen.selected_tag
    local tags = c.screen.tags
    local idx = t.index
    local newtag = tags[gmath.cycle(#tags, idx - 1)]
    c:move_to_tag(newtag)
    --awful.tag.viewprev()
end

local function move_to_next_tag()
    local c = client.focus
    if not c then return end
    local t = c.screen.selected_tag
    local tags = c.screen.tags
    local idx = t.index
    local newtag = tags[gmath.cycle(#tags, idx + 1)]
    c:move_to_tag(newtag)
    --awful.tag.viewnext()
end
-- #### 

globalkeys = gears.table.join(globalkeys,
    awful.key(
		{ modkey }, ",",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}
	),
    awful.key(
		{ modkey }, ".",  awful.tag.viewnext,
        {description = "view next", group = "tag"}
	),
	awful.key(
		{ modkey, "Shift" }, ",",
		function (c)
			move_to_previous_tag()
			awful.tag.viewprev()
		end,
        {description = "move to previous", group = "tag"}
	),
    awful.key(
		{ modkey, "Shift" }, ".",
		function(c)
			move_to_next_tag()
			awful.tag.viewnext()
		end,
        {description = "move to next", group = "tag"}
	)
)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Gaps
beautiful.useless_gap = 5

-- Set keys
root.keys(globalkeys)

-- Rules
require("module.signals")
require("configurations.rules")
require("widgets.exit-screen")
require("module.notification")
require("module.autostart")

