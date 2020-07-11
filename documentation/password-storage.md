# Password Manager (pass)

Notes: this guide will be use pass on KDE
for store the manage the password

## Requirements

- yay (aur helper)
- git


## Install kwallet

      sudo pacman -S kwallet ksshaskpass kwalletmanager kwallet-pam signon-kwallet-extension
      sudo pacman -S pass qrencode pinentry ibsecret cracklib gnupg gpgme gnupass


## Install pass plugins

      yay -S pass-tomb pass-import pass-update pass-audit pass-otp
      yay -S browserpass-chrome browserpass-firefox browserpass


## Initialize pass

      # Generate the key
      gpg --full-generate-key

      # Generate the key
      pass init 'KEY_ID'

      # Enable management of local changes through Git
      pass git init

      # Add the the remote git repository as 'origin'
      pass git remote add origin user@server:~/.password-store

      # Push your local pass history
      pass git push -u --all


## configure pass

  Configure the github post file

  nano ~/.password-store/.git/hooks/post-commit

      #!/bin/sh -x

      git push -u origin master

  set the permission

      chmod +x ~/.password-store/.git/hooks/post-commit

---

## TROUBLESHOOUT

### browserpass / plasma-pass ( unable to decrypt the password )

Cause may be that browserpass or plasma-pass need to entrer the passphrase for
the read the private key and decrypt the data.

Resolve :

configure the gpg agent for use pinentry with gui for this i use kwallet-cli for storage
the passphrase that will be use and decrypt auto

install pinentry gui with kwallet

      yay -S kwallet-cli


configure the gpg-agent for use pinentry - kwallet-cli

nano ~/.gnupg/gpg-agent.conf

      pinentry-program /usr/bin/pinentry-kwallet

      max-cache-ttl 60480000
      default-cache-ttl 60480000

      default-cache-ttl-ssh 60480000
      max-cache-ttl-ssh 60480000


nano ~/.gnupg/gpg.conf

      # GnuPG config file created by KGpg
      default-key  <KEY_ID>

      # Comment out or remove this line if it's there:
      # pinentry-mode loopback

      # and add this line:
      use-agent


reload gpg-agent

      gpg-connect-agent reloadagent /bye


---

## Bibliography

- https://github.com/browserpass/browserpass-legacy/issues/120
- https://github.com/browserpass/browserpass-native/#hints-for-configuring-gpg
- https://wiki.archlinux.org/index.php/GnuPG#pinentry
