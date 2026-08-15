-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Personal overrides restored after the Omarchy 4 upgrade
-- (previously in the now-orphaned bindings.conf)

-- SUPER+W is the Omarchy 4 default for "Close window"; restore custom Browser bind.
-- (Kill window is intentionally bound to SUPER+Q below instead.)
hl.unbind("SUPER + W")
o.bind("SUPER + W", "Browser", { omarchy = "browser" })

o.bind("SUPER + Q", "Kill window", hl.dsp.window.close())

o.bind("SUPER + D", "Launch apps", "omarchy-menu toggle apps")

-- SUPER+SHIFT+W is the Omarchy 4 default for "Omawrite"; restore custom RDP bind.
hl.unbind("SUPER + SHIFT + W")
o.bind(
	"SUPER + SHIFT + W",
	"Windows RDP",
	"sdl-freerdp3 /u:bill /p:gates /v:127.0.0.1:3389 /cert:ignore /size:1920x1080 /sound"
)

-- SUPER+SHIFT+A is the Omarchy 4 default for "ChatGPT"; restore audio panel toggle.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Audio", "omarchy-shell shell toggle omarchy.audio")

-- SUPER+SHIFT+X is the Omarchy 4 default for "X" (webapp); restore lock screen.
hl.unbind("SUPER + SHIFT + X")
o.bind("SUPER + SHIFT + X", "Lock screen", "omarchy-system-lock")

-- SUPER+SHIFT+S is the Omarchy 4 default for "Google Maps" (webapp); restore screenshot.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot with editing", "omarchy-capture-screenshot")

o.bind("SUPER + SHIFT + R", "ratty", "ratty")
