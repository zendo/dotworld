{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    cmake
    gnumake
    python3
    # nil
    nixd
    vscode
  ];

  programs.pandoc = {
    enable = false;
  };

  ###############################################
  ##  EMACS
  ###############################################
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

  ###############################################
  ##  VSCODE
  ###############################################
  programs.vscode = {
    # enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-ceintl.vscode-language-pack-zh-hans
        file-icons.file-icons
        eamodio.gitlens
        editorconfig.editorconfig
        foxundermoon.shell-format
        tamasfe.even-better-toml
        # kdl-org.kdl
        nefrob.vscode-just-syntax
        esbenp.prettier-vscode
        golang.go
        mattn.lisp
        ms-python.python
        jnoortheen.nix-ide
        # ms-vscode.cmake-tools
      ];
      userSettings = {
        "files.autoSave" = "onFocusChange";
        "editor.fontSize" = 13;
        "editor.fontFamily" =
          "'JetBrains Mono', 'Hack', 'Droid Sans Mono', monospace, 'Droid Sans Fallback'";
        "update.mode" = "none";
        "nix.formatterPath" = "nixfmt";
        # "workbench.colorTheme" = "Monokai";
        # "workbench.commandPalette.preserveInput" = true;
        # "workbench.editor.enablePreviewFromCodeNavigation" = true;
        # "workbench.iconTheme" = "vscode-icons";
        "[yaml]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };
      # keybindings = [
      #   {
      #     key = "ctrl+m";
      #     command = "editor.action.clipboardCopyAction";
      #     when = "textInputFocus";
      #   }
      # ];
    };
  };

  ###############################################
  ##  ZED-EDITOR
  ###############################################
  programs.zed-editor = {
    # enable = true;
    extensions = [
      "nix"
      "xy-zed" # a gorgeous dark theme
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = false;
      ui_font_size = 16;
      buffer_font_size = 14;
    };
  };

  ###############################################
  ##  TUI
  ###############################################
  programs.helix = {
    # enable = true;
  };
}
