{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  services.xserver = {
    # for X11
    enable = true;
    libinput.enable = true;
    xkbOptions = "ctrl:swapcaps";
    # use greetd
    displayManager.lightdm.enable = false;
    displayManager.lightdm.greeters.gtk.extraConfig = ''
      xft-dpi=196
    '';
  };

  services.greetd.enable = true;

  # if use hm module
  security.pam.services.swaylock = {};

  programs = {
    light.enable = true;
    # gtklock.enable = true;
    evince.enable = true;
    file-roller.enable = true;
    # if use hm module
    dconf.enable = true;
    xwayland.enable = true;
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
    fcitx5.enableRimeData = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      # fcitx5-chinese-addons
    ];
  };

  home-manager.users.${username} = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      # Sway apps
      swappy # screenshot annotation editor
      swaybg # wallpaper tool
      swayidle
      swaylock-effects
      swaynotificationcenter
      # mako  # , notify-send "sth"
      libnotify # notify-send
      wlogout

      eww-wayland

      # wlr apps
      wofi # quick run
      wofi-emoji
      wl-clipboard
      wf-recorder
      cliphist
      networkmanagerapplet
      bluetuith
      blueberry
      wlopm
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
      grim # grab image
      slurp # select region
      wayshot
      pavucontrol
      playerctl # media player control
      pamixer # volume control

      # Needs when use other DM
      gnome.adwaita-icon-theme
      gnome.gnome-themes-extra

      gnome.nautilus
      gnome-text-editor
      gnome.gnome-power-manager
      # gnome.eog
      # gthumb
      libsForQt5.gwenview
      gparted
    ];

    services = {
      udiskie.enable = true;
      gnome-keyring.enable = true;
      # playerctld.enable = true;
      # easyeffects.enable = true;

      wlsunset = {
        enable = true;
        # gama = "2.0";
        latitude = "22.2783";
        longitude = "114.1747";
      };

      swayidle = {
        enable = false;
        systemdTarget = "graphical-session.target";
        events = [
          {
            event = "before-sleep";
            command = "${lib.getExe pkgs.swaylock-effects} -f";
          }
          {
            event = "lock";
            command = "${lib.getExe pkgs.swaylock-effects} -f";
          }
        ];
        timeouts = [
          {
            timeout = 200;
            command = "${lib.getExe pkgs.brightnessctl} -s s 10%";
            resumeCommand = "${lib.getExe pkgs.brightnessctl} -r";
          }
          {
            timeout = 230;
            command = ''${lib.getExe pkgs.libnotify} -t 30000 -- "Screen will lock in 60 seconds"'';
          }
          {
            timeout = 300;
            command = "${lib.getExe pkgs.swaylock-effects} -f";
          }
          {
            timeout = 360;
            command = ''${lib.getExe pkgs.wlopm} --toggle \*'';
            resumeCommand = ''${lib.getExe pkgs.wlopm} --toggle \* && brightnessctl -r'';
          }
        ];
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
