{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma6.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = {
      bcachefs = true;
      # always broken
      zfs = lib.mkForce false;
    };
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
    parted
    gptfdisk
    wget
    bind

    vim
    micro
    btop
    ouch
  ];

  time.timeZone = "Asia/Shanghai";

  hardware.enableAllFirmware = true;

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings = {
    substituters = lib.mkForce [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    trusted-users = [ "@wheel" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # fast but lowest compression level
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
