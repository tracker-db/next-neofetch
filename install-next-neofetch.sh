#!/bin/bash
# Run ON the target server. Installs neofetch + the NeXT Research banner (from ./files). No prompts.
set -euo pipefail
cd "$(dirname "$0")"
APT="sudo env DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get -y -o Dpkg::Options::=--force-confold"
echo "TARGET: $(hostname)"
[ "$(uname -m)" = x86_64 ] || { echo "Wrong arch, aborting"; exit 1; }
(cd files && sha256sum -c SHA256SUMS >/dev/null) || { echo "Checksum failed"; exit 1; }
$APT update
$APT install neofetch toilet
sudo install -D -m 755 -o root -g root files/next-banner /opt/next-banner/next-banner
grep -qxF /opt/next-banner/next-banner /etc/profile || echo /opt/next-banner/next-banner | sudo tee -a /etc/profile >/dev/null
neofetch --version
/opt/next-banner/next-banner
echo ">> Done. Open a NEW session to confirm the banner shows at login."
