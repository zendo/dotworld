{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # compressor / archiver packages
    p7zip
    unzip
    unrar
    patool

    # system monitor
    btop
    ctop # containers monitor
    powertop
    bottom # btm
    psmisc # pstree
    ikill
    gdu
    duf
    neofetch

    # tui utils
    fd
    ripgrep
    hstr # hh: history
    cht-sh
    tealdeer
    trash-cli
    rage # age encrypt RIIR
    mc
    f2
    choose
    croc
    # difftastic # too big
    kalker # calculator
    imagemagick
    ydict
    typos
    translate-shell
    aspellDicts.en
    asciinema # record the terminal
    distrobox
    graphviz
    paperoni # save html
    # airgeddon # wifi crack
    # magic-wormhole # python
    magic-wormhole-rs

    # Develop
    # gcc
    # cmake
    # gnumake
    # nodejs
    # yarn
    gitui
    onefetch
    jq
    jql
    cloc # count code lines
    sqlite
    openssl
    python3

    # Network
    lsof
    dogdns
    nali
    mtr
    elinks
    dnspeep
    bandwhich
    traceroute
    speedtest-cli

    # NIX TOOLS
    nixpkgs-fmt
    nixfmt
    alejandra
    rnix-lsp
    lorri
    comma
    manix
    niv
    nvd
    cachix
    nixos-generators
    nix-template
    nix-index
    nix-tree
    home-manager
    # nvfetcher
    nix-index-updatedb
  ];

  manual.manpages.enable = false;

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.exa = {
    enable = true;
    # ll, la, lla, lt ...
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.aria2 = {
    enable = true;
  };

  # z: autojump
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.tealdeer = {
    enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
