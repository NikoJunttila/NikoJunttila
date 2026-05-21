#!/usr/bin/env bash
# Bootstrap ~/.config/secrets/env with safe permissions.
# Idempotent: never overwrites an existing env file.
#
# After running, fill in the real values and they'll be sourced by .zshrc
# on next shell start (or `source ~/.config/secrets/env` to load immediately).

set -euo pipefail

SECRETS_DIR="$HOME/.config/secrets"
ENV_FILE="$SECRETS_DIR/env"

mkdir -p "$SECRETS_DIR"
chmod 700 "$SECRETS_DIR"

if [[ -e "$ENV_FILE" ]]; then
  echo "ok    $ENV_FILE already exists — leaving it alone"
else
  cat > "$ENV_FILE" <<'EOF'
# Sourced by ~/.zshrc. Keep this file out of any git repo.
# Permissions: chmod 600

export GROQ_API_KEY=
export OPENAI_API_KEY=
export TAILSCALE_AUTHKEY=
export TF_VAR_hcloud_token=
EOF
  echo "create $ENV_FILE (template — edit to add real values)"
fi

chmod 600 "$ENV_FILE"
echo "perms  $SECRETS_DIR (700), $ENV_FILE (600)"
