# Fixed pomodoro.fish
set -g pomo_work 25
set -g pomo_break 5

function pomodoro
    if test "$argv[1]" = work
        set val work
        set minutes $pomo_work
    else if test "$argv[1]" = break
        set val break
        set minutes $pomo_break
    else
        return
    end
    echo $val
    timer $minutes"m"
    paplay /usr/share/sounds/freedesktop/stereo/bell.oga
end

alias pwo="pomodoro work"
alias pbr="pomodoro break"
