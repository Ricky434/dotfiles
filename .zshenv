export BROWSER=/usr/bin/firefox
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME="KDE"
export MAKEFLAGS="-j$(nproc)"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export PATH="$HOME/.local/bin:$PATH"

# aggiunge gli eseguibili delle gems di ruby al path
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# aggiunge gli eseguibili di rbenv al path per poter usare varie versioni di ruby
export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"


# Set xdg compliant locations for various programs
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
# ruby bundler
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
#
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph
export STACK_ROOT="$XDG_DATA_HOME"/stack
