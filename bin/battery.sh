#!/bin/bash

# |  ⚡︎
# |  ⚠  
# |  2588   |  █    | FULL BLOCK                 | →25A0(■)   |
# |  2589   |  ▉    | LEFT SEVEN EIGHTHS BLOCK   |            |
# |  258A   |  ▊    | LEFT THREE QUARTERS BLOCK  |            |
# |  258B   |  ▋    | LEFT FIVE EIGHTHS BLOCK    |            |
# |  258C   |  ▌    | LEFT HALF BLOCK            |            |
# |  258D   |  ▍    | LEFT THREE EIGHTHS BLOCK   |            |
# |  258E   |  ▎    | LEFT ONE QUARTER BLOCK     |            |
# |  258F   |  ▏    | LEFT ONE EIGHTH BLOCK      |            |

has() { type "$1" &>/dev/null; }

# If the current_bat is less than the BATTERY_DANGER,
# output color will be red
BATTERY_DANGER=20

# get_battery returns remaining battery
get_battery() {
    local current_bat percentage

    if has "pmset"; then
        current_bat="$(pmset -g ps | grep -o '[0-9]\+%' | tr -d '%')"
    elif has "ioreg"; then
        local _battery_info _max_cap _cur_cap
        _battery_info="$(ioreg -n AppleSmartBattery)"
        _max_cap="$(echo "$_battery_info" | awk '/MaxCapacity/{print $5}')"
        _cur_cap="$(echo "$_battery_info" | awk '/CurrentCapacity/{print $5}')"
        current_bat="$(awk -v cur="$_cur_cap" -v max="$_max_cap" 'BEGIN{ printf("%.2f\n", cur/max*100) }')"
    fi

    # trim dot (e.g., 79.61 -> 79)
    percentage="${current_bat%%.*}"
    if [ -n "$percentage" ]; then
        echo "$percentage%"
    fi
}

# is_charging returns true if the battery is charging
is_charging() {
    if has "pmset"; then
        pmset -g ps | grep "AC Power" >/dev/null 2>&1
        if [ $? -eq 0  ]; then
            echo "1"
        else
            echo "0"
        fi
    elif has "ioreg"; then
        ioreg -c AppleSmartBattery | grep "IsCharging" | grep "Yes" >/dev/null 2>&1
        return $?
    else
        return 1
    fi
}

# battery_color_ansi colourizes the battery level for the terminal
battery_color_ansi() {
    local percentage
    percentage="${1:-$(get_battery)}"

    if is_charging; then
        [[ -n $percentage ]] && echo -e "\033[32m[battery: ${percentage} ($(battery.bash -r))]\033[0m"
    else
        # percentage > BATTERY_DANGER
        if [ "${percentage%%%*}" -ge "$BATTERY_DANGER" ]; then
            echo -e "\033[34m[battery: ${percentage} ($(battery.bash -r))]\033[0m"
        else
            echo -e "\033[31m[battery: ${percentage} ($(battery.bash -r))]\033[0m"
        fi
    fi
}

# battery_color_tmux colourizes the battery level for tmux
battery_color_tmux() {
    local percentage
    percentage="${1:-$(get_battery)}"

    if is_charging; then
        [[ -n $percentage ]] && echo -e "#[bg=yellow][battery: ${percentage} ($(battery.bash -r))]#[default]"
    else
        # percentage > BATTERY_DANGER
        if [ "${percentage%%%*}" -ge "$BATTERY_DANGER" ]; then
            echo -e "#[bg=blue][battery: ${percentage} ($(battery.bash -r))]#[default]"
        else
            echo -e "#[bg=red][battery: ${percentage} ($(battery.bash -r))]#[default]"
        fi
    fi
}

get_remain() {
    local time_remain

    if has "pmset"; then
        time_remain="$(pmset -g ps | grep -o '[0-9]\+:[0-9]\+')"
        if [ -z "$time_remain" ]; then
            time_remain="no estimate"
        fi
    elif has "ioreg"; then
        local itte
        itte="$(ioreg -n AppleSmartBattery | awk '/InstantTimeToEmpty/{print $5}')"
        time_remain="$(awk -v remain="$itte" 'BEGIN{ printf("%dh%dm\n", remain/60, remain%60) }')"
        if [ -z "$time_remain" ] || [ "${time_remain%%h*}" -gt 10 ]; then
            time_remain="no estimate"
        fi
    else
        tmux
        time_remain="no estimate"
    fi

    echo "$time_remain"
    if [ "$time_remain" = "no estimate" ]; then
        return 1
    fi
}


parameter() {
    echo "!"
}


my_tmux() {
    local percentage
    percentage="${1:-$(get_battery)}"

    local state=""
    if [[ "1" == "$is_charging" ]]; then
        state="[ ⚡︎]"
    else
        state=""
    fi

    if [ "0:00" = "$get_remain" ]; then
        rem=""
    else
        rem=" ($(get_remain))"
    fi
    if is_charging; then
        [[ -n $percentage ]] && echo -e "#[bg=yellow][${percentage}:$state]#[default]"
    else
        # percentage > BATTERY_DANGER
        if [ "${percentage%%%*}" -ge "$BATTERY_DANGER" ]; then
            echo -e "#[bg=blue][${percentage}$rem:$state]#[default]"
        else
            echo -e "#[bg=red][${percentage}$rem):$state]#[default]"
        fi
    fi
}



# this scripts is supported OS X only now
# if ! is_osx; then
#     echo "OS X only" 1>&2
#     exit 1
# fi

# check arguments
for i in "$@"
do
    case "$i" in
        "-h"|"--help")
            echo "usage: battery [--help|-h][--ansi|--tmux][-r|--remain]" 1>&2
            echo "  Getting the remaining battery, then" 1>&2
            echo "  outputs and colourizes with options" 1>&2
            exit
            ;;
        "--ansi")
            battery_color_ansi "$(get_battery)"
            exit $?
            ;;
        "--tmux")
            battery_color_tmux "$(get_battery)"
            exit $?
            ;;
        "-r"|"--remain")
            get_remain
            exit $?
            ;;
        "-m")
            my_tmux "$(get_battery)"
            exit $?
            ;;
        "-i")
            echo $(is_charging)
            exit $?
            ;;
        -*|--*)
            echo "$i: unknown option" 1>&2
            exit 1
    esac
done

get_battery
