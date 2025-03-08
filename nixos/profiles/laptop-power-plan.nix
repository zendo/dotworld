{ lib, pkgs, ... }:
{
  services = {
    # https://wiki.debian.org/thermald
    thermald.enable = true;

    # Conflicts with auto-cpufreq
    power-profiles-daemon.enable = false;

    # https://github.com/AdnanHodzic/auto-cpufreq
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
    };
  };

  # Go into hibernate after specific suspend time
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=40min
  '';
}
