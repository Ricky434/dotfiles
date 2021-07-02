# ======= KEYBINDINGS
#
source ~/.config/zsh_stuff/key-bindings.zsh

# ======= COMPLETION
#
autoload -U compinit; compinit
_comp_options+=(globdots) #mostra anche i file nascosti nelle completion
source ~/.config/zsh_stuff/completion.zsh

# ======= HISTORY
#
source ~/.config/zsh_stuff/history.zsh

# ======= PLUGINS
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ======= ALIASES
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='ls --color=auto'
alias la='exa -lahg'
alias find='fd'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# ======= ZSH OPTIONS
#
setopt autopushd #serve per popd (tipo cd - ma meglio)
setopt completeinword
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histverify #serve per quando usi !!
setopt interactivecomments
setopt longlistjobs
setopt pushdignoredups
setopt sharehistory

# ======= SYNTAX HIGHLIGHTING
#Zsh-syntax-highlighting tweaks aggiunti da me
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white'

# ------
# ======= STARSHIP PROMPT
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
# export RPS1="(%*)"
# This puts a blank line before every prompt except the first one
precmd() {
  precmd() {
    echo
  }
}
# ------

#bat /mnt/duck/Linux_Stuff/fare.txt
#fortune -s | cowsay

