#!/bin/bash

# =========================
# Configuration
# =========================
ALIAS_WIDTH=6
CMD_WIDTH=42
NUM_COLS=1
USE_COLOR=true

# =========================
# ANSI Colors
# =========================
if $USE_COLOR && [ -t 1 ]; then
  C_RESET='\033[0m'
  C_DIM='\033[2m'
  C_TITLE='\033[1;35m'
  C_GROUP='\033[1;34m'
  C_ALIAS='\033[32m'
  C_BORDER='\033[2;37m'
else
  C_RESET=''
  C_DIM=''
  C_TITLE=''
  C_GROUP=''
  C_ALIAS=''
  C_BORDER=''
fi

# =========================
# Border Characters
# =========================
TL='╔'
TR='╗'
BL='╚'
BR='╝'
ML='╠'
MR='╣'
MT='╦'
MB='╩'
H='═'
V='║'
VI='│'

# =========================
# Utility Functions
# =========================
b() {
  printf "%b%s%b" "$C_BORDER" "$1" "$C_RESET"
}

repeat_char() {
  local char="$1"
  local count="$2"
  local i
  local result=""

  for (( i = 0; i < count; i++ )); do
    result+="$char"
  done

  printf '%s' "$result"
}

hbar() {
  local left="$1"
  local middle="$2"
  local right="$3"
  shift 3

  printf "%b%s%b" "$C_BORDER" "$left" "$C_RESET"

  local first=1
  local width

  for width in "$@"; do
    if [[ $first -eq 0 ]]; then
      printf "%b%s%b" "$C_BORDER" "$middle" "$C_RESET"
    fi

    printf "%b%s%b" "$C_BORDER" "$(repeat_char "$H" "$width")" "$C_RESET"
    first=0
  done

  printf "%b%s%b\n" "$C_BORDER" "$right" "$C_RESET"
}

# =========================
# Read Aliases from file
# =========================
LSA_FILE="${SYSTEMD_LSA_FILE:-$(dirname "${BASH_SOURCE[0]}")/systemd-lsa.sh}"

if [[ ! -f "$LSA_FILE" ]]; then
  echo "Error: $LSA_FILE not found." >&2
  exit 1
fi

ALIASES=()
CURRENT_GROUP="Other"

SEP=$'\x01'

while IFS= read -r line; do
  if [[ "$line" =~ ^#[[:space:]]*---[[:space:]]*(.+)[[:space:]]*---$ ]]; then
    raw="${BASH_REMATCH[1]}"
    CURRENT_GROUP=$(echo "${raw,,}" | sed 's/\b./\u&/g')
    continue
  fi

  if [[ "$line" =~ ^alias[[:space:]]+([^=]+)=\'(.+)\'$ ]]; then
    name="${BASH_REMATCH[1]}"
    cmd="${BASH_REMATCH[2]}"
    ALIASES+=("${name}${SEP}${cmd}${SEP}${CURRENT_GROUP}")
  fi
done < "$LSA_FILE"

if (( ${#ALIASES[@]} == 0 )); then
  echo "No aliases found in $LSA_FILE."
  exit 0
fi

# =========================
# Group by Section
# =========================
declare -A ALIAS_GROUPS
declare -a ORDERED_GROUPS

for entry in "${ALIASES[@]}"; do
  alias_name="${entry%%${SEP}*}"
  rest="${entry#*${SEP}}"
  command="${rest%%${SEP}*}"
  group="${rest#*${SEP}}"

  if [[ -z "${ALIAS_GROUPS[$group]+set}" ]]; then
    ORDERED_GROUPS+=("$group")
    ALIAS_GROUPS[$group]=""
  fi

  ALIAS_GROUPS[$group]+="${alias_name}|${command}"$'\n'
done

# =========================
# Layout
# =========================
INNER_W=$((1 + ALIAS_WIDTH + 3 + CMD_WIDTH + 1))

WIDTHS=()
for (( i = 0; i < NUM_COLS; i++ )); do
  WIDTHS+=("$INNER_W")
done

# =========================
# Segmentation
# =========================
SEGMENTS=()

for group in "${ORDERED_GROUPS[@]}"; do
  SEGMENTS+=("HDR:${group}")

  while IFS= read -r row; do
    [[ -z "$row" ]] && continue
    SEGMENTS+=("ROW:${row}")
  done <<< "${ALIAS_GROUPS[$group]}"
done

total=${#SEGMENTS[@]}
chunk=$(( (total + NUM_COLS - 1) / NUM_COLS ))

while (( ${#SEGMENTS[@]} < chunk * NUM_COLS )); do
  SEGMENTS+=("")
done

# =========================
# Cell Rendering
# =========================
print_cell() {
  local segment="$1"
  local type="${segment%%:*}"
  local value="${segment#*:}"

  if [[ -z "$segment" ]]; then
    printf "%b%s%b%-${INNER_W}s" "$C_BORDER" "$V" "$C_RESET" ""

  elif [[ "$type" == "HDR" ]]; then
    local label="── ${value} ──"
    local pad=$(( INNER_W - 2 - ${#label} ))

    printf "%b%s%b %b%s%b%*s " \
      "$C_BORDER" "$V" "$C_RESET" \
      "$C_GROUP" "$label" "$C_RESET" \
      "$pad" ""

  elif [[ "$type" == "ROW" ]]; then
    local alias_name="${value%%|*}"
    local command="${value#*|}"

    if (( ${#command} > CMD_WIDTH )); then
      command="${command:0:$(( CMD_WIDTH - 1 ))}~"
    fi

    printf "%b%s%b %b%-${ALIAS_WIDTH}s%b %b%s%b %-${CMD_WIDTH}s " \
      "$C_BORDER" "$V" "$C_RESET" \
      "$C_ALIAS" "$alias_name" "$C_RESET" \
      "$C_BORDER" "$VI" "$C_RESET" \
      "$command"
  fi
}

# =========================
# Title
# =========================
TITLE=" Systemd Aliases "
TOTAL_W=$(( NUM_COLS * INNER_W + NUM_COLS - 1 ))

LEFT_PAD=$(( (TOTAL_W - ${#TITLE}) / 2 ))
RIGHT_PAD=$(( TOTAL_W - LEFT_PAD - ${#TITLE} ))

b "$TL"
b "$(repeat_char "$H" "$TOTAL_W")"
b "$TR"
echo

b "$V"
printf "%*s%b%s%b%*s" \
  "$LEFT_PAD" "" \
  "$C_TITLE" "$TITLE" "$C_RESET" \
  "$RIGHT_PAD" ""
b "$V"
echo

hbar "$ML" "$MT" "$MR" "${WIDTHS[@]}"

# =========================
# Rows
# =========================
for (( i = 0; i < chunk; i++ )); do
  for (( col = 0; col < NUM_COLS; col++ )); do
    idx=$(( col * chunk + i ))
    segment="${SEGMENTS[$idx]}"
    print_cell "$segment"
  done

  b "$V"
  echo
done

hbar "$BL" "$MB" "$BR" "${WIDTHS[@]}"

printf "%b  %d aliases across %d groups%b\n" \
  "$C_DIM" "${#ALIASES[@]}" "${#ORDERED_GROUPS[@]}" "$C_RESET"
