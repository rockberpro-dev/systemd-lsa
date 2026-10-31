# Install Guide

Details that the [README](README.md) leaves out: what the setup script does, how to install by hand, and how to remove everything.

## What the setup script does

The script makes two changes:

1. It copies `systemd-lsa.sh` and `systemd-lsa-help.sh` to `~/.config/systemd-lsa/` (or `$XDG_CONFIG_HOME/systemd-lsa/`).
2. It adds a single `source` line to `~/.bashrc`.

Read the source before you run it: [setup.sh](setup.sh).

To install from a local clone instead of downloading, run [setup-local.sh](setup-local.sh).

## Manual install

```bash
mkdir -p ~/.config/systemd-lsa

curl -sL https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/systemd-lsa.sh \
  -o ~/.config/systemd-lsa/systemd-lsa.sh

curl -sL https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/systemd-lsa-help.sh \
  -o ~/.config/systemd-lsa/systemd-lsa-help.sh && chmod +x ~/.config/systemd-lsa/systemd-lsa-help.sh

echo 'source ~/.config/systemd-lsa/systemd-lsa.sh' >> ~/.bashrc
source ~/.bashrc
```

## Uninstall

```bash
# Remove the source line from .bashrc
sed -i '/\/systemd-lsa\/systemd-lsa\.sh/d' ~/.bashrc

# Remove the files
rm -r ~/.config/systemd-lsa
```

## Files

[setup.sh](setup.sh) · [setup-local.sh](setup-local.sh) · [systemd-lsa.sh](systemd-lsa.sh) · [systemd-lsa-help.sh](systemd-lsa-help.sh)
