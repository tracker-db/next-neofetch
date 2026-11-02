#!/bin/bash
# Usage: ./install-next-neofetch.sh HOST PORT [USER] [KEYFILE]
# Installs neofetch + the NeX T banner (from ./files) on the TARGET server.
set -euo pipefail
cd "$(dirname "$0")"
HOST=${1:?usage: $0 HOST PORT [USER] [KEYFILE]}
PORT=${2:?usage: $0 HOST PORT [USER] [KEYFILE]}
USER_=${3:-ej}
KEY=${4:-$HOME/.ssh/user51}
SSH_OPTS=(-o IdentitiesOnly=yes -i "$KEY")

echo "=========================================="
echo " TARGET: $USER_@$HOST  port $PORT"
echo "=========================================="
(cd files && shasum -a 256 -c SHA256SUMS >/dev/null) || { echo "Checksum failed in files/"; exit 1; }
read -r -p "Install on this target? [y/N] " a; [ "$a" = y ] || exit 1

scp -P"$PORT" "${SSH_OPTS[@]}" files/next-banner "$USER_@$HOST:/tmp/next-banner"

ssh -t -p"$PORT" "${SSH_OPTS[@]}" "$USER_@$HOST" '
set -e
echo "Connected to: $(hostname)"
[ "$(uname -m)" = x86_64 ] || { echo "Wrong arch, aborting"; exit 1; }
. /etc/os-release; echo "OS: $PRETTY_NAME"
sudo apt-get update
sudo apt-get install -y neofetch toilet
sudo apt-get install -y --only-upgrade neofetch toilet
sudo install -D -m 755 -o root -g root /tmp/next-banner /opt/next-banner/next-banner
rm -f /tmp/next-banner
grep -qxF /opt/next-banner/next-banner /etc/profile || echo /opt/next-banner/next-banner | sudo tee -a /etc/profile >/dev/null
neofetch --version
/opt/next-banner/next-banner
'
echo ">> Done. Open a NEW session to the target to confirm the banner shows at login."
