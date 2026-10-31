# nightjar ROADMAP

Working name; confirm before first public release. R0 blocks any distribution.

## R0: Rebrand (release-blocking)

Upstream MIT covers the code; the Handy name, logo, and brand assets are
explicitly excluded and forks must not imply endorsement.

- [ ] Final name check (crates.io, npm, GitHub, USPTO quick pass)
- [ ] Replace app name in tauri.conf identifier + product names, bundle
      metadata, tray, about dialog
- [ ] New icon set (generate, then hand-tune at 32/128/256/512)
- [ ] Purge brand strings from docs; keep upstream attribution in NOTICE
- [ ] Functional URLs (model blob hosts) stay; verify each still resolves

## R1: Wayland-first text injection

Upstream documents overlay focus fights, paste failures, and per-compositor
caveats. We make Wayland the primary, tested path.

- [ ] Injection backend selection: wtype → ydotool → dotool → enigo, chosen
      by compositor probe, overridable in settings
- [ ] Overlay disabled-by-default on Wayland with a real explanation in-app
- [ ] Test matrix: CachyOS KDE + GNOME + Hyprland, X11 regression pass
- [ ] Global shortcuts via compositor config with documented per-DE recipes

## R2: Transparent post-processing + reliability

- [ ] Upstream's post-processing flag documented and inspectable; every
      transform between model output and pasted text listed in settings
- [ ] Tail-audio and shortcut-state fixes tracked from upstream issues;
      cherry-pick against seed commit `7bfb2e2c934b`
- [ ] Model management: unload-on-idle option, download checksums

## R3: Voice suite

- [ ] TTS studio module: local models (Piper class first), per-voice
      profiles, reuse the record/transcribe pipeline
- [ ] Teleprompter mode: script scroll at WPM pace, mic-reactive emphasis,
      optional dictation hand-off to the same hotkey
- [ ] Shared audio graph on estate dsp-core; publish crates as they harden

## R4: Estate engineering line

- [ ] Replace upstream CI with the engineering-standards shared matrix,
      tier S dogfood (this repo runs its own gates)
- [ ] SPEC-CORE-conformant docs; ADR per architectural decision
- [ ] Release notes carry gate results + run dates (measured claims rule)
