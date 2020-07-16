
#!/bin/bash

echo "install YAY Packages ...\n"
sudo chown -Rv zerocool:zerocool /opt
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rfv yay


yay -S pamac-aur-git
yay -S pamac-aur-tray-appindicator-git

sudo pacman --noconfirm -S zsh zsh-autosuggestions zsh-completions zshdb zsh-history-substring-search zsh-lovers python-pygments
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S zsh-theme-powerlevel10k-git awesome-terminal-fonts powerline-fonts ttf-meslo-nerd-font-powerlevel10k
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

yay -S google-chrome libpipewire02 kdialog libunity ttf-liberation

yay -S kdeconnect sshfs

sudo pacman --noconfirm -S conky conky-manager

yay -S timeshift cronie
sudo systemctl enable --now cronie.service

yay -S arch-audit clamav freshclam rkhunter unhide

yay -S pass qrencode dmenu pass-tomb pass-import pass-update pass-audit pass-otp browserpass-chrome browserpass-firefox browserpass


