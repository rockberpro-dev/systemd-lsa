<p align="center">
  <img src="resources/img/logo.png" alt="LSA logo" width="200">
</p>

<h1 align="center">Logical Systemd Aliases</h1>

<p align="center">A curated set of short, memorable systemd aliases organized by category.</p>

## Install

```bash
curl -sL https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/setup.sh | bash
```

Then reload your shell:

```bash
source ~/.bashrc
```

The script copies the files to `~/.config/systemd-lsa/` and adds a `source` line to `~/.bashrc`.

Manual install, upgrade and uninstall: [GUIDE.md](GUIDE.md).

## How It Reads

`sc` is **systemctl** and `jl` is **journalctl**. One-letter **suffix** is the first letter of the subcommand or flag. A `u` after the prefix switches to `--user`.

```
scs   → systemctl status        jl    → journalctl
scst  → systemctl start         jlf   → journalctl -f
scsp  → systemctl stop          jlu   → journalctl -u
scr   → systemctl restart       jluf  → journalctl -fu
sce   → systemctl enable --now  jlb   → journalctl -b
scf   → systemctl --failed      jle   → journalctl -p err -b

scus  → systemctl --user status
scur  → systemctl --user restart
```

Run `lsa` to see every alias right in your terminal.

## Alias Reference

| Alias | Command | Group |
| ----- | ------- | ----- |
| `sc` | `systemctl` | Service |
| `scs` | `systemctl status` | Service |
| `scst` | `systemctl start` | Service |
| `scsp` | `systemctl stop` | Service |
| `scr` | `systemctl restart` | Service |
| `scrl` | `systemctl reload` | Service |
| `sce` | `systemctl enable --now` | Service |
| `scd` | `systemctl disable --now` | Service |
| `scm` | `systemctl mask` | Service |
| `scn` | `systemctl unmask` | Service |
| `scl` | `systemctl list-units --type=service` | Inspect |
| `scla` | `systemctl list-unit-files` | Inspect |
| `scf` | `systemctl --failed` | Inspect |
| `scc` | `systemctl cat` | Inspect |
| `sced` | `systemctl edit` | Inspect |
| `scdr` | `systemctl daemon-reload` | Inspect |
| `sct` | `systemctl list-timers` | Inspect |
| `jl` | `journalctl` | Logs |
| `jlf` | `journalctl -f` | Logs |
| `jlu` | `journalctl -u` | Logs |
| `jluf` | `journalctl -fu` | Logs |
| `jlb` | `journalctl -b` | Logs |
| `jle` | `journalctl -p err -b` | Logs |
| `jlk` | `journalctl -k` | Logs |
| `jlx` | `journalctl -xe` | Logs |
| `jls` | `journalctl --since` | Logs |
| `jld` | `journalctl --disk-usage` | Logs |
| `scu` | `systemctl --user` | User Units |
| `scus` | `systemctl --user status` | User Units |
| `scur` | `systemctl --user restart` | User Units |
| `scue` | `systemctl --user enable --now` | User Units |
| `scud` | `systemctl --user disable --now` | User Units |
| `scul` | `systemctl --user list-units --type=service` | User Units |
| `jlus` | `journalctl --user -u` | User Units |
| `scrb` | `systemctl reboot` | Power |
| `scpo` | `systemctl poweroff` | Power |
| `scsl` | `systemctl suspend` | Power |
| `lsa` | show alias table | Help |

---

[GUIDE.md](GUIDE.md) · [CHANGELOG.md](CHANGELOG.md) · [setup.sh](setup.sh) · [systemd-lsa.sh](systemd-lsa.sh) · [systemd-lsa-help.sh](systemd-lsa-help.sh)
