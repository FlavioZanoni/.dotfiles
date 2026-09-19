# Remember the last visited directory so new Kitty windows
# (Super+Return) open where you last were. The initial value is seeded
# without writing, so shell startup alone never pollutes the cache.
if status is-interactive
    set -g __hypr_last_cwd_prev $PWD
    function __hypr_last_cwd --on-variable PWD
        if test "$PWD" != "$__hypr_last_cwd_prev"
            set -g __hypr_last_cwd_prev $PWD
            mkdir -p ~/.cache/kitty
            echo $PWD >~/.cache/kitty/last_cwd
        end
    end
end
