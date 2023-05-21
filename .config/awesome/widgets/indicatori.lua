local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- Ogni widget (tranne le icone e il separatore) avvia un script che ogni tot secondi scrive su stdout le informazioni
-- Non ho trovato un modo per farli terminare al termine della sessione di awesome

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
local cpu = wibox.widget.textbox()

awful.spawn.with_line_callback('bash -c "pkill cpu.sh; ~/.config/awesome/scripts/cpu.sh"', {
    stdout = function(line)
        cpu:set_markup(line)
    end,
    stderr = function(line)
        naughty.notify({ text = "ERR:"..line})
    end,
})

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
                font = "SauceCodePro Nerd Font Mono 9",
                text = " "
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
local ram = wibox.widget.textbox()

awful.spawn.with_line_callback('bash -c "pkill ram.sh; ~/.config/awesome/scripts/ram.sh"', {
    stdout = function(line)
        ram:set_markup(line)
    end,
    stderr = function(line)
        naughty.notify({ text = "ERR:"..line})
    end,
})

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
                font = "SauceCodePro Nerd Font Mono 9",
                text = " "
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
local net = wibox.widget.textbox()

awful.spawn.with_line_callback('bash -c "pkill net.sh; ~/.config/awesome/scripts/net.sh enp34s0"', {
    stdout = function(line)
        net:set_markup(line)
    end,
    stderr = function(line)
        naughty.notify({ text = "ERR:"..line})
    end,
})

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

-- TEMP
local temp = wibox.widget.textbox()

awful.spawn.with_line_callback('bash -c "pkill temp.sh; ~/.config/awesome/scripts/temp.sh"', {
    stdout = function(line)
        temp:set_markup(line)
    end,
    stderr = function(line)
        naughty.notify({ text = "ERR:"..line})
    end,
})

local temp_widget = wibox.widget {
    {
        {
            {
                font = "Ubuntu Bold 8",
                widget = temp
            },
            top = dpi(2),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        fg = "#ff6c6b",
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

return {
    cpu = cpu_widget,
    ram = ram_widget,
    net = net_widget,
    temp = temp_widget,
    sep = sep,
    cicon = cpu_icon,
    ricon = ram_icon
    
}
