

# GPG KeyServer (Error)

Fix GPG Server Import Key

    # Reset the pacman key
    sudo rm -rfv  /etc/pacman.d/gnupg/
    sudo pacman-key --init

    # Reinstall the Key
    sudo pacman -Sy archlinux-keyring
    sudo pacman-key --populate archlinux
    sudo pacman-key --refresh-keys

    # Set the New Server Key
    sudo nano /etc/pacman.d/gnupg/gpg.conf

    # Set the correct Server
    keyserver hkp://keys.gnupg.net:80

    # Refresh the Key
    sudo pacman-key --refresh-keys


# GPG NO_PUBKEY

      # Import the GPG KEY
      sudo gpg --keyserver hkp://keyserver.ubuntu.com --recv-key  $1
      sudo gpg -a --export $1 | sudo apt-key add -

## Update the repository

      # debian updates
      sudo apt-get update

      # debian updates
      sudo pacman -Syy
