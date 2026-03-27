#!/usr/bin/env bash

set -euo pipefail

JEKYLL_CMD="jekyll serve --port=8080 --host=0.0.0.0 --livereload --trace"
JEKYLL_MATCH="jekyll serve .*--port=8080"

is_jekyll_running() {
    pgrep -f "$JEKYLL_MATCH" >/dev/null 2>&1
}

echo "[devcontainer] Preparing Ruby gems..."
bundle check >/dev/null 2>&1 || bundle install

if is_jekyll_running; then
    echo "[devcontainer] Jekyll already running on port 8080. Skipping duplicate start."
    exit 0
fi

echo "[devcontainer] Starting Jekyll dev server..."
exec bundle exec $JEKYLL_CMD
