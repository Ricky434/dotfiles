# Function to swap two files
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
