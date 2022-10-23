# Quick start

1. Acquire NixOS 21.11 or newer:
   ```sh
   # Yoink nixos-unstable
   wget -O nixos.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso
   
   # Write it to a flash drive
   cp nixos.iso /dev/sdX
   ```

2. Boot into the installer.

3. Switch to root user: `sudo su -`

4. Prepare the machine
   ```sh
   # setup crypto
   cryptsetup luksFormat /dev/nvme0n1p2
   cryptsetup luksOpen /dev/nvme0n1p2 root

   # setup lvm
   pvcreate /dev/mapper/root
   vgcreate vg0 /dev/gpt-auto-root
   lvcreate -L32G vg0 -n swap
   lvcreate -L1.5T vg0 -n root

   # format disks
   mkfs.ext4 -m1 -L root /dev/vg0/root
   mkswap -L swap /dev/vg0/swap

   # mount disks
   swapon /dev/vg0/swap
   mount /dev/vg0/root /mnt
   mkdir /mnt/boot
   mount -m /dev/nvme0n1p1 /mnt/boot
   ```

5. Install these dotfiles:
   ```sh
   # install our stuff
   nix-shell -p git nixFlakes
   git clone https://github.com/ac0v/nixos-cfg.git /etc/dotfiles
   cd /etc/dotfiles

   # adjust your /dev/disk-by-uuid
   sed -i 's/\/dev\/disk\/by-uuid\/[0-9a-f-]*/\/dev\/disk\/by-uuid\/'$(blkid -s UUID -o value /dev/nvme0n1p2)'/' hosts/blacky/hardware-configuration.nix

   export HOST=blacky
   export USER=ac0v

   nixos-install --root /mnt --impure --flake .#$HOST

   mv /etc/dotfiles /mnt/etc/
   ```

6. Then reboot and you're good to go!

> :warning: **Don't forget to change your `root` and `$USER` passwords!** They
> are set to `nixos` by default.
