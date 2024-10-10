if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval "$(ssh-agent)"
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  ssh-add ~/.ssh/github 2> /dev/null
fi

# Set SSH_AUTH_SOCK environment variable
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit snippet OMZP::git;
zinit snippet OMZP::archlinux;
zinit snippet OMZP::command-not-found;
zinit snippet OMZP::colored-man-pages;

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
zinit ice wait lucid atload"_zsh_autosuggest_start;"; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k;

zinit wait lucid for OMZL::git.zsh;
. /opt/asdf-vm/asdf.sh
### End of Zinit's installer chunk

export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# Aliases
alias la="ls -la"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias esp-dev='. $HOME/esp-idf/export.sh'
alias esp='idf.py'
# End of aliases
mkdirc() {
  if [ -z "$1" ]; then
    echo "Error: Please provide a directory name"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2024-08-09 02:54:44
export PATH="$PATH:/home/flaggzz/.local/bin"
