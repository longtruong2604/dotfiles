# Zinit 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
# zinit light sindresorhus/pure


# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
PATH=${HOME}/.npm-packages/bin:$PATH

## auto use nvm when there is a file .nvmrc
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Plugins
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::globalias
zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
zinit snippet https://raw.githubusercontent.com/QuarticCat/zsh-smartcache/main/zsh-smartcache.plugin.zsh
# zinit load agkozak/zsh-z

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# PATHS
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH"

# History
export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP='erase'
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias g="git"
alias v="vim"
alias cc="clear"
alias np="npm"
alias ff="fzf"
alias pm="pnpm"
alias tf="terraform"
alias yr="yarn"
alias yw="yarn workspace"
alias bat="batcat"
alias find="fdfind"
alias ls="eza --color=always --group-directories-first --icons" # preferred listing
alias la="eza -a --color=always --group-directories-first --icons" # all files and dirs
alias ll="eza -l --color=always --group-directories-first --icons" # long format
alias lt="eza -aT --color=always --group-directories-first --icons" # tree listing
alias l.="eza -a | grep -E '^\.'" # dotfiles
alias gita="git config -l | grep alias | sed 's/^alias\.//g'"

# Shell intergrations
smartcache eval zoxide init --cmd cd zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

LS_COLORS=(vivid generate dracula)

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --group-directories-first --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_cd:*' fzf-preview 'eza -1 --color=always --group-directories-first --icons $realpath'
zstyle :prompt:pure:git:stash show yes

GLOBALIAS_FILTER_VALUES=(z ls)

function .. { cd '..'; }
function ... { cd '../..'; }
function .... { cd '../../..'; }

ZSH_AUTOSUGGEST_STRATEGY=(history completion)


export FZF_DEFAULT_COMMAND='fdfind --type file --color=always'
export FZF_CTRL_T_COMMAND=FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 50% --min-height=30 --layout=reverse
    --bind="ctrl-y:execute-silent(printf {} | cut -f 2- | pbcopy)" 
    --bind=ctrl-u:preview-half-page-up 
    --bind=ctrl-d:preview-half-page-down
    --bind="ctrl-o:execute-silent(code {-1})"
'

export BAT_THEME=ansi



