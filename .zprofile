# ======= PATH
#
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
export PATH="$XDG_DATA_HOME/go/bin/:$PATH"
# This is for flutter-firebase
export PATH="$HOME/.pub-cache/bin:$PATH"

# ======= DEFAULT APPS
#
export BROWSER=/usr/bin/firefox
export EDITOR=nvim

# ======= XDG, LOCATIONS
#
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

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
#
# =======

# ======= OTHER
export QT_QPA_PLATFORMTHEME="qt5ct"
export MAKEFLAGS="-j$(nproc)"

# ======= Start Hyprland if it's not already running
#
if [[ -z $(pgrep Hyprland) ]]; then
    Hyprland
fi
