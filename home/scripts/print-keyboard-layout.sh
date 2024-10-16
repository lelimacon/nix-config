#!/bin/sh
#
# Print input language.

LAYOUT=$(hyprctl devices -j |
    jq -r '.keyboards[] | .active_keymap' |
    head -n1 |
    cut -c1-2 |
    tr 'a-z' 'A-Z')

text="$LAYOUT"

echo { \"text\": \"$text\" }
