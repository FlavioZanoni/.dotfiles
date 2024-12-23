# Environment variables
set -U fish_greeting
set -Ux SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
set -Ux PATH $PATH /home/flaggzz/.local/bin

# Nvim
set -Ux PATH $PATH /home/flaggzz/.local/share/bob/nvim-bin

# Rust
set -Ux PATH $PATH /home/flaggzz/.cargo/bin

# Java
set -Ux JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -Ux PATH $JAVA_HOME/bin $PATH

# Android
set -Ux ANDROID_HOME /opt/android-sdk
set -Ux PATH $PATH $ANDROID_HOME/tools
set -Ux PATH $PATH $ANDROID_HOME/platform-tools
set -Ux PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin

# pipx
set -Ux PATH $PATH /home/flaggzz/.local/bin

if not test -S ~/.ssh/ssh_auth_sock
    eval (ssh-agent -s | string split ';' | string trim)
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
    ssh-add ~/.ssh/github
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
    alias dcu="docker-compose up"
    alias dcd="docker-compose down"
    alias mkpyenv="python -m venv python-env"
    alias pyenv="source ./python-env/bin/activate"
    alias py="python"
    alias pingle="gping google.com"
end
