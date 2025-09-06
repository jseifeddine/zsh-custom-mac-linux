export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dracula"

zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_AUTO_TITLE="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="%d-%m-%y %H:%M:%S%z"

# if on mac and running as root (sudo -s), disable compfix to avoid security warnings
[[ "$OSTYPE" == "darwin"* && ($EUID -eq 0 || $USER == "root") ]] && ZSH_DISABLE_COMPFIX="true"

plugins=(fast-syntax-highlighting zsh-autosuggestions fzf fzf-tab git zsh-bat docker)

[[ "$OSTYPE" == "darwin"* ]] && plugins+=(bundler sudo dotenv macos rake rbenv ruby brew)

# Load additional plugins from .local
[[ -f ~/.local/.zshrc_plugins ]] && source ~/.local/.zshrc_plugins

# reference completions directory as string on each line in this file
[[ -f ~/.local/.zshrc_completions ]] && while read -r p; do [[ -d "$p" ]] && FPATH=$FPATH:$p; done < ~/.local/.zshrc_completions

# zsh-completions plugin must be loaded like this and before sourcing oh-my-zsh.sh
[[ -d ~/.oh-my-zsh/custom/plugins/zsh-completions/src ]] && FPATH=$FPATH:~/.oh-my-zsh/custom/plugins/zsh-completions/src && autoload -Uz compinit $(if [ "$ZSH_DISABLE_COMPFIX" = "true" ]; then echo "-u"; fi) && compinit $(if [ "$ZSH_DISABLE_COMPFIX" = "true" ]; then echo "-u"; fi)

source $ZSH/oh-my-zsh.sh

# Better history handling for pasted commands
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export EDITOR='vim'

# show hostname (if ssh or root) and always show username
DRACULA_DISPLAY_CONTEXT=1

# Autosuggestions config
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

# Better completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh

# FZF-tab config
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Bindkeys
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[3;9~" kill-line

# # (BUG) Unset apt completions on macOS (fix for zsh-completions or fzf-tab)
[[ "$OSTYPE" == "darwin"* ]] && { unfunction _apt _apt-get _dpkg 2>/dev/null; complete -r apt apt-get 2>/dev/null; }

# # homebrew editor
type brew &>/dev/null && export HOMEBREW_EDITOR=vim

alias time-zsh='time zsh -i -c exit'

myip() {
    local dns_ip http_ip dns_ptr http_ptr ips_same
    dns_ip=$(command -v dig >/dev/null 2>&1 && dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || echo "DNS lookup failed")
    http_ip=$(command -v curl >/dev/null 2>&1 && curl --silent https://myip.ngn.au -H "Accept: application/json" | jq -r .ip 2>/dev/null || echo "HTTP lookup failed")
    if [[ $dns_ip != $http_ip ]]; then
        ips_same="true"; dns_ptr=$(dig +short -x $dns_ip @1.1.1.1 2>/dev/null); http_ptr=$(dig +short -x $http_ip @1.1.1.1 2>/dev/null)
    else
        dns_ptr=$(dig +short -x $dns_ip @1.1.1.1 2>/dev/null)
    fi
    echo -e "\033[1;36mYour Public IP is: \033[0m\n    \033[1;35m$dns_ip (over DNS udp/53) PTR: $dns_ptr\n    $http_ip (over HTTPS tcp/443) $(if [[ -n $ips_same="true" ]]; then echo PTR: $dns_ptr; else echo PTR: $http_ptr; fi)\033[0m\n"
    command -v traceroute >/dev/null 2>&1 && echo -e "\033[1;36mTraceroute:\033[1;35m\n$(traceroute -nd 8.8.8.8 2>/dev/null)"
}

omz-update-custom() {
  [ -d ~/.zsh-custom/.git ] && (cd ~/.zsh-custom && echo "Updating zsh-custom..." && git pull)
  for plugin in ~/.oh-my-zsh/custom/plugins/*/; do [ -d "$plugin/.git" ] && (cd "$plugin" && echo "Updating $(basename $plugin)..." && git pull); done
  [ -d ~/.local/dracula-zsh-theme/.git ] && (cd ~/.local/dracula-zsh-theme && echo "Updating Dracula theme..." && git pull)
}

# keep your local machine specific stuff here
[ -f ~/.local/.zshrc ] && source ~/.local/.zshrc

# direnv hook
type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"
