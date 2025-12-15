# Environment variables
set -U fish_greeting

# SSH agent
if not test -S ~/.ssh/ssh_auth_sock
    eval (ssh-agent -c)
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
end
set -gx SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock

set -gx PATH $PATH /home/flaggzz/.local/bin

# Nvim
fish_add_path -a /home/flaggzz/.local/share/bob/nvim-bin

# Rust
fish_add_path -a /home/flaggzz/.cargo/bin

# Java
set -gx JAVA_HOME /usr/lib/jvm/java-11-openjdk
fish_add_path $JAVA_HOME/bin

# Android
set -gx ANDROID_HOME /opt/android-sdk
fish_add_path -a $ANDROID_HOME/tools
fish_add_path -a $ANDROID_HOME/platform-tools
fish_add_path -a $ANDROID_HOME/cmdline-tools/latest/bin

# asdf
fish_add_path ~/.asdf/shims ~/.asdf/bin

# idf
set -gx IDF_PATH ~/esp/esp-idf

# go
set -gx GOBIN ~/go/bin
set -gx GOPATH ~/go
fish_add_path $GOBIN

# pnpm
set -gx PNPM_HOME "/home/flaggzz/.local/share/pnpm"
if not contains $PNPM_HOME $PATH
  fish_add_path -a $PNPM_HOME
end

function mkdirc
  if test -z "$argv[1]"
    echo "Error: Please provide a directory name"
    return 1
  end
  mkdir -p "$argv[1]" && cd "$argv[1]"
end

if status is-interactive
    zoxide init --cmd cd fish | source

    # Aliases
    alias la="eza -la"
    alias ls="eza"
    alias pingle="gping google.com"
    # py
    alias mkpyenv="python -m venv python-env"
    alias pyenv="source ./python-env/bin/activate.fish"
    alias py="python"
    # platformio
    alias piom="pio device monitor"
    alias pioufs="pio run -t uploadfs"
    alias piou="pio run -t upload"
    alias piodb="pio run -t compiledb"
    alias pioum="pio run -t upload && pio device monitor"
    # idf
    alias esps="source ~/esp/esp-idf/export.fish"
    alias idb="idf.py build"
    alias idbfm="idf.py build flash monitor"
    alias idmc="idf.py menuconfig"
    alias idf="idf.py flash"
    alias idm="idf.py monitor"
    alias idfc="idf.py fullclean"
    # Docker
    alias dprune="docker system prune -a"
    # git
    alias gs="git status"
    alias ga="git add ."
    alias gc="git commit -m"
    alias gp="git push"
    alias gpl="git pull"
    alias gco="git checkout"
    alias gcode="git checkout dev"
    alias gcom="git checkout main"
    alias gl="git log --oneline --graph --all"
    alias gst="git stash"
    alias gstu="git stash --include-untracked"
    alias gsta="git stash apply"
    alias gstc="git stash clear"
    alias gf="git fetch"
    alias gt="git tag -a"
    alias gpt="git push origin tag"

    alias pavu="pavucontrol"
end

# Docker
function dcu
  docker-compose up $argv
end
function dcd
  docker-compose down $argv
end

function ssh
    TERM=xterm-256color command ssh $argv
end

function mkgif -a input_file
    set output_file (basename $input_file | sed 's/\.[^.]*$/.gif/')
    ffmpeg -i $input_file -vf scale=320:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 10 -loop 0 - $output_file
end

