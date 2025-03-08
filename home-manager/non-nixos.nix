{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home = {
    sessionPath = [
      "${../dotfiles/bin}"
      "${config.home.homeDirectory}/.local/bin"
    ];
    sessionVariables = {
      VISUAL = "flow";
      EDITOR = "flow";
    };
    shellAliases = {
      nixgl = "nix run --impure github:guibou/nixGL";
    };
    enableNixpkgsReleaseCheck = false;
  };

  home.packages = with pkgs; [
    dippi
    goodvibes
    (config.lib.nixGL.wrap pkgs.kitty)
    (config.lib.nixGL.wrap pkgs.google-chrome)
  ];

  programs = {
    home-manager.enable = true;
    # mpv.package = config.lib.nixGL.wrap pkgs.mpv;
  };

  # nixGL
  nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
    # A wrapper script named nixGLWrp
    installScripts = [ "mesa" ];
  };

  nix = {
    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
      n.flake = inputs.nixpkgs;
    };
    package = pkgs.nixVersions.latest; # need for nix.settings
    settings = {
      warn-dirty = false;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
}
