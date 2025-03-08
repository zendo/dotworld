{ pkgs, ... }:
{
  manual.manpages.enable = false;

  home.packages = with pkgs; [
    # Nix Tools
    # alejandra
    nixfmt-rfc-style
    # lorri
    # cachix
    # comma # ,
    nix-tree
    nurl
    nix-update
    # nix-prefetch
    # nix-template
    nix-output-monitor
    disko
    nixos-anywhere

    # Developing
    yq
    jql
    sqlite
    openssl
    discount # markdown
    efm-langserver # markdown lsp
    strace
    lurk # strace alternative

    # Compressor / Archiver
    p7zip
    unzip
    ouch
    # patool
    # atool
    cdrtools # mkisofs

    # FileManager
    f2
    sd
    choose
    ssh-to-age
    sops
    age
    # rage # age encrypt RIIR
    chafa # image viewer
    viu # image viewer
    gtrash
    eget
    croc
    dufs
    magic-wormhole-rs

    # System Monitor
    ctop # containers monitor
    iotop-c
    dool # py fork of dstat
    powertop
    psmisc # pstree
    procs
    erdtree
    ikill
    gdu
    duf
    dysk
    tokei # count code

    # Utils
    just
    igrep
    cht-sh
    tlrc # tldr
    # tealdeer # tldr
    # difftastic # too big
    kalker # calculator
    ydict
    typos
    shellcheck
    translate-shell
    # aspellDicts.en
    hunspellDicts.en_US
    # asciinema # record the terminal
    calcurse
    # zee
    wthrr # weather

    # Networking
    lsof
    dogdns
    # nali
    mtr
    nload
    # ipinfo # 62M
    elinks
    dnspeep
    nethogs
    bandwhich
    traceroute
    speedtest-cli
    proxychains-ng
    # airgeddon # wifi crack

    # Game & fun
    # curl parrot.live
    # fortune | cowsay -f tux | lolcat
    sl
    cowsay
    # xcowsay
    fortune
    # figlet
    # toilet
    clolcat
    cmatrix
    # lavat
    # cbonsai
    # pipes-rs
    # hollywood
    # snowmachine
    # oneko
    nyancat
    asciiquarium
  ];

  programs = {
    aria2 = {
      enable = true;
    };

    eza = {
      enable = true;
    };

    bat = {
      enable = true;
    };

    fd = {
      enable = true;
    };

    jq = {
      enable = true;
    };

    btop = {
      enable = true;
    };

    # btm
    bottom = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    htop = {
      enable = true;
    };

    # hh :history
    hstr = {
      enable = true;
    };

    fzf = {
      enable = true;
    };

    skim = {
      enable = true;
    };

    yazi = {
      enable = true;
    };

    # z: autojump directory
    zoxide = {
      enable = true;
    };

    # shell history
    # atuin login -u zendo
    # atuin sync -f
    atuin = {
      enable = true;
      flags = [
        "--disable-up-arrow"
        # "--disable-ctrl-r"
      ];
      # settings = {
      #   auto_sync = true;
      #   sync_frequency = "5m";
      #   sync_address = "https://api.atuin.sh";
      #   search_mode = "prefix";
      # };
    };

    nix-index = {
      enable = true;
    };

    nix-your-shell = {
      enable = true;
    };

    # echo "use flake" >> .envrc && direnv allow
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      enableBashIntegration = false;
    };

    zellij = {
      # enable = true;
    };

    micro = {
      enable = true;
      settings = {
        autosu = true;
        softwrap = true;
        hlsearch = true;
        saveundo = true;
        scrollbar = true;
        mkparents = true;
        diffgutter = true;
      };
    };
  };
}
