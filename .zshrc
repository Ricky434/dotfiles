#   __       _ _       
#   \ \  ___| | |_   _ 
#    \ \/ _ \ | | | | |
# /\_/ /  __/ | | |_| |
# \___/ \___|_|_|\__, |
#                |___/ 
#
#Zshrc made by me :)

#key-bindings.zsh, completion.zsh, history.zsh e theme-and-appearance.zsh rubati da oh-my-zsh, prima o poi devo studiarmeli bene e modificarli a mio piacimento

# ======= TTY COLORSCHEME
#
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P01e222a" #black
    echo -en "\e]P8545862" #darkgrey
    echo -en "\e]P1e06c75" #darkred
    echo -en "\e]P9e06c75" #red
    echo -en "\e]P298c379" #darkgreen
    echo -en "\e]PA98c379" #green
    echo -en "\e]P3e5c07b" #brown
    echo -en "\e]PBe5c07b" #yellow
    echo -en "\e]P461afef" #darkblue
    echo -en "\e]PC61afef" #blue
    echo -en "\e]P5c678dd" #darkmagenta
    echo -en "\e]PDc678dd" #magenta
    echo -en "\e]P656b6c2" #darkcyan
    echo -en "\e]PE56b6c2" #cyan
    echo -en "\e]P7abb2bf" #lightgrey
    echo -en "\e]PFc8ccd4" #white
    clear #for background artifacting
fi

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
alias la='eza -lahg'
#alias find='fd'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias cal='cal -m'
alias http='noglob http' # avoids zsh globbing, so you can use [ and ] without needing to escape them

# ======= OTHER ZSH OPTIONS
#
setopt autopushd #serve per popd (tipo cd - ma meglio)
setopt completeinword
setopt interactivecomments #serve per poter mettere i commenti nei comandi
setopt longlistjobs
setopt histignorespace

# ======= SYNTAX HIGHLIGHTING
#
#Zsh-syntax-highlighting tweaks aggiunti da me
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white'

# ======= STARSHIP PROMPT
#
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
if [ "$TERM" = "linux" ]; then
  export STARSHIP_CONFIG=~/.config/starship/starship-tty.toml
fi
# export RPS1="(%*)"

# ======= HOOK FUNCTIONS
#
# This puts a blank line before every prompt except the first one and sets the window title as the current directory
# precmd is executed before each prompt
precmd() {
  print -Pn "\e]0;%~\a"
  precmd() {
    print -Pn "\e]0;%~\a"
# print -Pn "\e]0;%~ $(pgrep -l -P $$ | awk '{print $2}')\a" # prints background jobs
    echo
  }
}

# This sets the window title as the command that is about to be executed
# preexec is executed just after a command has been read and is about to be executed
preexec() {
  print -PN "\e]0;$1\a"
}

# This way each time a command is executed the window title is set as that command, and when the command ends (the next prompt is drawn) the window title is set as the current directory
#
# =======

# ======= USEFUL FUNCTIONS
#
source ~/.config/zsh_stuff/useful-functions.zsh

# ======= ART
#
#fortune -s | cowsay
source ~/.config/zsh_stuff/ascii_art

# ======= TODOS
#
source ~/.config/zsh_stuff/todo
#bat /mnt/duck/Linux_Stuff/fare.txt

# ======= KEYCHAIN
#
# Automatically add ssh keys to ssh-agent (asks for passwords)
#eval $(keychain --eval gitlabSapienzaApps --timeout 3600)
