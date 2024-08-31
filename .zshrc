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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
PATH=${HOME}/.npm-packages/bin:$PATH

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
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -A"
alias l.="ls -d .*"
alias gita="git config -l | grep alias | sed 's/^alias\.//g'"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle :prompt:pure:git:stash show yes

# Shell intergrations
smartcache eval zoxide init --cmd cd zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

GLOBALIAS_FILTER_VALUES=(z ls)

function .. { cd '..'; }
function ... { cd '../..'; }
function .... { cd '../../..'; }

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export FZF_DEFAULT_OPTS='--height 50% --min-height=30 --layout=reverse
    --bind="ctrl-y:execute-silent(printf {} | cut -f 2- | pbcopy)" 
    --bind=ctrl-u:preview-half-page-up 
    --bind=ctrl-d:preview-half-page-down
    --bind="ctrl-o:execute-silent(code {-1})"
'


