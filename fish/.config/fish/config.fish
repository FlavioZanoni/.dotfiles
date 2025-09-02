# Environment variables
set -U fish_greeting
set -x SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
set -x PATH $PATH /home/flaggzz/.local/bin

# Nvim
set -x PATH $PATH /home/flaggzz/.local/share/bob/nvim-bin

# Rust
set -x PATH $PATH /home/flaggzz/.cargo/bin

# Java
set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -x PATH $JAVA_HOME/bin $PATH

# Android
set -x ANDROID_HOME /opt/android-sdk
set -x PATH $PATH $ANDROID_HOME/tools
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin

# asdf
set -x PATH ~/.asdf/shims ~/.asdf/bin $PATH

# idf
set -x IDF_PATH ~/esp/esp-idf

# go
set -gx GOBIN ~/go/bin
set -x GOPATH ~/go/bin
set -x PATH $GOPATH $PATH

# pnpm
set -gx PNPM_HOME "/home/flaggzz/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

if not test -S ~/.ssh/ssh_auth_sock
    eval (ssh-agent -s | string split ';' | string trim)
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
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
    alias la="ls -la"
    alias pingle="gping google.com"
    # py
    alias mkpyenv="python -m venv python-env"
    alias pyenv="source ./python-env/bin/activate.fish"
    alias py="python"
    # platformio
    alias piom="pio device monitor"
    alias pioufs="pio run -t uploadfs"
    alias pioup="pio run -t upload"
    alias piodb="pio run -t compiledb"
    alias piomr="pio run -t upload && pio device monitor"
    # idf
    alias esps="source ~/esp/esp-idf/export.fish"
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

