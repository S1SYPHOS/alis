loadkeys de

mount /mnt /dev/sda1
basestrap /mnt base base-devel linux linux-firmware runit elogind-runit

fstabgen -U /mnt >> /mnt/etc/fstab

artix-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
artix-chroot /mnt hwclock --systohc
artix-chroot /mnt pacman -S grub --noconfirm
artix-chroot /mnt grub-install --recheck /dev/sda
artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
artix-chroot /mnt passwd
artix-chroot /mnt pacman -S dhcpcd --noconfirm

artix-chroot /mnt pacman -S connman-runit connman-gtk --noconfirm
artix-chroot /mnt ln -sf /etc/runit/sv/connmand /etc/runit/runsvdir/default
umount -R /mnt
reboot
