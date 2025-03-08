{ pkgs, ... }:
let
  # nurl https://github.com/yokoffing/Betterfox 133.0
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "135.0";
    hash = "sha256-5fD8ffAyIgQYJ0Z/bMEpqf17YghVQNaK+giZ1Tyk6/Q=";
  };
in
{
  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-bin;
    languagePacks = [ "zh-CN" ];
    profiles.default = {
      extraConfig = ''
        ${builtins.readFile "${betterfox}/user.js"}

        // PREF: restore Top Sites on New Tab page
        user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);

        // PREF: restore search engine suggestions
        user_pref("browser.search.suggest.enabled", true);

        // PREF: allow websites to ask you for your location
        user_pref("permissions.default.geo", 0);

        // PREF: allow websites to ask you to receive site notifications
        // user_pref("permissions.default.desktop-notification", 0);
      '';
      settings = {
        "browser.tabs.closeTabByDblclick" = true;
        "browser.tabs.closeWindowWithLastTab" = false; # Prevent closing Firefox when closing the last tab
        "browser.tabs.selectOwnerOnClose" = false; # Closing tab and return to the adjacent tab
        "browser.tabs.loadBookmarksInBackground" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.aboutwelcome.enabled" = false;
        "browser.aboutConfig.showWarning" = false;

        "gfx.webrender.all" = true; # enable GPU render
        "media.ffmpeg.vaapi.enabled" = true; # enable hw video acceleration
        # https://pandasauce.org/get-fonts-done/
        "gfx.text.subpixel-position.force-enabled" = true;
        "gfx.webrender.quality.force-subpixel-aa-where-possible" = true;
      };
      search.enable = false;
      search.engines = {
        Google.metaData.alias = "g";
        GitHub = {
          urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
          iconUpdateURL = "https://github.com/fluidicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "git" ];
        };
        MyNixOS = {
          urls = [ { template = "https://www.mynixos.com/search?q={searchTerms}"; } ];
          iconUpdateURL = "https://mynixos.com/favicon.ico";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [
            "nse"
            "mynixos"
          ];
        };
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "nix" ];
        };
        "Home Manager Options" = {
          urls = [
            {
              template = "https://home-manager-options.extranix.com/";
              params = [
                {
                  name = "release";
                  value = "master";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "hm" ];
        };
      };
    };
  };
}
