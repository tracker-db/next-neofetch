#!/bin/bash
# Run ON the target server. Reverses install-next-neofetch.sh. No prompts.
set -euo pipefail
H=$(hostname)
echo "TARGET: $H"
[ "$H" != bastion ] || { echo "Refusing: this is bastion2, the source of the banner"; exit 1; }
APT="sudo env DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get -y"
sudo cp /etc/profile /etc/profile.bak-uninstall
sudo sed -i '\|^/opt/next-banner/next-banner$|d' /etc/profile
sudo rm -rf /opt/next-banner
$APT remove neofetch toilet
echo "== verify =="
echo "next-banner lines left in /etc/profile: $(grep -c next-banner /etc/profile || true)"
[ -e /opt/next-banner ] && echo "/opt/next-banner STILL EXISTS" || echo "/opt/next-banner gone"
command -v neofetch toilet || echo "neofetch and toilet gone"
echo ">> Done. Open a NEW session: no banner should show."
