# next-neofetch

Installs neofetch and the NeXT Research login banner on a target Ubuntu 22.04 x86_64 server. No prompts.

**Public repo: it contains no secrets.** No passwords, tokens or keys. The SSH key is only referenced by path on your own machine. `files/next-banner` is a prebuilt binary copied from the source server, with checksums in `files/SHA256SUMS`.

## Run from your Mac

Set these once in your terminal (replace the placeholders):

```bash
TARGET_USER=your-user; TARGET_HOST=your.server.example; TARGET_PORT=22; KEY=~/.ssh/your-key
```

Install:

```bash
ssh -t -p$TARGET_PORT -o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes -i $KEY $TARGET_USER@$TARGET_HOST 'export GIT_TERMINAL_PROMPT=0; command -v git >/dev/null || sudo apt-get install -y git; rm -rf /tmp/next-neofetch && git clone --depth 1 https://github.com/tracker-db/next-neofetch.git /tmp/next-neofetch && cd /tmp/next-neofetch && ./install-next-neofetch.sh; cd /tmp; rm -rf /tmp/next-neofetch'
```

Uninstall:

```bash
ssh -t -p$TARGET_PORT -o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes -i $KEY $TARGET_USER@$TARGET_HOST 'export GIT_TERMINAL_PROMPT=0; command -v git >/dev/null || sudo apt-get install -y git; rm -rf /tmp/next-neofetch && git clone --depth 1 https://github.com/tracker-db/next-neofetch.git /tmp/next-neofetch && cd /tmp/next-neofetch && ./uninstall-next-neofetch.sh; cd /tmp; rm -rf /tmp/next-neofetch'
```

## Notes

- Run from the machine that holds the SSH key, never from the target itself.
- The user needs sudo on the target. A sudo password prompt is the only one that can appear.
- Uninstall refuses to run on a host named `bastion` (the banner source).
- If the target's `~/.profile` also calls `neofetch`, comment that line out to see only the banner.
- Install and uninstall clone the pushed repo, so push changes first.
