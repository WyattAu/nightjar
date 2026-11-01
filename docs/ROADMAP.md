# nightjar ROADMAP

Working name; confirm before first public release. R0 blocks any distribution.

## R0: Rebrand (release-blocking)

Upstream MIT covers the code; the Handy name, logo, and brand assets are
explicitly excluded and forks must not imply endorsement.

- [x] Name check 2026-10-31 + confirmed final 2026-11-01: "nightjar" taken
      on crates.io + npm (irrelevant for a desktop app; any future crate
      publishes as a suffixed name). Repo name + product name Nightjar stand.
- [x] tauri.conf: productName Nightjar, identifier com.wyattau.nightjar
- [x] Cargo package/bin/lib renamed (nightjar, nightjar_app_lib; main.rs
      imports updated); frontend `bun run build` green (tsc + vite)
- [x] Icon set regenerated from assets/icon-source.svg (placeholder glyph,
      rsvg-rendered; hand-tune pass still owed)
- [x] Brand strings purged across src/, src-tauri/, nix/, scripts/, locales
      (26 locale files), NSIS installer, CI workflow; attribution retained
      in README/NOTICE/docs only
- [x] Updater decoupled from upstream: createUpdaterArtifacts=false,
      endpoints=[], upstream Windows Trusted Signing signCommand removed
- [x] Functional model URLs verified resolving 2026-10-31 (both
      blob.handy.computer model hosts: HTTP 200)
- [ ] Icon hand-tune at 32/128/256/512 (placeholder is serviceable)
- [x] Linux build green: **CI-verified 2026-11-01** (ubuntu-24.04 runner,
      workflow ci.yml `cargo check` job) with the full BUILD.md apt dep set;
      frontend tsc+vite green. Note for local builds: apt/ubuntu splits
      `glslc` into its own package (glslang-tools lacks it), and Arch needs
      `spirv-headers` installed. Local Arch gap measured 2026-11-01 by
      pkg-config sweep: ONLY `gtk-layer-shell` missing of the whole set
      (`sudo pacman -S gtk-layer-shell`). No-sudo alternative (verified
      2026-11-01;
      a raw KhronosGroup/SPIRV-Headers clone is NOT enough — CMake needs a
      generated config, so generate + install a prefix):
        cmake -S ~/dev/src/github.com/KhronosGroup/SPIRV-Headers -B /tmp/spirv-build
        cmake --install /tmp/spirv-build --prefix ~/dev/src/thirdparty/spirv-install
        CMAKE_PREFIX_PATH=$HOME/dev/src/thirdparty/spirv-install cargo check
      Rename-compile safety verified:
      mixed-case sweep clean outside attribution files, all handy_app_lib
      call sites updated (5/5), internal handy_keys/HANDY_ identifiers
      intentionally preserved (feature names, not brand).
- [x] Upstream CLAUDE.md relocated to docs/UPSTREAM-CLAUDE.md (2026-11-01;
      V2 discovers only AGENTS.md, so it was inert). Content merge into
      AGENTS.md deferred to R1.

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
