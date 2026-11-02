# next-neofetch

Installs neofetch and the NeXT Research login banner on an Ubuntu 22.04 x86_64 server. No prompts.

**Public repo: it contains no secrets.** No passwords, tokens or keys. `files/next-banner` is a prebuilt binary copied from the source server, with checksums in `files/SHA256SUMS`.

## Use

1. Log in to the target server (from your Workstation via SSH or otherwise).
2. On the target, run **one** of these. Both clone the repo, run the script, then delete the clone.

Install:

```bash
command -v git >/dev/null || sudo apt-get install -y git; rm -rf /tmp/next-neofetch && git clone --depth 1 https://github.com/tracker-db/next-neofetch.git /tmp/next-neofetch && cd /tmp/next-neofetch && ./install-next-neofetch.sh; cd ~; rm -rf /tmp/next-neofetch
```

Uninstall:

```bash
command -v git >/dev/null || sudo apt-get install -y git; rm -rf /tmp/next-neofetch && git clone --depth 1 https://github.com/tracker-db/next-neofetch.git /tmp/next-neofetch && cd /tmp/next-neofetch && ./uninstall-next-neofetch.sh; cd ~; rm -rf /tmp/next-neofetch
```

3. Open a new session to the target to check the result.

## Notes

- Run these ON the target, never on the source server (hostname `bastion`); uninstall refuses to run there.
- The user needs sudo on the target. A sudo password prompt is the only one that can appear.
- If the target's `~/.profile` also calls `neofetch`, comment that line out to see only the banner.
- Both commands clone the pushed repo, so push script changes first.
