# nightjar

Offline dictation for Linux first, Windows and macOS close behind. Press a key,
speak, get text in any field. Everything runs on your machine.

nightjar is a fork of [Handy](https://github.com/cjpais/Handy) (MIT), seeded
from upstream commit `7bfb2e2c934b` (see [docs/UPSTREAM.md](docs/UPSTREAM.md)
and the preserved [upstream README](docs/UPSTREAM-README.md)).

## Why this fork exists

Upstream is excellent and popular. This fork exists to go where upstream has
known, documented pain, and to hold a harder engineering line:

1. **Linux/Wayland first.** Upstream's own README documents overlay focus
   fights, paste failures, and per-compositor workarounds. nightjar targets
   Wayland text injection (wtype/ydotool/dotool) as the primary path, tested
   on real CachyOS GNOME and KDE, not a fallback note.
2. **Transparent post-processing.** No undocumented transformation of your
   words between the model and the text field.
3. **Voice suite, not just dictation.** Local TTS (voice studio) and a
   teleprompter mode land here, because the audio pipeline is already here.
4. **Estate engineering gates.** Tier-S CI, ADRs for decisions, measured
   claims in every release note (see `AGENTS.md`).

## Status

Seeded, pre-rebrand. See [docs/ROADMAP.md](docs/ROADMAP.md). R0 is mandatory
before any distribution: upstream's MIT license covers the code, but the
Handy name, logo, and brand assets do not, and upstream explicitly requires
forks to rebrand.

## License

MIT, preserved in [LICENSE](LICENSE). Upstream copyright CJ Pais and
contributors; this fork's changes are (c) 2026 WyattAu, same license.
