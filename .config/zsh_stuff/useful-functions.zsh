#==== Swap two files ====#
swp() {
  # Help
  if [ "$#" -ne 2 ]; then
    me=`basename $0`
    echo "Syntax: $me <FILE 1> <FILE 2>"
    return 1
  fi

  # Check if files exist
  if [ ! -e "$1" ]; then
    echo "File '$1' does not exist!"
    return 1
  fi
  if [ ! -e "$2" ]; then
    echo "File '$2' does not exist!"
    return 1
  fi
  if [ "$1" = "$2" ]; then
    echo "Files '$1' and '$2' are the same file"
    return 1
  fi
  
  # Actual function
  local TMPFILE=tmp.$$
  mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

#==== Pretty print Tmux sessions ====#
tmuxLs() {
  NC='\x1b[0m'
  BBLUE='\x1b[1;34m'
  BYELLOW='\x1b[1;33m'
  DOT=" ${BBLUE}*${NC}"

  echo -n Tmux sessions:
  if pgrep tmux > /dev/null 2> /dev/null; then
    echo
    sessions=$(tmux ls -F"#{session_name} [#{t:session_created}] #{?session_attached,(attached),} #{?session_grouped,(group ,}#{session_group}#{?session_grouped,),}")
    # It is important that the name of the session is separated from the square bracket by a space so that sed can look for it without interfering with the color codes
    sed -e "s/^/  $DOT $BYELLOW/" -e "s/ \[/$NC&/" <<<"$sessions"
  else
    echo " none"
  fi
  echo
}

#==== Open neovim in a dir and change to that dir
function nvimd() {
  if [ $# -ne 1 ]; then
    echo "Usa nvim"
  elif [ -d "$1" ]; then
    cd "$1"
    nvim .
  else
    nvim "$1"
  fi
}
