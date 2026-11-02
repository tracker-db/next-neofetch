#!/bin/bash
# Run ON the target server. Installs neofetch + the NeXT Research banner (from ./files).
set -euo pipefail
cd "$(dirname "$0")"
echo "TARGET: $(hostname)"
[ "$(uname -m)" = x86_64 ] || { echo "Wrong arch, aborting"; exit 1; }
. /etc/os-release; echo "OS: $PRETTY_NAME"
(cd files && sha256sum -c SHA256SUMS >/dev/null) || { echo "Checksum failed"; exit 1; }
read -r -p "Install on $(hostname)? [y/N] " a; [ "$a" = y ] || exit 1
sudo apt-get update
sudo apt-get install -y neofetch toilet
sudo apt-get install -y --only-upgrade neofetch toilet
sudo install -D -m 755 -o root -g root files/next-banner /opt/next-banner/next-banner
grep -qxF /opt/next-banner/next-banner /etc/profile || echo /opt/next-banner/next-banner | sudo tee -a /etc/profile >/dev/null
neofetch --version
/opt/next-banner/next-banner
echo ">> Done. Open a NEW session to confirm the banner shows at login."
