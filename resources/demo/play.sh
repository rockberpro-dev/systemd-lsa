#!/bin/bash
# Fake-typing player for the LSA demo. Usage: play.sh <script.txt> <aliases.sh> <help.sh>
shopt -s expand_aliases
export LC_ALL=C.UTF-8 LANGUAGE=en_US:en
source "$2" 2>/dev/null
alias lsa="bash $3"
G=$'\e[32m'; D=$'\e[90m'; R=$'\e[0m'
sleep 0.8
while IFS= read -r line; do
  if [[ $line == \#* ]]; then printf '%s%s%s\n' "$D" "$line" "$R"; sleep 0.6; continue; fi
  printf '%s$ %s' "$G" "$R"
  for ((i=0;i<${#line};i++)); do printf '%s' "${line:i:1}"; sleep 0.07; done
  printf '\n'
  eval "$line"
  sleep 1.2
done < "$1"
sleep 2
