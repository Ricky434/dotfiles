export BROWSER=/usr/bin/firefox
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME="qt5ct"
export MAKEFLAGS="-j$(nproc)"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export PATH="$HOME/.local/bin:$XDG_DATA_HOME/cargo/bin:$XDG_DATA_HOME/go/bin/:$PATH"

# Set XDG compliant locations for various programs
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
#export STACK_ROOT="$XDG_DATA_HOME"/stack
export GHCUP_USE_XDG_DIRS=true

# aggiunge gli eseguibili di rbenv al path per poter usare varie versioni di ruby
#export PATH="$PATH:$RBENV_ROOT/bin"
#eval "$(rbenv init -)"

# aggiunge gli eseguibili delle gems di ruby al path
#export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
#export PATH="$PATH:$GEM_HOME/bin"
#export GTK_THEME=Adwaita:dark
