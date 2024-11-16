Recreating my setup with cloned dotfiles will still miss a few things changed in etc files.
To fix this, here is everything which must be manually configured after which the cloned dotfiles and packagelist can be used to fully recreate my system.

[[Arch Installation]]
[[Package Management]]
[[Snapper]]
[[Audio and Video]]

paru -S snapper snapper-rollback snap-pac-grub
sudo nvim /etc/snapper-rollback.conf
mountpoint to /.btrfsroot
sudo umount /.snapshots
sudo rmdir /.snapshots
sudo snapper -c root create-config /
sudo mount -a
sudo nvim /etc/snapper/configs/root
add riggs to ALLOWED_USERS
set timeline limits 
5 hour
7 day 
4 week
sudo systemctl enable snapper-timeline.timer
sudo systemctl enable snapper-cleanup.timer


paru -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel 
paru -S pipewire lib32-pipewire wireplumber
paru -S --asdeps pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack
systemctl enable --user pipewire
systemctl enable --user wireplumber
systemctl enable --user pipewire-pulse

paru -S hyprland rofi-wayland ly kitty
sudo systemctl enable ly
sudo nvim /etc/ly/config.ini
change animation to matrix
change numlock to true

paru -S zen-browser-avx2-bin