#!/usr/bin/env bash
set -euo pipefail

# --- git / GitHub -----------------------------------------------------------
# Identity (user.name/email) comes from the read-only ~/.gitconfig bind mount.
# Auth is configured in *system* config (/etc/gitconfig): it's writable and
# container-local, so it leaves the read-only global config and the bind-mounted
# .git/config (shared with the host) untouched.
#   - credential helper -> the mounted, already-authenticated gh CLI
#   - insteadOf -> rewrite an SSH remote to HTTPS so it uses the gh token
#     instead of an SSH key (the container has none)
sudo git config --system 'credential.https://github.com.helper' '!gh auth git-credential'
sudo git config --system 'url.https://github.com/.insteadOf' 'git@github.com:'
