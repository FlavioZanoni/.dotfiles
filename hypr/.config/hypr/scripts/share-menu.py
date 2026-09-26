#!/usr/bin/env python3
# Rofi screen share picker for xdg-desktop-portal-hyprland, styled with the
# launcher theme. Lists monitors, windows and a region option, then prints
# the selection in the format xdph expects. Called by share-picker.sh.
import html
import json
import os
import re
import subprocess
import sys

THEME = os.path.expanduser("~/.config/hypr/rofi.rasi")
SHARE_BAR = re.compile(r"is sharing (your screen|a window|this tab)\.?$")


def row(glyph, label, detail):
    detail = html.escape(detail)
    return f"{glyph}  {html.escape(label)}  <span alpha='55%'>{detail}</span>"


def monitors():
    out = subprocess.run(["hyprctl", "monitors", "-j"], capture_output=True, text=True, check=True).stdout
    # Focused monitor first so it's the default choice.
    return sorted(json.loads(out), key=lambda m: not m["focused"])


def windows():
    # Entries look like: id[HC>]class[HT>]title[HE>]address[HA>]
    for entry in os.environ.get("XDPH_WINDOW_SHARING_LIST", "").split("[HA>]"):
        try:
            wid, rest = entry.split("[HC>]", 1)
            cls, rest = rest.split("[HT>]", 1)
            title, _ = rest.split("[HE>]", 1)
        except ValueError:
            continue
        # Chromium's own "is sharing your screen" bar isn't worth sharing.
        if SHARE_BAR.search(title):
            continue
        yield wid, cls, title


def monitor_label(m):
    if m["name"].startswith("eDP"):
        return "Laptop screen"
    return m["model"] or m["name"]


def main():
    rows, picks = [], []
    for m in monitors():
        rows.append(row("󰍹", monitor_label(m), f"{m['name']} · {m['width']}×{m['height']}"))
        picks.append(f"screen:{m['name']}")
    for wid, cls, title in windows():
        title = title if len(title) <= 60 else title[:59] + "…"
        rows.append(row("󰖯", cls or "window", title))
        picks.append(f"window:{wid}")
    rows.append(row("󰩭", "Region", "select an area"))
    picks.append("region")

    menu = subprocess.run(
        ["rofi", "-dmenu", "-i", "-markup-rows", "-no-show-icons", "-format", "i",
         "-theme", THEME, "-theme-str", 'entry { placeholder: "Share…"; }'],
        input="\n".join(rows), capture_output=True, text=True,
    )
    if menu.returncode != 0 or not menu.stdout.strip():
        sys.exit(1)
    pick = picks[int(menu.stdout)]

    if pick == "region":
        area = subprocess.run(["slurp", "-b", "000000a0", "-f", "%o@%X,%Y,%W,%H"], capture_output=True, text=True)
        if area.returncode != 0:
            sys.exit(1)
        pick = f"region:{area.stdout.strip()}"

    flags = "r" if "--allow-token" in sys.argv[1:] else ""
    print(f"[SELECTION]{flags}/{pick}")


if __name__ == "__main__":
    main()
