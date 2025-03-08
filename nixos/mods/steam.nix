{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.mods.steam;
in
{
  options.mods.steam = {
    enable = lib.mkEnableOption ''
      my steam mode.
    '';
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud
      goverlay # mangohud config GUI
    ];

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
