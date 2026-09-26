-- Autostart processes
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
	hl.exec_cmd("discord")
	hl.exec_cmd("waybar")
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)
	hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
	hl.exec_cmd("systemctl --user start xdg-desktop-portal")
	hl.exec_cmd("swaync")
	hl.exec_cmd(home .. "/.config/hypr/init-wallpaper.sh")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("steam")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("wl-clip-persist --clipboard regular")
end)
