-- Hyprland 0.55+: minimalist, Awesome-inspired keyboard workflow.
local lg = "desc:LG Electronics LG ULTRAWIDE"
local aoc = "desc:AOC 2269WM"

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = lg, mode = "3440x1440@159.96", position = "0x0", scale = 1 })
-- Top-aligned portrait display to the left. Use transform=3 for the opposite rotation.
hl.monitor({ output = aoc, mode = "1920x1080@60", position = "-1080x0", scale = 1, transform = 1 })
for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = i <= 5 and lg or aoc,
        default = i == 1 or i == 6, persistent = true })
end

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("TERMINAL", "kitty")
hl.config({
    general = {
        layout = "dwindle", gaps_in = 0, gaps_out = 0, border_size = 1,
        resize_on_border = true,
        col = { active_border = "rgba(f7768eff)", inactive_border = "rgba(34363bff)" },
    },
    decoration = { rounding = 0, blur = { enabled = false }, shadow = { enabled = false } },
    animations = { enabled = false },
    dwindle = { preserve_split = true, smart_resizing = true },
    input = { kb_layout = "us", kb_variant = "altgr-intl", repeat_delay = 250, repeat_rate = 65,
        follow_mouse = 1, touchpad = { natural_scroll = true }, scroll_factor = 2.0 },
    cursor = { default_monitor = lg },
    misc = { disable_hyprland_logo = true, disable_splash_rendering = true },
})

local function bind(key, action, repeat_key)
    hl.bind(key, action, { repeating = repeat_key or false })
end
local function exec(key, command)
    bind(key, hl.dsp.exec_cmd(command))
end

for _, motion in ipairs({
    { "H", "left", -40, 0 }, { "J", "down", 0, 40 },
    { "K", "up", 0, -40 }, { "L", "right", 40, 0 },
}) do
    local key, direction, dx, dy = table.unpack(motion)
    bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }), true)
    bind("SUPER + SHIFT + " .. key, function()
        local w = hl.get_active_window()
        if w and w.floating then
            hl.dispatch(hl.dsp.window.move({ x = dx, y = dy, relative = true }))
        else
            hl.dispatch(hl.dsp.window.move({ direction = direction }))
        end
    end, true)
    -- Resize the tile and redistribute space to its neighbours.
    bind("SUPER + ALT + " .. key, hl.dsp.window.resize({ x = dx, y = dy, relative = true }), true)
    bind("SUPER + CTRL + ALT + " .. key, hl.dsp.window.resize({ x = dx, y = dy, relative = true }), true)
end

exec("SUPER + Return", "~/.config/hypr/scripts/open-terminal.sh")
exec("SUPER + R", "rofi -show drun -theme ~/.config/hypr/rofi.rasi")
exec("SUPER + P", "rofi -show powermenu -modi powermenu:~/.config/rofi/scripts/power.sh -theme ~/.config/hypr/rofi.rasi")
exec("SUPER + C", "rofi -show calc -modi calc -no-show-match -no-sort -theme ~/.config/hypr/rofi.rasi -calc-command \"echo -n '{result}' | wl-copy\"")
exec("CTRL + SHIFT + P", "sh -c 'cliphist list | rofi -dmenu -theme ~/.config/hypr/rofi.rasi -theme-str \"window { width: 900px; }\" -theme-str \"listview { lines: 12; }\" -p  | cliphist decode | wl-copy'")
exec("SUPER + B", "pkill -USR1 -x waybar")
bind("SUPER + Q", hl.dsp.window.close())
bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
bind("SUPER + CTRL + Space", hl.dsp.window.float({ action = "toggle" }))
bind("SUPER + SHIFT + C", hl.dsp.window.center())
bind("SUPER + Space", hl.dsp.layout("togglesplit"))
bind("SUPER + Tab", hl.dsp.focus({ last = true }))
bind("SUPER + U", hl.dsp.focus({ urgent_or_last = true }))
bind("SUPER + Left", hl.dsp.focus({ workspace = "m-1" }))
bind("SUPER + Right", hl.dsp.focus({ workspace = "m+1" }))
bind("SUPER + Escape", hl.dsp.focus({ workspace = "previous" }))
bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "left" }))
bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "right" }))
bind("SUPER + CTRL + J", hl.dsp.focus({ monitor = "+1" }))
bind("SUPER + CTRL + K", hl.dsp.focus({ monitor = "-1" }))
bind("SUPER + O", hl.dsp.window.move({ monitor = "+1", follow = true }))
bind("SUPER + T", hl.dsp.window.pin({ action = "toggle" }))
exec("SUPER + CTRL + R", "hyprctl reload")
exec("SUPER + SHIFT + M", "hyprctl reload")
exec("CTRL + Space", "makoctl dismiss --all")
exec("SUPER + N", "makoctl restore")
exec("SUPER + G", "hyprlock")
exec("SUPER + SHIFT + S", "sh -c 'area=$(slurp -b 000000a0) && grim -g \"$area\" - | wl-copy'")

for i = 1, 10 do
    bind("SUPER + " .. (i % 10), hl.dsp.focus({ workspace = i }))
    bind("SUPER + SHIFT + " .. (i % 10), hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
for _, volume in ipairs({ { "XF86AudioRaiseVolume", "1%+" }, { "XF86AudioLowerVolume", "1%-" },
    { "ALT + Up", "1%+" }, { "ALT + Down", "1%-" } }) do
    bind(volume[1], hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. volume[2]), true)
end
exec("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
exec("ALT + M", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"), true)
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), true)

hl.window_rule({ name = "picture-in-picture", match = { title = "^(Picture-in-Picture|Picture in picture)$" },
    float = true, size = "30% 30%", pin = true })
-- Remember the last focused terminal's directory for Super+Return.
hl.on("window.active", function()
    hl.exec_cmd("sh ~/.config/hypr/scripts/track-terminal-cwd.sh")
end)
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("pgrep -x mako >/dev/null || mako")
    hl.exec_cmd("pgrep -x hyprpaper >/dev/null || hyprpaper")
    hl.exec_cmd("pgrep -f 'wl-paste --type text --watch cliphist store' >/dev/null || wl-paste --type text --watch cliphist store")
    hl.exec_cmd("pgrep -f 'wl-paste --type image --watch cliphist store' >/dev/null || wl-paste --type image --watch cliphist store")
    hl.exec_cmd("sh ~/.config/hypr/scripts/start-bar.sh")
    if hl.get_monitor(lg) then
        hl.dispatch(hl.dsp.focus({ workspace = 1 }))
    end
end)
