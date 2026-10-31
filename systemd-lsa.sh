# ==============================================================================
# LSA — Logical Systemd Aliases
# https://github.com/rockberpro-dev/systemd-lsa
#
# Install:
#   curl -sL https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/setup.sh | bash
#
# Manual install:
#   echo 'source ~/.config/systemd-lsa/systemd-lsa.sh' >> ~/.bashrc && source ~/.bashrc
# ==============================================================================

# --- SERVICE ---
alias sc='systemctl'
alias scs='systemctl status'
alias scst='systemctl start'
alias scsp='systemctl stop'
alias scr='systemctl restart'
alias scrl='systemctl reload'
alias sce='systemctl enable --now'
alias scd='systemctl disable --now'
alias scm='systemctl mask'
alias scn='systemctl unmask'

# --- INSPECT ---
alias scl='systemctl list-units --type=service'
alias scla='systemctl list-unit-files'
alias scf='systemctl --failed'
alias scc='systemctl cat'
alias sced='systemctl edit'
alias scdr='systemctl daemon-reload'
alias sct='systemctl list-timers'

# --- LOGS ---
alias jl='journalctl'
alias jlf='journalctl -f'
alias jlu='journalctl -u'
alias jluf='journalctl -fu'
alias jlb='journalctl -b'
alias jle='journalctl -p err -b'
alias jlk='journalctl -k'
alias jlx='journalctl -xe'
alias jls='journalctl --since'
alias jld='journalctl --disk-usage'

# --- USER UNITS ---
alias scu='systemctl --user'
alias scus='systemctl --user status'
alias scur='systemctl --user restart'
alias scue='systemctl --user enable --now'
alias scud='systemctl --user disable --now'
alias scul='systemctl --user list-units --type=service'
alias jlus='journalctl --user -u'

# --- POWER ---
alias scrb='systemctl reboot'
alias scpo='systemctl poweroff'
alias scsl='systemctl suspend'

# --- HELP ---
alias lsa='"${XDG_CONFIG_HOME:-$HOME/.config}/systemd-lsa/systemd-lsa-help.sh"'
