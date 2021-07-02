# https://github.com/blinks zsh theme
# modificato da me, molto cool

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}± %{%f%k%b%}"
  else
    echo ''
  fi
}

# Se il nome della current direcctory è troppo lungo rispetto al terminale, printa usa solo l'ultima parte del percorso
function _directory() {
  if [ ${#PWD} -gt $(($(tput cols)-24)) ]; then
    echo "../%2~"
  else
    echo "%~"
  fi
}


# This theme works with both the "dark" and "light" variants of the
# Solarized color scheme.  Set the SOLARIZED_THEME variable to one of
# these two values to choose.  If you don't specify, we'll assume you're
# using the "dark" variant.

case ${SOLARIZED_THEME:-dark} in
    light) bkg=white;;
    *)     bkg=black;;
esac

ZSH_THEME_GIT_PROMPT_PREFIX=" %B%F{white}%}[%{%B%F{cyan}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%B%F{white}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# This puts a blank line before every prompt except the first one
precmd() {
  precmd() {
    echo
  }
}

PROMPT='%{%f%k%b%}%{%B%F{white}%}[%B%F{yellow}%}%n%{%B%F{white}%}@%{%B%F{blue}%}%m%{%B%F{white}%}]%{%b%F{green}%} $(_directory)$(git_prompt_info)%E%{%f%k%b%}
$(_prompt_char)%{%B%F{white}%}::%(?.%{%B%F{red}%}❯.%{%B%F{magenta}%}❯)%{%f%k%b%}'

RPROMPT='%(?..%{%b%F{green}%}%?⏎)%{%b%F{magenta}%}[%*]%{%f%k%b%}'

# ↠ ↣ ↦ ↪ ⇝ ❯
