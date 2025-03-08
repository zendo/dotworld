{ self, lib, ... }:
{
  nixpkgs = {
    overlays = builtins.attrValues self.overlays;

    config = {
      # allowUnfree = true;
      # allowBroken = true;
      # allowInsecure = true;
      # allowUnsupportedSystem = true;
      android_sdk.accept_license = true;
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "unrar"
          "steam"
          "vscode"
          "spotify"
          "google-chrome"
          "steam-unwrapped"
          "balatro"
        ];
    };
  };
}
