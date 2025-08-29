# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# if on mac and running as root (sudo -s), disable compfix to avoid security warnings
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Only disable compfix when running as root
    if [[ $EUID -eq 0 ]] || [[ $USER == "root" ]]; then
        ZSH_DISABLE_COMPFIX="true"
    fi
fi

plugins=(
  fast-syntax-highlighting
  zsh-autosuggestions
  fzf
  fzf-tab
  git
  zsh-bat
)

if [[ "$OSTYPE" == "darwin"* ]]; then
  plugins+=(
      bundler
      sudo
      dotenv
      macos
      rake
      rbenv
      ruby
      brew
  )
fi

# Load additional plugins from .local
if [[ -f "$HOME/.local/.zshrc_plugins" ]]; then
    source "$HOME/.local/.zshrc_plugins"
fi

# zsh-completions plugin must be loaded like this and before sourcing oh-my-zsh.sh
if [[ -d "~/.oh-my-zsh/custom/plugins/zsh-completions/src" ]]; then
  FPATH="$FPATH:~/.oh-my-zsh/custom/plugins/zsh-completions/src"
  autoload -Uz compinit && compinit
fi

source $ZSH/oh-my-zsh.sh

# share history between terminals
setopt share_history

# show hostname (if ssh or root) and always show username
DRACULA_DISPLAY_CONTEXT=1

# Autosuggestions config
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_USE_ASYNC=1
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#bindkey '^ ' autosuggest-accept  # Ctrl+Space to accept suggestion

# Better completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh

# FZF-tab config
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Fix escape sequences and terminal issues
# export TERM=xterm-256color  # Commented out - can cause issues with some terminals

# Disable bracketed paste mode which can cause escape sequences
# unset zle_bracketed_paste  # Commented out - this can break paste functionality

# Fix stty settings
# if [[ -t 0 ]]; then
#   stty -echo -onlcr 2>/dev/null || true  # Commented out - disrupts terminal echo
# fi

# Disable terminal query sequences
# printf '\e[?2004l'  # Commented out - can interfere with modern terminals

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# Unset apt completions on macOS (fix for zsh-completions or fzf-tab)
if [[ "$OSTYPE" == "darwin"* ]]; then
    unfunction _apt 2>/dev/null
    unfunction _apt-get 2>/dev/null
    unfunction _dpkg 2>/dev/null
    complete -r apt 2>/dev/null
    complete -r apt-get 2>/dev/null
fi

# homebrew editor
if type brew &>/dev/null; then
    export HOMEBREW_EDITOR=nvim
fi

time-zsh() {
  time zsh -i -c exit
}

myip() {
    echo My IP: $(host myip.opendns.com resolver1.opendns.com | grep address | awk '{print $4}')
}

omz-update-custom() {
  # Update all custom plugins at once
  for plugin in ~/.oh-my-zsh/custom/plugins/*/; do
    [ -d "$plugin/.git" ] && (cd "$plugin" && echo "Updating $(basename $plugin)..." && git pull)
  done
  [ -d "$HOME/.local/dracula-zsh-theme/.git" ] && (cd "$HOME/.local/dracula-zsh-theme" && echo "Updating Dracula theme..." && git pull)
}

# keep your local machine specific stuff here
if [ -f ~/.local/.zshrc ]; then
  source ~/.local/.zshrc
fi

# direnv hook
if type direnv > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi
