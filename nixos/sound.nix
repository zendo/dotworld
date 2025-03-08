{ config, ... }:
{
  # This allows PipeWire to run with realtime privileges (i.e: less cracks)
  security.rtkit.enable = config.services.pipewire.enable;

  # auto-enabled by `services.graphical-desktop`
  services.pipewire = {
    # alsa.support32Bit = true;
    # jack.enable = true;
  };
}
