{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
    # "${inputs.pkgsReview}/nixos/modules/services/desktops/pipewire/pipewire.nix"
  ];

  disabledModules = [
    # "services/desktops/pipewire/pipewire.nix"
  ];

  environment.systemPackages = with pkgs; [
    wordbook
  ];


  services.xserver = {
    # xkbOptions = "ctrl:swapcaps"; # emacser habit on Xorg
  };

  # latest or zen or xanmod_latest
  boot.kernelPackages = pkgs.linuxPackages_latest;

  virtualisation = {
    memorySize = 1024 * 3;
    diskSize = 1024 * 8;
    cores = 4;
    msize = 104857600;
  };

  users.users.root = {
    password = "root";
  };

  # password: test
  users.users.${username}.hashedPassword = lib.mkForce "$6$HFoXsNJNYZ.lVv0r$vxau6GLUcGMmPctb135ZFYzRO7p0Y0JXDeqSASudCbSSa917.7I4Vi1A/AOjWAWkT2DguOB0VMf0.HW4cy5zp0";
}
