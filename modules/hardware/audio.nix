{
  pkgs,
  ...
}:
{
  # Enable sound with pipewire.
  services.pulseaudio =
  {
    enable = false;

    # Enable extra codecs.
    # https://nixos.wiki/wiki/Bluetooth#Enabling_extra_codecs
    package = pkgs.pulseaudioFull;
  };

  security.rtkit.enable = true;

  services.pipewire =
  {
    enable = true;
    jack.enable = true;

    # ALSA and PulseAudio.
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
