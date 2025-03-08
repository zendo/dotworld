{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    # "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma6.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
      # "bcachefs"
    ];
  };

  environment.systemPackages = with pkgs; [
    binutils
    tree
    file
    p7zip
    fd
    ripgrep
    gdu
    duf
    fastfetch
    parted
    gptfdisk
    wget
    bind
    git
    nix-bash-completions
    # bcachefs-tools

    vim
    micro
    fish
    btop
    unrar
    ouch
    ipinfo
  ];

  hardware.enableAllFirmware = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  nix.settings = {
    substituters = lib.mkForce [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-users = [ "@wheel" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  time.timeZone = "Asia/Shanghai";

  # faster but bigger
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
