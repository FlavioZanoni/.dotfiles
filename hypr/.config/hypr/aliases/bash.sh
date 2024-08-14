#!/usr/bin/env bash

alias update-rice='~/.config/hypr/manage/update.sh'
alias reload-rice-bar='~/.config/hypr/waybar/start'
alias take-screenshot='~/.config/hypr/scripts/screenshot.sh'

query-rice-color () {
    theme_path="$HOME/.cache/hyprland_rice/theme/theme.txt"
    fallback_color='#ff0000'

    if [[ "$1" == '--help' ]] || [[ "$1" == 'help' ]] || [[ "$1" == '-h' ]] || [[ "$1" == '--h' ]]; then
        echo "Usage: <QUERY> [FALLBACK COLOR]"
        echo " "
        echo "If you do not specify a fallback color,"
        echo "'${fallback_color}' will be used by default."
        echo " "
        echo "Query is not fuzzy."
        echo "It must match the field name in the theme.txt file."

        return 0
    fi

    [[ "$2" == "" ]] || fallback_color="$2"

    if [[ -f "${theme_path}" ]]; then
        q_color="$(cat "${theme_path}" | grep "\$$1 " | awk -F ' -> ' '{ print $2 }' | sed 's/;$//g')"

        if echo ${q_color} | grep '#' > /dev/null 2>&1; then
            echo "${q_color}"
        else
            echo "${fallback_color}"
        fi
    else
        echo "${fallback_color}"
    fi
}
