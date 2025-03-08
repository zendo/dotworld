{ config, ... }:
let
  linkHome = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${path}";
  linkFlake =
    path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nsworld/${path}";
in
{
  home.file = {
    ".proxychains/proxychains.conf".source = ../dotfiles/proxychains.conf;
    ".memo".source = linkHome "Documents/memo";
    ".emacs.d/all-emacs.org".source = linkFlake "dotfiles/org/all-emacs.org";
  };

  xdg.configFile = {
    "cava".source = ../dotfiles/cava;
    "wofi".source = ../dotfiles/wofi;
    "foot".source = ../dotfiles/foot;
    "kitty".source = ../dotfiles/kitty;
    "zellij".source = ../dotfiles/zellij;
    "swaylock".source = ../dotfiles/swaylock;
    "alacritty".source = ../dotfiles/alacritty;
    "radioboat".source = ../dotfiles/radioboat;
    "starship.toml".source = ../dotfiles/starship.toml;

    "doom".source = linkFlake "dotfiles/doom";
    "mpv".source = linkFlake "dotfiles/mpv";
    "mako".source = linkFlake "dotfiles/mako";
    "helix".source = linkFlake "dotfiles/helix";
    "waybar".source = linkFlake "dotfiles/waybar";
    "yt-dlp".source = linkFlake "dotfiles/yt-dlp";
    "ghostty".source = linkFlake "dotfiles/ghostty";
    "wezterm".source = linkFlake "dotfiles/wezterm";
    "niri".source = linkFlake "dotfiles/niri";
    "sway/config".source = linkFlake "dotfiles/sway/config";
    "hypr/hyprland.conf".source = linkFlake "dotfiles/hypr/hyprland.conf";
    "hypr/hyprlock.conf".source = linkFlake "dotfiles/hypr/hyprlock.conf";
  };

  xdg.dataFile = {
    "goodvibes".source = ../dotfiles/goodvibes;
    "color-schemes/Genshin.colors".source = ../dotfiles/misc/kde-color-Genshin.colors;
  };
}
