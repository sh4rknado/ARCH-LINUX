
#!/bin/bash

pacman --noconfirm -Suy
pacman --noconfirm -S  rsync curl wget git reflector
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman --noconfirm -Syy


echo KEYMAP=be-latin1 >> /etc/vconsole.conf
echo FONT=lat9u-16 >> /etc/vconsole.conf

sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen
sed -i '/fr_BE.UTF-8/s/^#//g' /etc/locale.gen
sed -i '/fr_BE ISO-8859-1/s/^#//g' /etc/locale.gen
sed -i '/fr_BE@euro/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=fr_BE.UTF-8" >> /etc/locale.conf
echo "LC_COLLAPSE=C" >> /etc/locale.conf
export LANG=fr_BE.UTF-8
locale
localectl set-x11-keymap be  


pacman --noconfirm -S linux linux-firmware linux-headers  mkinitcpio-nfs-utils
pacman --noconfirm -S mkinitcpio-nfs-utils
pacman --noconfirm -S grub efibootmgr freetype2 fuse2 dosfstools efibootmgr libisoburn os-prober mtools 
pacman --noconfirm -S net-tools crda bluez dnsmasq ppp modemmanager dhclient dialog  wireless_tools wpa_supplicant
pacman --noconfirm -S firewalld iptables nm-connection-editor


ln -sfv /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc --utc

echo "BlackHunter" > /etc/hostname

pacman --noconfirm -S gst-plugins-base gst-plugins-bad gst-plugins-good gst-plugins-ugly gst-libav pulseaudio pulseaudio-alsa pavucontrol alsa-utils
pacman --noconfirm -S xorg-server xorg-xinit xorg-xmessage xorg-apps xf86-input-synaptics xf86-input-libinput xdg-user-dirs
pacman --noconfirm -S xf86-input-synaptics
pacman --noconfirm -S xf86-video-vesa
pacman --noconfirm -S cups hplip python-pyqt5 foomatic-db foomatic-db-ppds foomatic-db-gutenprint-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint system-config-printer cups-pk-helper python-pysmbc      
pacman --noconfirm -S lightdm lightdm-gtk-greeter
pacman --noconfirm -S plasma plasma-meta plasma-desktop konsole firefox
pacman --noconfirm -S dolphin python-dnspython qt5-imageformats kimageformats libappimage icoutils ffmpegthumbs kdegraphics-thumbnailers samba kdenetwork-filesharing gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-google gvfs-goa nautilus-sendto
pacman --noconfirm -S base-devel nano git wget curl arch-install-scripts python-pip python-setuptools
pacman --noconfirm -S nvidia nvidia-settings xorg-server-devel opencl-nvidia opencl-headers


systemctl enable firewalld
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable lightdm.service
