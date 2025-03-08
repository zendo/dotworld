{
  inputs,
  self,
  pkgs,
  config,
  username,
  ...
}:
{
  imports = [
    # ./bcachefs-single.nix
    ./btrfs-subvolumes.nix

    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-gpu-intel

    self.nixosModules.gnome
    # self.nixosModules.kde
    # self.nixosModules.cosmic
    # self.nixosModules.sway
    # self.nixosModules.niri
    # self.nixosModules.hyprland
  ];

  services = {
    displayManager.autoLogin.user = "${username}";
    # v2raya.enable = true;
  };

  mods = {
    # steam.enable = true;
    daeWithConfig.enable = true;
  };

  programs = {
    appimage.enable = true;
    # nix-ld.enable = true;

    # clash-client = {
    #   enable = true;
    #   tunMode = true;
    #   autoStart = true;
    #   package = pkgs.mihomo-party;
    # };

    clash-verge = {
      enable = true;
      autoStart = true;
    };
  };

  users.users.${username} = {
    # 123
    hashedPassword = "$y$j9T$HMRcTJOCJnmqDmH2cPVGF.$ZeGBjMnWDDpnicBGlVGZGNSkEXxdI7jLvm3GHK8eqVA";
  };

  boot = {
    # latest / zen / lqx / xanmod_latest
    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [
      "ntfs"
    ];
  };

  ###############################################
  ## Bootloader
  ###############################################
  boot.loader = {
    efi.efiSysMountPoint = "/efi"; # default /boot
    systemd-boot.enable = true;
    grub = {
      # enable = true;
      device = "nodev";
      efiSupport = true;
      # Because this machine's efivars can't touch
      # It just move grubx64.efi -> Boot/bootx64.efi
      efiInstallAsRemovable = true;
      extraEntries = ''
          menuentry "Windows" {
           search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
           chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
          }

        #   menuentry "Arch Linux" {
        #    search --file --no-floppy --set=root /EFI/arch/grubx64.efi
        #    chainloader (''${root})/EFI/arch/grubx64.efi
        #   }
      '';
    };
  };

  # Swapfile (bcachefs not support)
  swapDevices = [
    {
      device = "/var/swapfile";
      size = 1024 * 8;
    }
  ];
}
