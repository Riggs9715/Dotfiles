- Change the keyboard layout and font for the installation media (font is optional but should make it nicer to read while working in tty)
```
loadkeys uk
setfont ter-132b
```

- Confirm system is booted in 64bit UEFI mode. The output should be 64
```
cat /sys/firmware/efi/fw_platform_size
```

- Connect to the internet. Wired should be automatic. wireless code below. Note: *myAdapter myStation* and *myNetwork* are found in the outputs of the list and get-network commands.
```
iwctl
adapter list
adapter myAdapter set-property Powered on
station list
station myStation scan
station myStation get-networks
station myStation connect myNetwork
```

- Set the timezone
```
timedatectl set-timezone Europe/London
```

- find the name of the disk with lsblk (examples will use sda) and using fdisk, create a gpt label with 3 partitions. an efi type partition of 1G, a swap type partition of RAM\*2 G and a root type partition filling the rest of the drive
```
lsblk
fdisk /dev/device
```

- format the 3 partitions. The below assumes p1 if efi, p2 is swap and p3 is root
```
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.btrfs /dev/sda3
```

- mount the root partition to /mnt and create the btrfs subvolumes. When finished, list them to obtain the subvolume IDs
```
mount /dev/sda3 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
btrfs subvolume list /mnt
```

- unmount the partition and mount the subvolumes by ID with the subvol ID 5 mounted to .btrfsroot. After the first subvolume, the mountpoints for the others will need to be created. Also mount the efi partition and activate swap. Note: check subvol IDs. Below example should br right but make sure to check.
```
umount /mnt
mount -o noatime,compress=zstd,space_cache=v2,subvolid=256 /dev/sda3 /mnt
mkdir -p /mnt/{home,efi,.snapshots,var/log,.btrfsroot}
mount -o noatime,compress=zstd,space_cache=v2,subvolid=257 /dev/sda3 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,subvolid=258 /dev/sda3 /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,subvolid=259 /dev/sda3 /mnt/var/log
mount -o noatime,compress=zstd,space_cache=v2,subvolid=5 /dev/sda3 /mnt/.btrfsroot
mount /dev/sda1 /mnt/efi
swapon /dev/sda2
```

- Install basic packages. switch intel-ucode for amd-ucode if using an amd cpu
```
pacstrap -K /mnt base base-devel linux linux-firmware linux-headers intel-ucode networkmanager neovim 
```

- generate the filesystem table and check it for errors
```
 genfstab -U /mnt >> /mnt/etc/fstab
 cat /mnt/etc/fstab
```

- chroot into the system
```
arch-chroot /mnt
```

- configure timezone and link the hardware and system clocks
```
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
```

- edit the locale.gen file and uncomment the correct locale then generate it
```
sudo nvim /etc/locale.gen
locale-gen
```

edit the locale.conf vconsole.conf and hostname files
```
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "arch-example-hostname" >> /etc/hostname
```

- edit the mkinitcpio.conf file, add btrfs to the modules and regenerate the initramfs
```
sudo nvim /etc/mkinitcpio.conf
mkinitcpio -P
```

- give the root user a password
```
passwd
```

- install grub, efibootmgr and the ufw firewall
```
 pacman -S grub efibootmgr ufw
```

- run grub-install and generate the grub config
``` 
grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

-  use visudo to edit sudo permissions and uncomment the line giving wheel group sudo access
```
EDITOR=nvim visudo

%wheel ALL=(ALL:ALL) ALL
```
- create a user in the wheel group and give them a password
```
useradd -mG wheel username
passwd username
```
- exit the chroot, unmount everything and reboot the system
```
exit
umount -R /mnt
reboot
```

- log in to user account and lock the root account for security
```
sudo passwd --lock root
```

- enable the firewall and network manager, then run nmtui to connect to wifi
```
sudo systemctl enable --now ufw
sudo ufw enable
sudo systemctl enable --now NetworkManager
nmtui
```

- install git and xdg-user-dirs and generate the user directories
```
sudo pacman -S git xdg-user-dirs
xdg-user-dirs-update
```