local awful = require("awful")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi


-- SEPARATOR
local sep = wibox.widget {
    {
        widget = wibox.widget.textbox,
        markup = '<span font="Ubuntu Bold 8"> | </span>'
    },
    top = dpi(2),
    bottom = dpi(5),
    widget = wibox.container.margin
}

-- CPU
local cpu = awful.widget.watch('bash -c "~/.config/awesome/scripts/cpu.sh"', 2)

local cpu_widget = wibox.widget {
    {
        {
            {
                font = "Ubuntu Bold 8",
                widget = cpu
            },
            top = dpi(2),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        fg = "#ecbe7b",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

-- CPU ICON
local cpu_icon = wibox.widget{
    {
        {
            {
                widget = wibox.widget.textbox,
                font = "SauceCodePro Nerd Font Mono 12",
                text = ""
            },
            top = dpi(4),
            bottom = dpi(6),
            widget = wibox.container.margin
        },
        fg = "#ecbe7b",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

-- RAM
local ram = awful.widget.watch('bash -c "~/.config/awesome/scripts/ram.sh"', 2)

local ram_widget = wibox.widget {
    {
        {
            {
                font = "Ubuntu Bold 8",
                widget = ram
            },
            top = dpi(2),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        fg = "#51afef",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

-- RAM ICON
local ram_icon = wibox.widget{
    {
        {
            {
                widget = wibox.widget.textbox,
                font = "SauceCodePro Nerd Font Mono 12",
                text = ""
            },
            top = dpi(4),
            bottom = dpi(8),
            widget = wibox.container.margin
        },
        fg = "#51afef",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

-- NETSPEED
local net = awful.widget.watch('bash -c ".config/awesome/scripts/net.sh enp34s0"', 1)

local net_widget = wibox.widget {
    {
        {
            {
                font = "Ubuntu Bold 8",
                widget = net
            },
            top = dpi(2),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        fg = "#98be65",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

return {
    cpu = cpu_widget,
    ram = ram_widget,
    net = net_widget,
    sep = sep,
    cicon = cpu_icon,
    ricon = ram_icon
    
}