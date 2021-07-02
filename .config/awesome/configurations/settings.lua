local settings = {}

settings.wlan_interface = ""
settings.lan_interface = "enp34s0"
-- Turn this to false if you have no bluetooth available, otherwise your dbus will get polutate with bluetoothctl
settings.is_bluetooth_presence = false
settings.script_dir = "~/.config/awesome/scripts/"
settings.openweathermap_api_key = "<key>"
settings.openweathermap_coordinates = {
	"00.000000", -- lat
	"00.000000" -- lng
}
return settings
