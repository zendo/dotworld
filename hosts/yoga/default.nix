{
  inputs,
  self,
  config,
  pkgs,
  lib,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    # Secure Boot
    # inputs.lanzaboote.nixosModules.lanzaboote

    # "${modulesPath}/profiles/perlless.nix"

    inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    # inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu
    # cpupower frequency-info
    # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
    # ls /sys/devices/system/cpu/cpu0/   :show CPPCCPPC

    self.nixosModules.gnome
    # self.nixosModules.kde
    # self.nixosModules.cosmic
    # self.nixosModules.sway
    # self.nixosModules.niri
    # self.nixosModules.hyprland
  ];

  disabledModules = [
    "services/networking/sing-box.nix"
  ];

  services = {
    # displayManager.autoLogin.user = "${username}";
    # v2raya.enable = true;

    sing-box ={
      enable = true;
      configFile = "/home/iab/.sub/config.json";
      # configFile = "/home/iab/.local/share/GUI.for.SingBox/data/sing-box/config.json";
    };
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
      # autoStart = true;
    };
  };

  mods = {
    steam.enable = true;
    # daeWithConfig.enable = true;
  };

  # disabledModules = ["config/swap.nix"];

  # environment.systemPackages = with pkgs; [
  #   inputs.nixpkgs-pr.legacyPackages.${system}.apps
  # ];

  ###############################################
  ## Hardware
  ###############################################

  # fix ax200 bluetooth randomly lose connectivity
  # hardware.enableAllFirmware = true;
  # nixpkgs.config.allowUnfree = true;

  # hardware.amdgpu.amdvlk.enable = true;

  boot = {
    # latest / zen / lqx / xanmod_latest
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      # Fixes for s2idle: https://www.phoronix.com/news/More-s2idle-Rembrandt-Linux
      # https://github.com/NixOS/nixos-hardware/blob/master/lenovo/yoga/7/14ARH7/shared.nix#L25
      "acpi.prefer_microsoft_dsm_guid=1"
    ];

    supportedFilesystems = [
      "ntfs"
    ];

    # https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
    # kernel.sysctl = {
    #   "vm.max_map_count" = 2147483642; # default: 1048576
    # };

    # plymouth = {
    #   theme = "double";
    #   themePackages = [pkgs.adi1090x-plymouth-themes];
    # };

    # binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
  };

  # Swapfile
  swapDevices = [
    {
      device = "/var/swapfile";
      size = 1024 * 10;
    }
  ];

  ###############################################
  ## Bootloader
  ###############################################
  /*
    disable Secure-Boot and reset to Setup-Mode
    sudo -i
    sbctl create-keys
    sbctl enroll-keys --microsoft
  */
  # boot.lanzaboote = {
  #   enable = true;
  #   configurationLimit = 3;
  #   pkiBundle = "/etc/secureboot";
  #   # settings = {
  #   # };
  # };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi"; # default /boot
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 5; # bootmenu items
      consoleMode = "max";
      windows = {
        "nvme0n1p1" = {
          title = "Windows 11";
          # sudo blkid //check Windows ESP PARTUUID
          # reboot to systemd-boot uefi shell and type: map
          # find the FS alias match Windows ESP (ex: HD0a66666a2, HD0b, FS1, or BLK7)
          efiDeviceHandle = "FS0";
          sortKey = "a_windows";
        };
      };
    };
    grub = {
      # enable = true;
      device = "nodev";
      efiSupport = true;
      gfxmodeEfi = "1024x768";
      default = "1";
      # extraEntriesBeforeNixOS = true;
      extraEntries = ''
        menuentry "Windows" {
         search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
         chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry "Firmware" {
         fwsetup
        }
        menuentry "Shutdown" {
         halt
        }
      '';
      # theme = pkgs.fetchzip {
      # https://github.com/AdisonCavani/distro-grub-themes
      #   url = "https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/freeBSD.tar";
      #   hash = "sha256-oTrh+5g73y/AXSR+MPz6a25KyCKCPLL8mZCDup/ENZc=";
      #   stripRoot=false;
      # };
    };
  };
}
