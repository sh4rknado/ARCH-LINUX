# ARCH-LINUX
ARCHLINUX-CONFIGURATION

<div id="table-of-contents">
  <h2>Table of Contents</h2>
  <div id="text-table-of-contents">
    <ul>
      <li><a href="#org63fb083">1. About</a></li>
      <li><a href="#orgeb7cc6d">2. Create a Bootable UEFI USB</a>
        <ul>
          <li><a href="#org0fbb290">2.1. Make a FAT32 partition with boot flag</a></li>
          <li><a href="#orgc1918c7">2.2. Formatting the USB Flash Drive</a></li>
          <li><a href="#orgb007aa3">2.3. Labeling the USB Flash Drive</a></li>
          <li><a href="#orga50c0f6">2.4. Installation of Arch Linux on the USB Flash Drive</a></li>
          <li><a href="#org9ad32aa">2.5. Start on USB key</a></li>
        </ul>
      </li>
      <li><a href="#org42a0815">3. Installation of Arch Linux</a>
        <ul>
          <li><a href="#orgcecb97a">3.1. Temporarily change the keyboard layout</a>
          <ul>
            <li><a href="#orgca9915b">3.1.1. List available keyboard layout</a></li>
            <li><a href="#org7e52ac0">3.1.2. Load the layout</a></li>
          </ul>
        </li>
        <li><a href="#orgc73eb0a">3.2. Internet connection</a>
          <ul>
            <li><a href="#orgde312d6">3.2.1. Wi-Fi</a></li>
            <li><a href="#org4515c3d">3.2.2. Ethernet</a></li>
          </ul>
        </li>
        <li><a href="#orgbb4b217">3.3. Few verifications</a>
        <ul>
          <li><a href="#org309546d">3.3.1. Booted into UEFI mode</a></li>
          <li><a href="#org387abb2">3.3.2. Internet access</a></li>
        </ul>
      </li>
      <li><a href="#org7e85fba">3.4. Hard Disk Partitioning (UEFI)</a>
        <ul>
          <li><a href="#org4fc34c8">3.4.1. Display the Hard Disk memory</a></li>
          <li><a href="#orgbd981bd">3.4.2. Creation of the file system</a></li>
          <li><a href="#org7183160">3.4.3. Write the partitions table to the disk</a></li>
        </ul>
      </li>
      <li><a href="#org7bb380e">3.5. Build the file system</a>
        <ul>
          <li><a href="#org5ced472">3.5.1. EFI</a></li>
          <li><a href="#orgd9ee8e5">3.5.2. SWAP</a></li>
          <li><a href="#orga18a7ee">3.5.3. /</a></li>
          <li><a href="#orgbb80bff">3.5.4. /home</a></li>
        </ul>
      </li>
      <li><a href="#org6a32928">3.6. Disk mount</a>
        <ul>
          <li><a href="#orge4f5f1a">3.6.1. /</a></li>
          <li><a href="#org21399ba">3.6.2. /boot and /home</a></li>
        </ul>
      </li>
      <li><a href="#org3da06a5">3.7. Activate mirrors</a></li>
      <li><a href="#orgaa7e8eb">3.8. Installation of the system</a></li>
      <li><a href="#org67d5faa">3.9. Generate the fstab file</a></li>
      <li><a href="#org32f14fa">3.10. Chroot in the system</a></li>
      <li><a href="#org52bb743">3.11. Configurations of the system</a>
        <ul>
          <li><a href="#org2d358e9">3.11.1. Permanently adding a keyboard layout</a></li>
          <li><a href="#org595f533">3.11.2. Set languages for the system</a></li>
          <li><a href="#orgba583db">3.11.3. Set the hostname of the computer</a></li>
          <li><a href="#org360c0b8">3.11.4. Set the network to autostart</a></li>
          <li><a href="#org281f3b7">3.11.5. Set the time zone</a></li>
          <li><a href="#org52d0a22">3.11.6. Configure repository</a></li>
          <li><a href="#orga4b748b">3.11.7. Synchronisation and update of packages</a></li>
          <li><a href="#orgaec876c">3.11.8. Set a root password</a></li>
          <li><a href="#org9a3c75d">3.11.9. Set a new user with a password</a></li>
        </ul>
      </li>
      <li><a href="#org3528dc7">3.12. Install and configure boot loader</a>
      <ul>
        <li><a href="#org385832d">3.12.1. Generate the Kernel</a></li>
        <li><a href="#org57292f0">3.12.2. Installing GRUB</a></li>
      </ul>
      </li>
      <li><a href="#org33b511f">3.13. Before restart the system</a>
        <ul>
          <li><a href="#orgc5e8491">3.13.1. Exit the chroot mode</a></li>
          <li><a href="#org6e3b161">3.13.2. Unmount the partitions</a></li>
          <li><a href="#org7109cb0">3.13.3. Reboot</a></li>
          </ul>
        </li>
        <li><a href="TipsTicks">4.0 Tip and Ticks</a>
          <ul>
            <li><a href="usrPart">4.1 Separate usr Part</li></a>
          </ul>
        </li>
      </ul>
    </li>
  </div>
</div>

<a id="org63fb083"></a>

# About

After using Ubuntu and Debian for a moment, I decided to switch to Arch Linux
to provide a simple and light OS. Also, Arch Linux gives me the possibility to
stay tune with the latest version of the softwares.

You can find all my configurations in the customization folder.

For those interested, I was inspired by the installation of *Frederic Bezies*
and *Linux Scoop*.

This installation will cover a stable environment by installing LightDM as
display manager, XFCE as desktop environment and Awesome as window manager.

Feel free to install whatever you want after the basics steps. I really
appreciate LightDM for his light custormizable environment, same for XFCE and I
really have pleasure to use Awesome because of a his nice and beautiful dynamic
tiling window manager.

<a id="orgeb7cc6d"></a>

# Create a Bootable UEFI USB

On the assumption that :

-   *X* is the volume ID.
-   *Y* is the partition ID.

<a id="org0fbb290"></a>

## Make a FAT32 partition with boot flag

    sudo fdisk /dev/sdX

<a id="orgc1918c7"></a>

## Formatting the USB Flash Drive

    sudo mkfs.fat -F32 /dev/sdXY

<a id="orgb007aa3"></a>

## Labeling the USB Flash Drive

    sudo mlabel -i /dev/sdXY ::LABEL

<a id="orga50c0f6"></a>

## Installation of Arch Linux on the USB Flash Drive

Replace "archlinux" by the name of your ISO image of Arch Linux:

    sudo dd bs=4M if=archlinux.iso of=/dev/sdX status=progress && sync

-   bs (block size): on modern equipment (less than 5 years old), 4MB is a good bet.
-   if: source of the ISO image of Arch Linux.
-   of: destination to install the ISO image of Arch Linux.
-   status: automatically print periodic updates in the standard output.

<a id="org9ad32aa"></a>

## Start on USB key

To do that, checks the following things:

-   USB Flash Drive is first on the priority of boot.
-   Secure Boot is disabled.

<a id="org42a0815"></a>

# Installation of Arch Linux

When you launch the Arch Linux installation menu, select:

-   Boot Arch Linux (x86_64): for 64-bit systems.
-   Boot Arch Linux (i686): for 32-bit systems.

Now that we have the console allowing us to execute commands, it's time to
move on to serious things.

<a id="orgcecb97a"></a>

## Temporarily change the keyboard layout

By default, the keyboard is on *QWERTY* and it can be hurt to the regulars of
*AZERTY*.

<a id="orgca9915b"></a>

### List available keyboard layout

    ls /usr/share/kbd/keymaps/**/*.map.gz

<a id="org7e52ac0"></a>

### Load the layout

In this example, I put *be-latin1* as I'm using a belgian keyboard layout.
Feel free to change it by a keyboard layout from the list above.

    loadkeys be-latin1

<a id="orgc73eb0a"></a>

## Internet connection

Choose one of the two steps depending on your internet configuration.

<a id="orgde312d6"></a>

### Wi-Fi

Disable the dhcpd service:

    systemctl stop dhcpd.service

Use wifi-menu

    wifi-menu

<a id="org4515c3d"></a>

### Ethernet

Enable the dhcpd service (if you have disabled it):

    systemctl start dhcpd.service

<a id="orgbb4b217"></a>

## Few verifications

Before you start anything, check the following things:

<a id="org309546d"></a>

### Booted into UEFI mode

If the following file exists, that means that you booted into UEFI mode:

    ls /sys/firmware/efi/efivars

<a id="org387abb2"></a>

### Internet access

To verify that your system has an Internet connexion you can make a ping to
Google:

    ping -c 3 www.google.com

<a id="org7e85fba"></a>

## Hard Disk Partitioning (UEFI)

The following partitioning is for an UEFI installation. Be careful if you
want to install Arch Linux on a BIOS mode.

<a id="org4fc34c8"></a>

### Display the Hard Disk memory

List the partition tables for the specified devices:

    fdisk -l

<a id="orgbd981bd"></a>

### Creation of the file system

For the creation of the file system, I use *fdisk*. Whatever, you can use
*cgdisk* or another tool to do that.

The creation of 4 partitions will be useful:

1.   *EFI* file system: 300MB
2.   *SWAP* file system: 2 x RAM if you've 4GB or less of RAM. Else, use 1,5 x RAM.
3.   / file system: 100GB
4.   /home file system: the rest of disk.

As I'm using a *Lenovo ThinkPad*, I have different names for my partitions and I
will probably have different name for the sectors as I've got 1To of SSD.

For me:

-   /dev/nvme0n1 = /dev/sda
-   /dev/nvme0n1p1 = /dev/sda1
-   /dev/nvme0n1p2 = /dev/sda2
-   /nvme0n1p3 = /dev/sda3
-   /nvme0n1p4 = /dev/sda4

Let's select our disk to build the table:

    fdisk /dev/nvme0n1

Create a new empty GPT partion table:

    g

####  EFI

    Add a new partition: n

    Partition number (1-128, default 1): *ENTER*

    First sector (2048-2000409230, default 2048): *ENTER*

    Last sector, +sectors or +size{K,M,G,T,P} (2048-2000409230, default 2000409230): +300M

    Change a partition type: t

    Hex code (type L to list all codes): 1

####  SWAP

    Add a new partition: n

    Partition number (2-128, default 2): *ENTER*

    First sector (616448-2000409230, default 616448): *ENTER*

    Last sector, +sectors or +size{K,M,G,T,P} (616448-2000409230, default 2000409230): +24M

    [ Notice: I use 24MB as I've got 16GB of RAM. ]

    Change a partition type: t

    Partition number (1,2, default 2): *ENTER*

    Hex code (type L to list all codes): 19

####  /

    Add a new partition: n

    Partition number (3-128, default 3): *ENTER*

    First sector (665600-2000409230, default 665600): *ENTER*

    Last sector, +sectors or +size{K,M,G,T,P} (665600-2000409230, default 2000409230): +100G

    Change a partition type: t

    Partition number (1,2,3, default 3): *ENTER*

    Hex code (type L to list all codes): 24

####  /home

    Add a new partition: n

    Partition number (4-128, default 4): *ENTER*

    First sector (x-2000409230, default x): *ENTER*

    Last sector, +sectors or +size{K,M,G,T,P} (x-2000409230, default 2000409230): *ENTER*

    Change a partition type: t

    Partition number (1,2,3,4 default 4): *ENTER*

    Hex code (type L to list all codes): 28

<a id="org7183160"></a>

### Print the partition table

Before write the partitions, verify that all the partitions are corrects by typing *p*

### Write table to disk and exit

Now that the partitions are created, we need to write them into the partition table.

For that, just press *w*.

<a id="org7bb380e"></a>


## Build the file system

The partitions are created, but it is important not to forget to format them.

<a id="org5ced472"></a>

### EFI

    mkfs.fat -F32 /dev/nvme0n1p1

<a id="orgd9ee8e5"></a>

### SWAP

    mkswap /dev/nvme0n1p2
    swapon /dev/nvme0n1p2

<a id="orga18a7ee"></a>

### /

I use *-q* to keep the command silent and by the fact, accelerate his execution.

    mkfs.ext4 -q /dev/nvme0n1p3

[ Notice: just type *y* when we ask to you if you want to proceed anyway. ]

<a id="orgbb80bff"></a>

### /home

I use *-q* to keep the command silent and by the fact, accelerate his execution.

    mkfs.ext4 -q /dev/nvme0n1p4

<a id="org6a32928"></a>

## Disk mount

Now that the partitions are created and builded, we need to mount them.

<a id="orge4f5f1a"></a>

### /

    mount /dev/nvme0n1p3 /mnt

<a id="org21399ba"></a>

### /boot and /home

Creates the folders to mount the /boot and /home file system:

    mkdir /mnt/{boot,home}
    mount /dev/nvme0n1p1 /mnt/boot
    mount /dev/nvme0n1p4 /mnt/home

<a id="org3da06a5"></a>

## Activate mirrors

To download the useful packages, you need to activate the mirrors. Uncomment
the best servers (the servers that have a lower indice < 0.5)

    sed -i "s/Server/#Server/g" /etc/pacman.d/mirrorlist
    nano /etc/pacman.d/mirrorlist

<a id="orgaa7e8eb"></a>

## Installation of the system

    pacstrap /mnt base base-devel dialog  wireless_tools wpa_supplicant

<a id="org67d5faa"></a>

## Generate the fstab file

    genfstab -U -p /mnt >> /mnt/etc/fstab

<a id="org32f14fa"></a>

## Chroot in the system

    arch-chroot /mnt

<a id="org52bb743"></a>

## Configurations of the system

<a id="org2d358e9"></a>

### Permanently adding a keyboard layout

To permanently apply your keyboard layout, modify the following file:

    nano /etc/vconsole.conf

Adding the layout and the font. Feel free to change this by our own layout
and font.

    KEYMAP=be-latin1
    FONT=lat9u-16

<a id="org595f533"></a>

### Set languages for the system

To add languages for your system, uncomment the UTF-8 languages that you need in
the following file:

    nano /etc/locale.gen

After that, don't forget to generate the locale:

    locale-gen

Also, you need to add your language in the */etc/locale.conf* file.
Change the *LANG* variable by your own langage.

    echo "LANG=en_US.UTF-8" >> /etc/locale.conf
    echo "LC_COLLAPSE=C" >> /etc/locale.conf

Then you can applying the modifications:

    export LANG=en_US.UTF-8

<a id="orgba583db"></a>

### Set the hostname of the computer

In my example, the hostname is *Thinkpad*. Change it by whatever you
want.

    echo ThinkPad > /etc/hostname

<a id="org360c0b8"></a>

### Set the time zone

The only thing to do is to create a symbolic link to your continent and capital.
In my case, my continent is Europe and the capital of my country is Brussels.

    ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime

Once is done, adjust the time:

    hwclock --systohc --utc

<a id="org52d0a22"></a>

### Configure repository

It is important to don't forget to uncomment:

-   [multilib]
-   Include = /etc/pacman.d/mirrorlist

In this following file:

    nano /etc/pacman.conf

<a id="orga4b748b"></a>

### Synchronisation and update of packages

Now that few modifications have been done, we need to synchronize and update
our packages:

    pacman -Syy

<a id="orgaec876c"></a>

### Set a root password

    passwd

<a id="org9a3c75d"></a>

### Set a new user with a password

It is avoid to always work in root, that why you need to create one user:

    useradd -m -g users -G wheel,storage,power -c 'Who Cares' -s /bin/bash someone

-   m: create the user's home directory.
-   g: group name.
-   G: list of groups which the user is also a member.
-   c: any text string. People often usualy put their full name.
-   s: name of the user's login shell.

Don't forget to set him a password:

    passwd someone

Another thing to not forget, is to allow the users in *wheel* group to be able
to performance administrative tasks with *sudo*:

    EDITOR=nano visudo

Then, uncomment the following line:

    %wheel ALL=(ALL) ALL

<a id="org3528dc7"></a>

## Install and configure boot loader

Without that, your system can't starting.

<a id="org385832d"></a>

### Generate the Kernel

Feel free to use the LTS version of the Kernel.

    mkinitcpio -p linux

<a id="org57292f0"></a>

### Installing GRUB

It's time to install GRUB and os-prober useful to lists other operating
systems inside the GRUB boot menu.

1.  Installation of packages:

        pacman -S grub efibootmgr

Notice: for multisystem, you can additionally install *os-prober* that permit to show the
different OS when grub starts.

3.  Generate the GRUB file:

        grub-mkconfig -o /boot/grub/grub.cfg

2.  Configuration of GRUB:

For 32-bit systems, replace x86_64-efi with i386-efi where appropriate.

        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
        mkdir /boot/EFI/boot
        cp /boot/EFI/arch_grub/grubx64.efi /boot/EFI/boot/bootx64.efi

<a id="org33b511f"></a>

### Network-Manager

It is really important to don't forget to install the network-manager before reboot.

	sudo pacman -S networkmanager nework-manager-applet gnome-keyring

Enable it:

 	systemctl enable NetworkManager

## Before restart the system

<a id="orgc5e8491"></a>

### Exit the chroot mode

    exit

<a id="org6e3b161"></a>

### Unmount the partitions

    umount -R /mnt

<a id="org7109cb0"></a>

### Reboot

Reboot the system and eject the USB.

    reboot

***************************************

# 4.0 Tips and Ticks
<a id="TipsTicks"></a>

## 4.1 Separate /usr partition Step by Step
<a id="usrPart"></a>

For mount /usr (Data of pacman install) into another partition,
use the folowing Tutorial :


4.1.1) First Create Partition
-------------------------

    fdisk /dev/sdX # Change X to disk Letter

    Add a new partition: n

    Partition number (3-128, default 3): *ENTER*

    First sector (665600-2000409230, default 665600): *ENTER*

    Last sector, +sectors or +size{K,M,G,T,P} (665600-2000409230, default 2000409230): +100G

    Change a partition type: t

    Partition number (1,2,3, default 3): *ENTER*

    Hex code (type L to list all codes): 24

    Ps : Do Write table to disk and exit


4.1.2) Build the file system
------------------------

    mkfs.ext4 -q /dev/sdX

4.1.3) mount the partition
----------------------

    A) Mount the part into temp folder

      sudo mkdir -pv /mnt/Temp
      sudo mount /dev/sdX  /mnt/Temp


    B) Copy ther /usr into /mnt/Temp

       sudo cp -avr /usr/* /mnt/Temp
       sudo umount -R /mnt/Temp

    c) Delete /usr File

        sudo rm -rfv /usr
	sudo mount /dev/sdX /usr


4.1.4) Add /usr into Fstab
----------------------
    a) Get the list UUID of disks:

	ls -lah /dev/disk/by-uuid/

	lrwxrwxrwx 1 root root  10 26 déc 12:16 6091-FE00 -> ../../sda1
	lrwxrwxrwx 1 root root  10 26 déc 12:16 7551ae38-6fc8-4531-a138-18f2f08f2347 -> ../../sdb1
	lrwxrwxrwx 1 root root  10 26 déc 12:16 8becbdea-7163-4d98-a425-72852c4d8355 -> ../../sda3
	lrwxrwxrwx 1 root root  10 26 déc 12:16 9dfc0eb1-7d25-4359-8703-9b3f17a65ef0 -> ../../sda2

     b) Add the entry into fstab (exemple)


	UUID=6091-FE00                            /boot/efi      vfat    defaults,noatime 0 2
	UUID=9dfc0eb1-7d25-4359-8703-9b3f17a65ef0 /              ext4    defaults,noatime,discard 0 1
	UUID=8becbdea-7163-4d98-a425-72852c4d8355 swap           swap    defaults,noatime,discard 0 2
	UUID=7551ae38-6fc8-4531-a138-18f2f08f2347 /usr	 	 ext4	 defaults,noatime,discard 0 1
	tmpfs                                     /tmp           tmpfs   defaults,noatime,mode=1777 0 0


4.1.5) Create the hook
------------------

    Edit the file for Hook usr into process of boot

    nano /etc/mkinit.cpio.conf


    Modify the hook and add 'usr' after keyboard and before fsck

    HOOKS=(base udev autodetect modconf block filesystems keyboard usr fsck shutdown)


4.1.6) Fresh Install grub
---------------------

	mkinitcpio -p linux

	grub-mkconfig -o /boot/grub/grub.cfg

	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck

	cp -avr /boot/EFI/arch_grub/grubx64.efi /boot/EFI/boot/bootx64.efi

***************

# Installing a stable environment

## Audio packages

    sudo pacman -S gst-plugins-base gst-plugins-bad gst-plugins-good gst-plugins-ugly gst-libav pulseaudio pulseaudio-alsa pavucontrol alsa-utils

## Xorg

    sudo pacman -S xorg-server xorg-server-utils xorg-xinit xorg-xmessage xorg-utils xorg-apps xf86-input-mouse xf86-input-keyboard xf86-input-synaptics xf86-input-libinput xdg-user-dirs

## Git

    pacman -S git

    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

    git config --global credential.helper store

## TODO install pakku + pacaur



## Chromium

    sudo pacman -S chromium
    yaourt pepper-flash

## Video drivers

    pacman -S xf86-video-vesa
    yaourt glxgears

Notice: for Intel cards, you can additionally install *xf86-video-intel*

## Printer

    sudo pacman -S cups hplip python-pyqt5

### Drivers

    sudo pacman -S foomatic-db foomatic-db-ppds foomatic-db-gutenprint foomatic-db-gutenprint-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint

## LightDM

    sudo pacman -S lightdm lightdm-gtk-greeter

### Set a theme

I personally like the material theme, feel free keep the original theme or
use another one.

    yaourt lightdm-webkit-theme-material-git

To set the theme, you need to modify the */etc/lightdm/lightdm-webkit2-greeter.conf* file:

    nano /etc/lightdm/lightdm-webkit2-greeter.conf

Search for **greeter** section and set webkit-theme to **material**

Then, go to */etc/lightdm/lightdm.conf*

    nano /etc/lightdm/lightdm.conf

Search for this *greeter-session=example-gtk-gnome* and replace *gnome* by
*lightdm-webkit2-greeter*

The last thing to do is to set your own user picture

Modify this file */var/lib/AccountsService/users/someone*

Just replace *someone* by your username.

Then, you can add this line in the bottoom

    Icon=/var/lib/AccountsService/icons/someone

Again, don't forget to change *someone* here too.

The last thing to do, is to put copy the default picture on the path.

    sudo cp -r /usr/share/lightdm-webkit/themes/material/assets/ui/avatar.png /var/lib/AccountsService/icons/someone

### XFCE

    sudo pacman -S xfce4 xfce4-goodies

### Tools

    sudo pacman -S evince vlc

### Awesome

    sudo pacman -S awesome compton
    yaourt lain
    yaourt vicious
    yaourt scrot

### Enable

    systemctl enable lightdm.service
    systemctl start lightdm.service
