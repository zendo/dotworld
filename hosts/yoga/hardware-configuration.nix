# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];



  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/1754f52f-b613-4499-aeb2-821f22e49821";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/1754f52f-b613-4499-aeb2-821f22e49821";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/1754f52f-b613-4499-aeb2-821f22e49821";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/A402-7E3F";
      fsType = "vfat";
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/1754f52f-b613-4499-aeb2-821f22e49821";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = (1024 * 16) + (1024 * 2); # RAM size + 2 GB1
    }
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

  # verify checksums, repair corrupted blocks
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}
