{
  lib,
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # GUI
        foot
        kitty
        ghostty

        # DEV
        gcc
        cmake
        python3
        nixd
      ];

      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages =
          epkgs: with epkgs; [
            jinx
            vterm
            emojify
            sqlite3
            # lsp-bridge
            # pdf-tools
            # telega
            treesit-grammars.with-all-grammars
          ];
        extraConfig = ''
          (display-time-mode 1)
        '';
      };
    };

  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
  };

  programs = {
    zsh.enable = true;
    command-not-found.enable = false;
  };

  environment.systemPackages = with pkgs; [
    binutils
    tree
    file
    wget
    flow-editor
    wslu
    wsl-open
  ];

  # vscode-remote-workaround
  # https://github.com/K900/vscode-remote-workaround
  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = [ "default.target" ];
      pathConfig.PathChanged = "%h/.vscode-server/bin";
    };
    services.vscode-remote-workaround.script = ''
      for i in ~/.vscode-server/bin/*; do
        echo "Fixing vscode-server in $i..."
        ln -sf ${lib.getExe pkgs.nodejs} $i/node
      done
    '';
  };

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "25.05";
  documentation.enable = false;
  nixpkgs.hostPlatform = "x86_64-linux";

  # nixos-rebuild-ng: Python-based re-implementation
  system.rebuild.enableNg = true;
}
