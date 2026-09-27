-- Window and layer rules
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "foot-opacity",
    match = { class = "^(foot)$" },
    opacity = "0.92 0.82",
})

hl.window_rule({
    name = "kitty-opacity",
    match = { class = "^(kitty)$" },
    opacity = "0.92 0.82",
})

hl.window_rule({
    name = "ghostty-opacity",
    match = { class = "^(com\\.mitchellh\\.ghostty|ghostty)$" },
    opacity = "0.92 0.82",
})

hl.window_rule({
    name = "plasmawindowed-float",
    match = { class = "^(org\\.kde\\.plasmawindowed)$" },
    float = true,
    size = "500 600",
    center = true,
})

hl.layer_rule({
    name = "wofi-blur",
    match = { namespace = "^(wofi)$" },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name = "swaync-cc-slide",
    match = { namespace = "^(swaync-control-center)$" },
    animation = "slide right",
})

hl.layer_rule({
    name = "swaync-noti-slide",
    match = { namespace = "^(swaync-notification-window)$" },
    animation = "slide right",
})
