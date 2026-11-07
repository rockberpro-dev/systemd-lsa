#!/bin/bash
# Records the demo and renders resources/img/demo.svg
set -e
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$HERE/../.."
WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
SANDBOX="$ROOT/../systemd-lsa-demo"
rm -rf "$SANDBOX"; mkdir -p "$SANDBOX"
if command -v bunx >/dev/null; then RUN="bunx"; else RUN="npx -y"; fi
cd "$SANDBOX"
asciinema rec --overwrite -q -i 1 --cols 80 --rows 18 \
  -c "bash $HERE/play.sh $HERE/script.txt $ROOT/systemd-lsa.sh $ROOT/systemd-lsa-help.sh" "$WORK/demo.cast"
sed -i "s#$HOME#~#g" "$WORK/demo.cast"
mkdir -p "$ROOT/resources/img"
cd "$WORK"
$RUN svg-term-cli --in demo.cast --out "$ROOT/resources/img/demo.svg" --window --no-cursor --padding 10
