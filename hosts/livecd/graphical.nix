/*
  https://wiki.nixos.org/wiki/Creating_a_NixOS_live_CD

  https://github.com/NixOS/nix/issues/8911
  --option auto-allocate-uids false
*/
{
  inputs,
  self,
  pkgs,
  lib,
  config,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

    self.nixosModules.gnome
    # self.nixosModules.kde
    # self.nixosModules.sway
    # self.nixosModules.hyprland
  ];

  boot = {
    tmp.useTmpfs = false;
    initrd.systemd.enable = false;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = {
      bcachefs = true;
      # always broken
      zfs = lib.mkForce false;
    };
  };

  services = {
    displayManager.autoLogin.user = "${username}";
    xserver = {
      xkb.options = "ctrl:swapcaps"; # Xorg Layout
    };
  };

  users.users = {
    # passwd: root
    root.initialHashedPassword = lib.mkForce "$y$j9T$8/wRQiclXB6j79eGn8FKp.$MayXuTGruzrN4kDOUXSIJhPUg3BLdL69EOERDXRRQq.";
    # psaawd: live
    ${username}.initialHashedPassword =
      lib.mkForce "$y$j9T$0VrmGqGBIdqClS5ndapJv0$sJDzKPsSQdM2bm9Z.o1TI1alC46LMWgIFf14CbSSoWB";
  };

  mods.virt.enable = false;

  environment.systemPackages = with pkgs; [ dippi ];

  networking.wireless.enable = lib.mkImageMediaOverride false;

  nixpkgs.hostPlatform = "x86_64-linux";

  # fast but lowest compression level
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
