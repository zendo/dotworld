{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    # ../overlays/services/gtklock.nix
  ];

  services.xserver = {
    # for X11
    enable = true;
    libinput.enable = true;
    xkbOptions = "ctrl:swapcaps";
    # use greetd
    displayManager.lightdm.enable = false;
  };

  services.greetd.enable = true;

  # Needs when using wm@hm
  security.pam.services.swaylock = {};
  programs.dconf.enable = true;
  programs.xwayland.enable = true;

  programs = {
    light.enable = true;
    # gtklock.enable = true;
    evince.enable = true;
    file-roller.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services = {
    gvfs.enable = true;
    upower.enable = true;
    blueman.enable = true;
    geoclue2.enable = true;
  };

  environment.pathsToLink = [
    "/share/zsh" # for zsh completion with hm
  ];

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    # GDK_BACKEND = "wayland";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.enableRimeData= true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-breeze
      rime-easy-en
      rime-aurora-pinyin
      # fcitx5-chinese-addons
    ];
  };

  home-manager.users.${username} = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      ../overlays/services/wob.nix
      ../overlays/services/polkit.nix
    ];

    home.packages = with pkgs; [
      swappy # screenshot annotation editor
      swaybg # wallpaper tool
      swayidle
      swaylock-effects
      swaynotificationcenter
      # mako  # , notify-send "sth"
      libnotify # notify-send
      wlogout

      # hyprpicker

      wofi # quick run
      wofi-emoji
      wl-clipboard
      wf-recorder
      cliphist
      networkmanagerapplet
      bluetuith
      blueberry
      wlopm
      # wob
      wev # wayland event view
      wvkbd # on-screen keyboard
      # waypipe # proxy ?
      # wtype # xdotool

      # Display
      brightnessctl # same like light
      wlsunset # nightlight
      wl-gammactl
      wdisplays
      wlr-randr
      kanshi # autorandr

      # Media
      # grim # grab image
      # slurp # select region
      shotman
      pavucontrol
      playerctl # media player control
      pamixer # volume control

      # Needs when use other DM
      gnome.adwaita-icon-theme
      gnome.gnome-themes-extra
      gnome.dconf-editor
      gnome.gnome-tweaks

      xfce.mousepad
      nomacs
      # gnome.gnome-power-manager
      # gnome.gnome-characters
      # gnome.eog
      # gthumb
      # libsForQt5.gwenview
      gparted
    ];

    services = {
      udiskie.enable = true;
      gnome-keyring.enable = true;
      # playerctld.enable = true;
      wob.enable = true;
      polkit.enable = true;

      wlsunset = {
        enable = true;
        # gama = "2.0";
        latitude = "22.2783";
        longitude = "114.1747";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gnome";
      style.package = pkgs.adwaita-qt;
      style.name = "adwaita";
    };

    # Fix tiny cursor
    home.pointerCursor = {
      name = "Vanilla-DMZ-AA";
      package = pkgs.vanilla-dmz;
      size = 128;
      # name = "Bibata-Modern-Classic";
      # package = pkgs.bibata-cursors;
      # size = 128;
    };
  };
}
