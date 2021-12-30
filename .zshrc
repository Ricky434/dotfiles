#   __       _ _       
#   \ \  ___| | |_   _ 
#    \ \/ _ \ | | | | |
# /\_/ /  __/ | | |_| |
# \___/ \___|_|_|\__, |
#                |___/ 
#
#Zshrc made by me :)

#key-bindings.zsh, completion.zsh, history.zsh e theme-and-appearance.zsh rubati da oh-my-zsh, prima o poi devo studiarmeli bene e modificarli a mio piacimento

# ======= KEYBINDINGS
#
source ~/.config/zsh_stuff/key-bindings.zsh

# ======= COMPLETION
#
autoload -U compinit; compinit
#_comp_options+=(globdots) #mostra anche i file nascosti nelle completion
source ~/.config/zsh_stuff/completion.zsh #probabilmente non serve

# ======= HISTORY
#
source ~/.config/zsh_stuff/history.zsh

# ======= ALTRO
#
source ~/.config/zsh_stuff/theme-and-appearance.zsh #non so bene cosa fa, so solo che cambia i colori di ls

# ======= PLUGINS
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ======= ALIASES
#
alias ls='ls --color=auto'
alias la='exa -lahg'
#alias find='fd'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias cal='cal -m'

# ======= ZSH OPTIONS
#
setopt autopushd #serve per popd (tipo cd - ma meglio)
setopt completeinword
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histverify #serve per poter modificare i comandi chiamati con !! (comando precedente) e simili prima di eseguirli
setopt interactivecomments #serve per poter mettere i commenti nei comandi
setopt longlistjobs
setopt pushdignoredups
setopt sharehistory

# ======= SYNTAX HIGHLIGHTING
#Zsh-syntax-highlighting tweaks aggiunti da me
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white'

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
# =======

# ======= ART
#
#bat /mnt/duck/Linux_Stuff/fare.txt
#fortune -s | cowsay
source ~/.config/zsh_stuff/ascii_art


