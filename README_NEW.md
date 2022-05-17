
# prerequisite Archlinux

## Create a Bootable UEFI USB

On the assumption that :

-   *X* is the volume ID.
-   *Y* is the partition ID.

## Make a FAT32 partition with boot flag

    sudo fdisk /dev/sdX

## Formatting the USB Flash Drive

    sudo mkfs.fat -F32 /dev/sdXY

## Labeling the USB Flash Drive

    sudo mlabel -i /dev/sdXY ::LABEL

## Flash Arch Linux on the USB Flash Drive

Replace "archlinux" by the name of your ISO image of Arch Linux:

    sudo dd bs=4M if=archlinux.iso of=/dev/sdX status=progress && sync

-   bs (block size): on modern equipment (less than 5 years old), 4MB is a good bet.
-   if: source of the ISO image of Arch Linux.
-   of: destination to install the ISO image of Arch Linux.
-   status: automatically print periodic updates in the standard output.


## Start on USB key

To do that, checks the following things:

-   USB Flash Drive is first on the priority of boot.
-   Secure Boot is disabled.


# Installation of Arch Linux

When you launch the Arch Linux installation menu, select:

-   Boot Arch Linux (x86_64): for 64-bit systems.
-   Boot Arch Linux (i686): for 32-bit systems.

Now that we have the console allowing us to execute commands, it's time to
move on to serious things.

## Temporarily change the keyboard layout

By default, the keyboard is on *QWERTY* and it can be hurt to the regulars of
*AZERTY*.

### List available keyboard layout

    ls /usr/share/kbd/keymaps/**/*.map.gz

### Load the layout

In this example, I put *be-latin1* as I'm using a belgian keyboard layout.
Feel free to change it by a keyboard layout from the list above.

    loadkeys be-latin1

<a id="orgc73eb0a"></a>

## Internet connection

Choose one of the two steps depending on your internet configuration.

### Wi-Fi

Disable the dhcpd service:

    systemctl stop dhcpd.service

Use wifi-menu

    wifi-menu

### Ethernet

Enable the dhcpd service (if you have disabled it):

    systemctl start dhcpd.service

## Few verifications

Before you start anything, check the following things:

### Check if efivars was loaded

If the efivars existe, that means that you booted into UEFI mode:

    ls /sys/firmware/efi/efivars
    sudo efivar -l


### Internet access

To verify that your system has an Internet connexion you can make a ping to
Google:

    ping -c 3 www.google.com


### TROUBLESHOOUT UEFI

If you have an Error message like "EFI variables are not supported on this system"

- you have booted into BIOS mode

      => reboot your laptop
      => select UEFI ArchLinux from bootorder
      => recheck efivars

- You have activate the BIOS/CMOS comptability

      => Select UEFI only into the BIOS/EFI

Notes : if you have an windows installed don't touch BIOS/CMOS comptability, your windows installation will be broken you need to format (GPT) and reinstall windows

---
---

# Installing ARCHLINUX

## Show Current Partitions

    [zerocool@BlackHunter ~]$ sudo fdisk -l

    Disque /dev/nvme0n1 : 931,53 GiB, 1000204886016 octets, 1953525168 secteurs
    Modèle de disque : Samsung SSD 970 EVO Plus 1TB            
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 512 octets
    taille d'E/S (minimale / optimale) : 512 octets / 512 octets
    Type d'étiquette de disque : gpt
    Identifiant de disque : 42BD087D-24D2-4171-B96A-9B35801D0EDD

    Périphérique     Début        Fin   Secteurs Taille Type
    /dev/nvme0n1p1    2048    1955839    1953792   954M Système EFI
    /dev/nvme0n1p2 1955840 1953525134 1951569295 930,6G LVM Linux

    Disque /dev/sda : 931,53 GiB, 1000204886016 octets, 1953525168 secteurs
    Modèle de disque : WDC WD10SPCX-24H
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 4096 octets
    taille d'E/S (minimale / optimale) : 4096 octets / 4096 octets
    Type d'étiquette de disque : gpt
    Identifiant de disque : 9F6EB385-0855-3D5E-720A-8A6243152D71

    Périphérique     Début        Fin   Secteurs Taille Type
    /dev/sda1         2048  209717247  209715200   100G Données de base Microsoft
    /dev/sda2    209717248  419432447  209715200   100G Données de base Microsoft
    /dev/sda3    419432448  452986879   33554432    16G Partition d'échange Linux
    /dev/sda4    452986880 1953523711 1500536832 715,5G Données de base Microsoft


---

## Create the Partition

### Paritionning SSD

    [zerocool@BlackHunter ~]$ sudo cfdisk /dev/nvme0n1

    Disque : /dev/nvme0n1
    Taille : 931,53 GiB, 1000204886016 octets, 1953525168 secteurs
    Étiquette : gpt, identifiant : 42BD087D-24D2-4171-B96A-9B35801D0EDD

    Périphérique         Début          Fin     Secteurs  Taille Type
    >>  /dev/nvme0n1p1        2048      1955839      1953792    954M Système EFI
    /dev/nvme0n1p2     1955840   1953525134   1951569295  930,6G LVM Linux


    ┌─────────────────────────────────────────────────────────────────────────┐
    │       UUID de la partition : BF308FB9-A197-B64C-90F5-6969478BA2E5       │
    │       Type de la partition : Système EFI (C12A7328-F81F-11D2-BA4B-00A0C9│
    │UUID du système de fichiers : 4DD0-2837                                  │
    │        Système de fichiers : vfat                                       │
    │           Point de montage : /boot/EFI (démonté)                        │
    └─────────────────────────────────────────────────────────────────────────┘
    [   Supprimer  ]  [Redimensionner]  [    Quitter   ]  [     Type     ]
    [     Aide     ]  [    Écrire    ]  [  Sauvegarder ]

    Quitter le programme sans écrire les modifications


  Notes: the table of partition could be gpt and I have 2 paritions

    - Système EFI
    - LVM Partition


### RAID (options)

    yes | mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1
    yes | mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdc1 /dev/sdd1
    yes | mdadm --create /dev/md3 --level=0 --raid-devices=2 /dev/md0  /dev/md1


---

### Create the PV (Physical Volume)

    [zerocool@BlackHunter ~]$ pv create /dev/nvme0n1p2
    [zerocool@BlackHunter ~]$ sudo pvdisplay

    --- Physical volume ---
    PV Name               /dev/nvme0n1p2
    VG Name               SSD
    PV Size               930,58 GiB / not usable 2,69 MiB
    Allocatable           yes
    PE Size               4,00 MiB
    Total PE              238228
    Free PE               148628
    Allocated PE          89600
    PV UUID               Osqh1D-753S-yXQm-O1BZ-qVQv-TAic-zIxLat


### Create the VG (Volume Group)

    [zerocool@BlackHunter ~]$ sudo vgcreate /dev/nvme0n1p2 SSD

    [zerocool@BlackHunter ~]$ sudo vgdisplay

      --- Volume group ---
      VG Name               SSD
      System ID             
      Format                lvm2
      Metadata Areas        1
      Metadata Sequence No  3
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                2
      Open LV               2
      Max PV                0
      Cur PV                1
      Act PV                1
      VG Size               <930,58 GiB
      PE Size               4,00 MiB
      Total PE              238228
      Alloc PE / Size       89600 / 350,00 GiB
      Free  PE / Size       148628 / <580,58 GiB
      VG UUID               NJBx1u-G693-uDKV-HGC4-ASW3-U0r0-4W28fN



### Create the LV (Logical Volume)

    [zerocool@BlackHunter ~]$ sudo lvcreate -L 250GB --name lv_root raid10 #/home
    [zerocool@BlackHunter ~]$ sudo lvcreate -L 100GB --name lv_home raid10 #/home

    [zerocool@BlackHunter ~]$ sudo lvdisplay

      --- Logical volume ---
      LV Path                /dev/SSD/lv_home
      LV Name                lv_home
      VG Name                SSD
      LV UUID                PFmvvF-NA4M-WD39-tC0Y-N23z-4eRm-i6ob8y
      LV Write Access        read/write
      LV Creation host, time archiso, 2020-07-02 15:46:13 +0200
      LV Status              available
      # open                 1
      LV Size                100,00 GiB
      Current LE             25600
      Segments               1
      Allocation             inherit
      Read ahead sectors     auto
      - currently set to     256
      Block device           254:0

      --- Logical volume ---
      LV Path                /dev/SSD/lv_root
      LV Name                lv_root
      VG Name                SSD
      LV UUID                ekvri1-LGo0-zdb7-izgc-WOFV-LH4b-l0tXdf
      LV Write Access        read/write
      LV Creation host, time archiso, 2020-07-02 15:46:20 +0200
      LV Status              available
      # open                 1
      LV Size                250,00 GiB
      Current LE             64000
      Segments               1
      Allocation             inherit
      Read ahead sectors     auto
      - currently set to     256
      Block device           254:1

---

## Show devices paritions path

    [root@BlackHunter zerocool]# sudo fdisk -l

    Disque /dev/nvme0n1 : 931,53 GiB, 1000204886016 octets, 1953525168 secteurs
    Modèle de disque : Samsung SSD 970 EVO Plus 1TB            
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 512 octets
    taille d'E/S (minimale / optimale) : 512 octets / 512 octets
    Type d'étiquette de disque : gpt
    Identifiant de disque : 42BD087D-24D2-4171-B96A-9B35801D0EDD

    Périphérique     Début        Fin   Secteurs Taille Type
    /dev/nvme0n1p1    2048    1955839    1953792   954M Système EFI
    /dev/nvme0n1p2 1955840 1953525134 1951569295 930,6G LVM Linux

    Disque /dev/sda : 931,53 GiB, 1000204886016 octets, 1953525168 secteurs
    Modèle de disque : WDC WD10SPCX-24H
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 4096 octets
    taille d'E/S (minimale / optimale) : 4096 octets / 4096 octets
    Type d'étiquette de disque : gpt
    Identifiant de disque : 9F6EB385-0855-3D5E-720A-8A6243152D71

    Périphérique     Début        Fin   Secteurs Taille Type
    /dev/sda1         2048  209717247  209715200   100G Données de base Microsoft
    /dev/sda2    209717248  419432447  209715200   100G Données de base Microsoft
    /dev/sda3    419432448  452986879   33554432    16G Partition d'échange Linux
    /dev/sda4    452986880 1953523711 1500536832 715,5G Données de base Microsoft

    Disque /dev/mapper/SSD-lv_home : 100 GiB, 107374182400 octets, 209715200 secteurs
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 512 octets
    taille d'E/S (minimale / optimale) : 512 octets / 512 octets

    Disque /dev/mapper/SSD-lv_root : 250 GiB, 268435456000 octets, 524288000 secteurs
    Unités : secteur de 1 × 512 = 512 octets
    Taille de secteur (logique / physique) : 512 octets / 512 octets
    taille d'E/S (minimale / optimale) : 512 octets / 512 octets


## Formatting the Parition

    [root@BlackHunter zerocool]# mkfs.vfat /dev/nvme0n1p1
    [root@BlackHunter zerocool]# mkfs.ext4 /dev/mapper/SSD-lv_root
    [root@BlackHunter zerocool]# mkfs.ext4 /dev/mapper/SSD-lv_home

---

## Mount the Partition

     mount -v /dev/mapper/SSD-lv_root /mnt
     mkdir -pv /mnt/{home,grub,boot/EFI}
     mount -v /dev/mapper/nvme0n1p1 /mnt/boot/EFI
     mount -v /dev/mapper/SSD-lv_home /mnt/home

---

## Linux Install Base

### Installing Root Package

    [root@BlackHunter zerocool]# pacstrap /mnt base

### Resolve LVM (grub timeout)

    [root@BlackHunter zerocool]# mkdir -pv /mnt/hostlvm
    [root@BlackHunter zerocool]# mount --bind /run/lvm /mnt/hostlvm

### Generate FSTAB

    [root@BlackHunter zerocool]# genfstab -U -p /mnt >> /mnt/etc/fstab

### Enter into chroot

    [root@BlackHunter zerocool]# arch-chroot /mnt
    [root@BlackHunter zerocool]# ln -sv hostlvm /run/hostlvm

---

### pacman configure

uncomment the following lines in this file

    nano /etc/pacman.conf


#### Misc options
-  UseSyslog
-  Color
-  TotalDownload
-  CheckSpace
-  VerbosePkgLists

#### multilib repository

-  [multilib]
-  Include = /etc/pacman.d/mirrorlist



### Update the mirrorlist

    yes 'n' | pacman -Suy
    yes 'y' | pacman -S  rsync curl wget git reflector
    reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    yes 'n' | pacman -Syy

### Configure the input keyboard

    echo KEYMAP=be-latin1 >> /etc/vconsole.conf
    echo FONT=lat9u-16 >> /etc/vconsole.conf

### Configure the system Language

    cp -avr /etc/locale.gen /etc/locale.gen.bak
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

### Installing cores Packages

    # Installing the Kernel
    pacman -S linux linux-firmware linux-headers

    # NFS SUPPORT
    pacman -S mkinitcpio-nfs-utils

    # Installing grub - EFI
    pacman -S grub efibootmgr freetype2 fuse2 dosfstools efibootmgr libisoburn os-prober mtools

    # Installing Network Tools
    pacman -S net-tools crda bluez dnsmasq ppp modemmanager dhclient dialog  wireless_tools wpa_supplicant

    # Installing Security
    pacman -S firewalld iptables nm-connection-editor
    sudo systemctl enable firewalld

    # Install GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
    grub-install --target=x86_64-efi --efi-dir=/boot/EFI --bootloader-id=ArchLinux --recheck


### Configure Core Packages

    # Enable Network Manager
    sudo systemctl enable NetworkManager
    sudo systemctl enable bluetooth

    # Configure the clock
    ln -sfv /usr/share/zoneinfo/Europe/Brussels /etc/localtime
    hwclock --systohc --utc

    # Configure the Hostname
    echo "BlackHunter" > /etc/hostname

    # Set the Password
    passwd

    # New user
    useradd -m -s /bin/bash someone
    passwd someone

    # Set the sudo permission
    echo 'zerocool ALL=(ALL) ALL' >> /etc/sudoers


---

## Install Stable Environements

    # Install Audio Packages
    pacman -S gst-plugins-base gst-plugins-bad gst-plugins-good gst-plugins-ugly gst-libav pulseaudio pulseaudio-alsa pavucontrol alsa-utils

    # Install Server X Windows (xorg)
    sudo pacman -S xorg-server xorg-xinit xorg-xmessage xorg-apps xf86-input-synaptics xf86-input-libinput xdg-user-dirs

    # Install touchpad (synaptics)
    pacman -S xf86-input-synaptics

    # Install package devel
    pacman -S xf86-video-vesa

    # Install printer drivers
    pacman -S cups hplip python-pyqt5 foomatic-db foomatic-db-ppds foomatic-db-gutenprint-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint system-config-printer cups-pk-helper python-pysmbc      

    # Install the Display Manager
    sudo pacman -S lightdm lightdm-gtk-greeter

    # Enable the Display Manager
    systemctl enable lightdm.service

    # Install KDE PLASMA
    pacman -S plasma plasma-meta plasma-desktop konsole firefox dolphin

    # File Browser
    pacman -S dolphin python-dnspython qt5-imageformats kimageformats libappimage icoutils ffmpegthumbs kdegraphics-thumbnailers samba kdenetwork-filesharing gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-google gvfs-goa nautilus-sendto

    # Install package devel
    pacman -S base-devel nano git wget curl arch-install-scripts python-pip python-setuptools

    # Install Nvidia Driver (GTX 960M and latest)
    pacman -S nvidia nvidia-settings xorg-server-devel opencl-nvidia opencl-headers

    # Reboot
    reboot

---

## Install somes packages


### Install AUR HELPER (yay)

    # Install yay
    ➜  ~  git clone https://aur.archlinux.org/yay.git
    ➜  ~  cd yay
    ➜  ~  makepkg -si

### Install AUR HELPER GUI (pamac)

    # Install pamac
    ➜  ~  yay -S pamac-aur-git

    # Install pamac indicator
    ➜  ~  yay -S pamac-aur-tray-appindicator-git


### Customize terminal

    # Install zsh
    ➜  ~  sudo pacman -S zsh zsh-autosuggestions zsh-completions zshdb zsh-history-substring-search zsh-lovers python-pygments

    # Install ohmyzsh
    ➜  ~  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Install zsh theme
    ➜  ~  yay -S zsh-theme-powerlevel10k-git awesome-terminal-fonts powerline-fonts ttf-meslo-nerd-font-powerlevel10k
    ➜  ~ echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

Notes: Restart the terminal and configure it now

### Web Browser Google Chrome

    ➜  ~  yay -S google-chrome libpipewire02 kdialog libunity ttf-liberation

### Android integration

    # install kdeconnect
    ➜  ~  yay -S kdeconnect sshfs python-nautilus

### Monitoring conky

    # install kdeconnect
    ➜  ~  sudo pacman -S conky conky-manager

### Backup tools

    # install
    ➜  ~  yay -S timeshift cronie
    ➜  ~ sudo systemctl enable --now cronie.service

### Sécurity Tools

    # Vulnerability Audit
    ➜  ~ yay -S arch-audit

    # Anti-Virus
    ➜  ~ yay -S clamav

    # update the AV db
    ➜  ~ sudo freshclam  

    # Rootkit Hunter
    ➜  ~  yay -S rkhunter unhide


### Password Management

    # Password Manager
    ➜  ~  yay -S pass qrencode dmenu pass-tomb pass-import pass-update pass-audit pass-otp browserpass-chrome browserpass-firefox browserpass

    # Password Manager
    ➜  ~ gpg --full-generate-key
