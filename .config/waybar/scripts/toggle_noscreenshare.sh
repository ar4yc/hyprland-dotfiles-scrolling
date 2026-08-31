#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/windowrule/screenhide.lua"
STATE_FILE="$HOME/.config/waybar/.screenshare_rule_disabled"

toggle_rule() {
    if [ -f "$STATE_FILE" ]; then
        sed -i '/.*no_screen_share.*/s/^--//' "$CONFIG_FILE"
        rm -f "$STATE_FILE"
        CLASS="on"
        exec swaync-client -dn
    else
        sed -i '/.*no_screen_share.*/s/^/--/' "$CONFIG_FILE"
        touch "$STATE_FILE"
        CLASS="off"
        exec swaync-client -df
    fi
}

case ${1} in
    "toggle")
        toggle_rule
        ;;
    *)
        if [ -f "$STATE_FILE" ]; then
            CLASS="off"
        else
            CLASS="on"
        fi
        ;;
esac

echo "{\"class\": \"$CLASS\", \"alt\": \"$CLASS\"}"
