#!/bin/sh
# Install the Berg theme plugin into OpenIDEA (Linux, macOS).
# Usage: ./install.sh            (override the target with OPENIDEA_DATA_DIR)
set -eu

id="theme-berg"
src="$(cd "$(dirname "$0")" && pwd)"

if [ -n "${OPENIDEA_DATA_DIR:-}" ]; then
  data="$OPENIDEA_DATA_DIR"
elif [ "$(uname -s)" = "Darwin" ]; then
  data="$HOME/Library/Application Support/ai.l0ng.openidea"
else
  data="${XDG_DATA_HOME:-$HOME/.local/share}/ai.l0ng.openidea"
fi

plugins="$data/plugins"
target="$plugins/$id"
staging="$plugins/.install-$id"

mkdir -p "$plugins"
rm -rf "$staging"
mkdir -p "$staging/themes"
cp "$src/plugin.toml" "$src/LICENSE" "$staging/"
cp "$src/themes/berg.theme.json" "$src/themes/berg.scheme.json" "$staging/themes/"
rm -rf "$target"
mv "$staging" "$target"

echo "Installed Berg into $target"
echo "Restart OpenIDEA, then press Apply next to 'Berg Theme' in Settings > Plugins."
