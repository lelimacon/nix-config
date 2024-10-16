#!/bin/sh
#
# Switch input language.
# From https://github.com/hyprwm/Hyprland/discussions/2616#discussioncomment-6327590

commands=$(
    hyprctl devices -j |
    jq -r '.keyboards[] | .name' |
    while IFS= read -r keyboard; do
        printf '%s %s %s;' 'switchxkblayout' "${keyboard}" 'next'
    done
)

hyprctl --batch "$commands"
