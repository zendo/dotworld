{
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
  };

  programs.hyprlock.enable = true;

  # auto-enabled by hyprlock
  # services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    # hyprpaper # wallpaper
    hyprpicker
  ];
}
