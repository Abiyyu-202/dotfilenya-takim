-- Keybindings
local home = os.getenv("HOME")
local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "wofi --show drun"

-- General binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill waybar; waybar &"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd(home .. "/.config/wofi/change-wallpaper.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(home .. "/.config/hypr/toggle-gapless.sh"))
hl.bind("ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wofi-emoji"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[bash -c 'file=~/skrinsut/hyprland/skrinsut-$(date +%F_%H-%M-%S).png; grim -g "$(slurp)" "$file" && wl-copy < "$file"']]))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd([[bash -c 'file=~/skrinsut/hyprland/skrinsut-$(date +%F_%H-%M-%S).png; grim "$file" && wl-copy < "$file"']]))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd(home .. "/.config/wofi/powermenu.sh"))

-- Focus movement
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ direction = "down" }))

-- Swap windows
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" }))

-- Workspace navigation
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.move({ workspace = "special:term" }))
hl.bind(mainMod .. " + Y", hl.dsp.workspace.toggle_special("term"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.window.move({ workspace = "e+0" }))

hl.bind(mainMod .. " + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ workspace = "+1" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia and Brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("brightnessctl -s set 10%+"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("brightnessctl -s set 10%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -s set 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -s set 10%-"), { locked = true, repeating = true })

-- Media controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- App shortcuts
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("flatpak run org.vinegarhq.Sober"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("antigravity"))
