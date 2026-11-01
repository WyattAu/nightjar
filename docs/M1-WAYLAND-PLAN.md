# M1: Wayland-first text injection — empirical plan

Flagship milestone. Rule: **no speculative refactoring**. Upstream already
has compositor-aware selection; we find what actually breaks on real
desktops and fix that, in order of daily-driver pain.

## What upstream already does (code reconnaissance 2026-11-01)

- `src-tauri/src/shortcut/mod.rs:1012-1016`: `TypingTool` enum —
  Wtype, Kwtype, Dotool, Ydotool, Xdotool
- `src-tauri/src/clipboard.rs:145-149`: compositor-aware preference —
  wtype preferred, but excluded on KDE and GNOME Wayland (no
  `zwp_virtual_keyboard_manager_v1` support on KDE)
- `is_kde_wayland()` / `is_gnome_wayland()` / `is_wtype_available()` probes exist
- `input.rs`: enigo fallback, with explicit "may not work on Wayland" notes
  on the paste paths (send_paste_ctrl_v / ctrl_shift_v)
- `handy_keys` (evdev): kernel-level hotkey capture, independent of the
  injection path

Upstream is NOT naive here. The wedge must be found by running it.

## Test matrix (this fleet)

| Host | Session | Injection candidates | Notes |
|---|---|---|---|
| wyattdeskacercachy (flagship test box) | KDE Wayland | Kwtype, ydotool, dotool | daily driver; CachyOS |
| same box | GNOME Wayland session | wtype, ydotool | switch session, rerun matrix |
| same box | X11 | xdotool, enigo | regression baseline |
| runner | n/a | build-only | CI covers compile, not behavior |

Tools to install first (pacman): `wtype`, `ydotool` (+ `ydotool.service`
for the daemon with /dev/uinput access), `dotool` (needs input group).

## Empirical protocol (per session × per target app)

1. Build locally (deps: `sudo pacman -S gtk-layer-shell` first; see ROADMAP R0).
2. Run nightjar from the terminal (logs visible).
3. Dictate a fixed 15-word phrase; paste into each target:
   KDE Plasma text fields: kate, konsole, firefox address bar, Chromium,
   Obsidian (electron).
4. Record per (session, target, tool): text landed? cursor position kept?
   IME/shortcut state broken? latency to first character?
5. Capture stderr from nightjar for each failure.

## Catalogued pain points to confirm or refute (from upstream README/issues)

- Overlay steals focus on X11 → paste lands in the wrong window
- wtype fails on KDE → what does Kwtype do differently, does it work?
- ydotool needs its daemon + uinput perms → does the service survive reboot?
- Pasting into terminals (konsole) vs GUI fields may need different paths
- Global shortcuts on Wayland must be configured per-DE — document the
  exact KDE shortcut dialog steps in-app

## Fixes (ordered after the catalog exists)

Each fix gets: a failing repro note in this file, the fix, and a matrix row
re-run. Posture fixes (detection surfacing, guidance in settings UI) only
after at least one injection bug is fixed.

## Done when

Dictation → paste works into all five target apps on KDE Wayland and GNOME
Wayland with no manual compositor tweaks, and the chosen tool is visible in
Settings.
