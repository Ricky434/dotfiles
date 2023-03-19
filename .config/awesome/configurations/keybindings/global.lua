local gears = require("gears");
local awful = require("awful");
local awesome = awesome
local hotkeys_popup = require("awful.hotkeys_popup")
local default_apps = require("configurations.default-apps")
require('awful.autofocus')
local globalkeys = gears.table.join(
    awful.key(
		{ modkey,},
		"s",
		hotkeys_popup.show_help,
        {description="show help", group="awesome"}
	),
    awful.key(
		{ modkey,},
		"Escape",
		awful.tag.history.restore,
        {description = "go back", group = "tag"}
	),

	-- TODO: Will be used for toggling tabbed layout
    awful.key(
		{ modkey,},
		"w",
		function () mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}
	),

    -- Layout manipulation
	-- Swap client
    awful.key(
		{ modkey, "Shift"},
		"j",
		function () awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}
	),
    awful.key(
		{ modkey, "Shift"},
		"Left",
		function () awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}
	),
    awful.key(
		{ modkey, "Shift"},
		"k",
		function () awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}
	),
    awful.key(
		{ modkey, "Shift"},
		"Right",
		function () awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}
	),
	-- Focus client
    awful.key(
		{ modkey,},
		"j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
		{ modkey,}, 
		"Right",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
		{ modkey,}, 
		"k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
		{ modkey,}, "Left",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
	-- Relative focus
    awful.key(
		{ modkey, "Control" },
		"j",
		function () awful.screen.focus_relative(1) end,
        {description = "focus the next screen", group = "screen"}
	),
    awful.key(
		{ modkey, "Control" },
		"k",
		function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}
	),
	-- Focus previous
    awful.key(
		{ modkey,},
		"Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
	),
    awful.key(
		{ modkey,},
		"u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
	),

    -- Standard program
    awful.key(
		{ modkey,},
		"Return",
		function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}
	),
    awful.key(
		{ modkey, "Shift" },
		"r",
		awesome.restart,
        {description = "reload awesome", group = "awesome"}
	),
    awful.key(
		{ modkey, "Shift"},
		"q",
		awesome.quit,
        {description = "Quit awesome", group = "launcher"}
	),
	-- Client resize master
    awful.key(
		{ modkey, "Control"},
		"Right",
		function () awful.tag.incmwfact( 0.05) end,
        {description = "increase master width factor", group = "layout"}
	),
    awful.key({ modkey, "Control"},
		"Left",
		function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}
	),
	-- Client resize
    awful.key({ modkey, "Control"},
		"Up",
		function () awful.client.incwfact(0.50) end,
        {description = "decrease master width factor", group = "layout"}
	),
    awful.key({ modkey, "Control"},
		"Down",
		function () awful.client.incwfact(-0.50) end,
        {description = "decrease master width factor", group = "layout"}
	),
	-- Increase/Decrease numbers of master
    awful.key(
		{ modkey, "Shift"},
		"h",
		function () awful.tag.incnmaster( 1, nil, true) end,
    	{description = "increase the number of master clients", group = "layout"}
	),
    awful.key(
		{ modkey, "Shift"},
		"l",
		function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}
	),

	-- Increase/Decrease numbers of columns
    awful.key(
		{ modkey, "Control" },
		"+",
		function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}
	),
    awful.key(
		{ modkey, "Control" },
		"-",
		function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}
	),

	-- Next layout
    awful.key(
		{ modkey,},
		"Tab",
		function () awful.layout.inc(1) end,
    	{description = "select next", group = "layout"}
	),

	-- Previous layout
    awful.key(
		{ modkey, "Control"},
		"Tab",
		function () awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}
	),

    awful.key(
		{ modkey, "Control" },
		"n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
            	c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        {description = "restore minimized", group = "client"}
	),


    -- Prompt
    awful.key(
		{ modkey },
		"r",
		function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}
	),

    awful.key(
		{ modkey }, 
		"x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
    	{description = "lua execute prompt", group = "awesome"}
	),
	-- My keybindings
	awful.key(
		{ modkey },
		"space",
		--function() awful.spawn("rofi -show drun -columns 2 -theme codeDark -no-show-icons") end,
		function() awful.spawn(default_apps.app_menu, false) end,
		{description = "Application launcher", group = 'launcher'}
	),

	awful.key(
		{},
		'XF86AudioRaiseVolume',
		function()
			awful.spawn('pulseaudio-control --volume-max 130 up', false)
			awesome.emit_signal("update::volume")
		end,
		{description = 'increase volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioLowerVolume',
		function()
			awful.spawn('pulseaudio-control --volume-max 130 down', false)
			awesome.emit_signal("update::volume")
		end,
		{description = 'decrease volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioMute',
		function()
			awful.spawn('pulseaudio-control togmute', false)
			awesome.emit_signal("toggle::mute")
		end,
		{description = 'toggle mute', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPlay',
		function()
			awful.spawn('playerctl play-pause', false)
			awesome.emit_signal("toggle play/pause")
		end,
		{description = 'increase brightness by 10%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPrev',
		function()
			awful.spawn('playerctl prev', false)
		end,
		{description = 'previous track', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioNext',
		function()
			awful.spawn('playerctl next', false)
		end,
		{description = 'next track', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86Calculator',
		function()
			awful.spawn('galculator', false)
		end,
		{description = 'calculator', group = 'hotkeys'}
	),
	awful.key(
		{ modkey, "Control"},
		'space',
		function()
			awful.util.spawn('/home/jelly/.config/awesome/scripts/keymaptoggle.sh')
		end,
		{description = 'toggle keymap us/us-intl', group = 'hotkeys'}
	),
	awful.key(
		{},
		'Print',
		function()
			awful.spawn.with_shell('scrot "~/Pictures/Screenshots/%Y-%m-%d_%T.png" -pfs -l style=dash -q 100', false)
		end,
		{description = 'take a screenshot from a selection', group = 'hotkeys'}
	),
	awful.key(
		{"Shift"},
		'Print',
		function()
			awful.spawn.with_shell('scrot "~/Pictures/Screenshots/%Y-%m-%d_%T.png" -p -q 100', false)
		end,
		{description = 'take a screenshot of the whole screen', group = 'hotkeys'}
	),
	awful.key(
		{ modkey, "Shift"},
		's',
		function()
			local c = client.focus
			if c.sticky then
				c.floating = not c.floating
				c.sticky = not c.sticky
				c.ontop = not c.ontop
			else
				c.sticky = true
				c.floating = true
				c.ontop = true
			end
		end,
		{description = 'Toggle client sticky', group = 'client'}
	)
)

return globalkeys
