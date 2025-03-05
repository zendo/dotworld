{
  pkgs,
  lib,
  inputs,
  self,
  username,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
    # "${inputs.pkgsReview}/nixos/modules/services/desktops/pipewire/pipewire.nix"

    # self.nixosModules.gnome
    # self.nixosModules.kde
    # self.nixosModules.cosmic
    # self.nixosModules.sway
    self.nixosModules.niri
    # self.nixosModules.hyprland
  ];

  disabledModules = [
    # "services/desktops/pipewire/pipewire.nix"
  ];

  mods = {
    virt.enable = false;
    # daeWithConfig.enable = true;
  };

  programs = {
    # nix-ld.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    notes
  ];

  environment.variables = { };

  services = {
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
    displayManager.autoLogin.user = "${username}";
  };

  # boot.initrd.kernelModules = ["virtio" "virtio_pci" "virtio_net" "virtio_rng" "virtio_blk" "virtio_console"];

  # Clipboard shared for NixOS@Guest
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  virtualisation = {
    memorySize = 1024 * 4;
    diskSize = 1024 * 8;
    cores = 8;
    msize = 104857600; # 100M
    qemu = {
      options = [
        # Sounds
        "-audiodev pa,id=snd0"
        "-device ich9-intel-hda"
        "-device hda-duplex,audiodev=snd0"
        # Graphical for sway
        # "-vga qxl"
        # Wayland in QEMU
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  users.users = {
    # passwd: root
    root.initialHashedPassword = lib.mkForce "$y$j9T$0t8NyDpq3ikgERiGgdPru0$pI6bTECjj2pSb68lF.U0xpftH.2vTF26uiRasZnROD3";
    # psaawd: test
    ${username}.initialHashedPassword =
      lib.mkForce "$y$j9T$cwgM31P53Jvlqq2Ed/ad0.$t1G8tnJg7DsspO2687hpTO87v2uSVfB9E5hpBufYhR.";
  };

  # home-manager.users.${username} = { };
}
