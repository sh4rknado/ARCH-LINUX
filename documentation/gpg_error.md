

# GPG NO_PUBKEY

      # Import the GPG KEY
      sudo gpg --keyserver hkp://keyserver.ubuntu.com --recv-key  $1
      sudo gpg -a --export $1 | sudo apt-key add -

## Update the repository

      # debian updates
      sudo apt-get update

      # debian updates
      sudo pacman -Syy
