{ lib, ... }:
{
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = lib.hm.gvariant.mkUint32 3000;
    };

    "org/gnome/desktop/interface" = {
      clock-show-date = false;
      cursor-theme = "Adwaita";
      icon-theme = "Adwaita";
      # font render
      font-hinting = "full";
      font-antialiasing = "rgba";
    };

    "org/gnome/mutter" = {
      edge-tiling = true; # 多任务 - 激活屏幕边缘
      dynamic-workspaces = true; # 多任务 - 动态工作空间
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 600; # 电源 - 10分钟熄屏
    };

    # "org/gnome/settings-daemon/plugins/power" = {
    #   sleep-inactive-ac-type = "nothing"; # 电源 - 节电 - 自动挂起（插入电源时关闭）
    # };

    ###############################################
    ##  Extensions
    ###############################################
    "org/gnome/shell" = {
      enabled-extensions = [
        "app-hider@lynith.dev"
        "dash-to-dock@micxgx.gmail.com"
        "clipboard-history@alexsaveau.dev"
        # "gradienttopbar@pshow.org"
        "nightthemeswitcher@romainvigier.fr"
        "caffeine@patapon.info"
        "appindicatorsupport@rgcjonas.gmail.com"
        "runcat@kolesnikov.se"
        "kimpanel@kde.org"
        # "gsconnect@andyholmes.github.io"
      ];
      favorite-apps = [
        # "foot.desktop"
        "kitty.desktop"
        # "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
        # "code.desktop"
        "emacs.desktop"
        "firefox.desktop"
        # "google-chrome.desktop"
        "org.telegram.desktop.desktop"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      custom-theme-shrink = true;
      apply-custom-theme = true;
      hot-keys = false;
      show-trash = false;
      click-action = "focus-minimize-or-previews";
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = false;
    };

    "org/gnome/shell/extensions/gnome-clipboard" = {
      history-size = lib.hm.gvariant.mkUint32 800;
    };

    ###############################################
    ##  Keybindings
    ###############################################
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "ctrl:swapcaps"
      ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      close = [ "<Super>q" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      move-to-workspace-1 = [ "<Alt>1" ];
      move-to-workspace-2 = [ "<Alt>2" ];
      move-to-workspace-3 = [ "<Alt>3" ];
      move-to-workspace-4 = [ "<Alt>4" ];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "emacs";
      name = "open-editor";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>f";
      command = "nautilus";
      name = "open-file-browser";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Super>w";
      command = "firefox";
      name = "open-web-browser";
    };
  };
}
