HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000 # internal history
SAVEHIST=40000 # history file

setopt extendedhistory # save command timestamp and duration in history
setopt histexpiredupsfirst # when internal history fills up, remove oldest duplicate command from history
setopt histignoredups # don't add command if it is duplicate of previous one
#setopt histignorealldups # If command duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt histverify #serve per poter modificare i comandi chiamati con !! (comando precedente) e simili prima di eseguirli
setopt pushdignoredups # ignore duplicates for pushd
setopt sharehistory # share history between instances
setopt histignorespace # don't save commands that start with space
