{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  nix = {
    channel.enable = false;

    registry = lib.mkMerge [
      { n.flake = inputs.nixpkgs; }
      { self.flake = inputs.self; }
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };

    package = pkgs.nixVersions.latest;

    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      auto-allocate-uids = true;
      use-cgroups = true;
      # max-jobs = 8; # limit the number of parallel jobs
      flake-registry = ""; # disable global registry

      # for direnv GC roots
      # keep-outputs = true;
      # keep-derivations = true;

      substituters = [
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://cache.nixos.org"
        # "https://cosmic.cachix.org/"
        # "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];
      # List of binary cache URLs that non-root users can use
      trusted-substituters = [ ];
      trusted-public-keys = [
        # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      experimental-features = [
        "flakes"
        "nix-command"
        # "configurable-impure-env"

        # Allows Nix to execute builds inside cgroups
        "cgroups"
        # Allows Nix to automatically pick UIDs for builds, rather than creating nixbld* user accounts
        "auto-allocate-uids"

        "pipe-operators"
      ];
    };
  };

  # for large files
  systemd.services.nix-daemon = lib.mkIf config.boot.tmp.useTmpfs {
    environment.TMPDIR = "/var/tmp";
  };
}
