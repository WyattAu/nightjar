#!/usr/bin/env bash
# Dev-run wrapper for nightjar: fixes the two launch blockers of a tree build.
#
# 1. libtranscribe.so.0.4 + ggml libs are not on any default search path
#    (bundled builds get an rpath into /usr/lib/Nightjar; tree builds don't).
# 2. ggml's CPU backend is a variant-dispatch build: libggml-cpu-<arch>.so
#    modules land in out/build/bin/, one directory away from libtranscribe.so,
#    while transcribe_init_backends(artifact_dir) scans only that dir.
#    The symlinks below close the gap (upstream CMake should do this).
#
# Usage: scripts/dev-run.sh [--build]
#   --build  run cargo build first (env: CMAKE_PREFIX_PATH + CPATH set for
#            the SPIRV no-sudo recipe; see docs/ROADMAP.md R0)

set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TAURI="$ROOT/src-tauri"
BUILD="$TAURI/target/debug/build"

if [[ "${1:-}" == "--build" ]]; then
  SPIRV_PREFIX="$HOME/dev/src/thirdparty/spirv-install"
  CMAKE_PREFIX_PATH="$SPIRV_PREFIX" CPATH="$SPIRV_PREFIX/include" \
    cargo build --manifest-path "$TAURI/Cargo.toml"
fi

SYS_TRANS=$(find "$BUILD" -path "*transcribe-cpp-sys*/out/build/src/libtranscribe.so.0.4" 2>/dev/null | head -n1)
[ -n "$SYS_TRANS" ] || { echo "libtranscribe.so.0.4 not found — cargo build first"; exit 1; }
LIBDIR=$(dirname "$SYS_TRANS")
GGMLDIR="$LIBDIR/../ggml/src"

# Backend modules: symlink ggml's variant-dispatch CPU .so files next to
# libtranscribe so transcribe_init_backends() finds them.
for m in "$LIBDIR/../bin"/libggml-cpu-*.so; do
  [ -e "$m" ] && ln -sf "$m" "$LIBDIR/$(basename "$m")"
done

export LD_LIBRARY_PATH="$LIBDIR:$GGMLDIR${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec "$TAURI/target/debug/nightjar" "$@"
