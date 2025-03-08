{
  pkgs,
  ...
}:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swayr
      autotiling-rs
    ];
  };
}
