{
  inputs,
  self,
  pkgs,
  lib,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    ./bcachefs-single.nix
    # ./btrfs-subvolumes.nix
    ./hardware-configuration.nix

    self.nixosModules.gnome
    # self.nixosModules.kde
    # self.nixosModules.cosmic
    # self.nixosModules.sway
    # self.nixosModules.niri
    # self.nixosModules.hyprland
  ];

  mods = {
    virt.enable = false;
    # steam.enable = true;
    # daeWithConfig.enable = true;
  };

  users.users.${username} = {
    # 123
    hashedPassword = "$y$j9T$HMRcTJOCJnmqDmH2cPVGF.$ZeGBjMnWDDpnicBGlVGZGNSkEXxdI7jLvm3GHK8eqVA";
  };

  environment.systemPackages = with pkgs; [
    duf
    gdu
  ];

  programs = {
    # appimage.enable = true;
    # nix-ld.enable = true;

    # clash-client = {
    #   enable = true;
    #   tunMode = true;
    #   autoStart = true;
    #   package = pkgs.mihomo-party;
    # };

    # clash-verge = {
    #   enable = true;
    #   autoStart = true;
    # };
  };

  # Desktop Environment
  services = {
    displayManager.autoLogin.user = "${username}";
    xserver = {
      # enable = true;
      desktopManager = {
        # gnome.enable = true;
        # xfce.enable = true;
        # budgie.enable = true;
        # deepin.enable = true;
        # cinnamon.enable = true;
        # pantheon.enable = true;
        # enlightenment.enable = true;
        # mate.enable = true;
        # lxqt.enable = true;
      };
      xkb.options = "ctrl:swapcaps"; # Xorg Layout
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Systemd-boot
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi"; # default /boot
      systemd-boot.enable = true;
    };
  };

  # Clipboard shared for NixOS@Guest
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
