HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histverify #serve per poter modificare i comandi chiamati con !! (comando precedente) e simili prima di eseguirli
setopt pushdignoredups
setopt sharehistory
