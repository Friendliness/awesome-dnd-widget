local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local normal_bg = beautiful.bg_normal
local suspended_bg = beautiful.fg_normal
local suspended = naughty.is_suspended()

local moon_bg = beautiful.bg_normal
if suspended then
	moon_bg = suspended_bg
else
	moon_bg = normal_bg
end

local dnd = wibox.widget({
	{
		{
			widget = wibox.widget.imagebox,
			image = gears.filesystem.get_configuration_dir() .. "icons/moon.svg",
			resize = true,
			valign = "center",
			halign = "center",
		},
		widget = wibox.container.margin,
		margins = 4,
	},
	widget = wibox.container.background,
	bg = moon_bg,
})

dnd:buttons(awful.button({}, 1, function()
	if suspended then
		dnd.bg = normal_bg
		naughty.resume()
	else
		dnd.bg = suspended_bg
		naughty.suspend()
	end

	suspended = not suspended
end))

return dnd
