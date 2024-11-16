{
  config,
  pkgs,
  ...
}:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable touchpad support.
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio =
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

  # Bluetooth.
  hardware.bluetooth.enable = true;
  # Fix for Bluez.
  # https://github.com/NixOS/nixpkgs/issues/170573
  systemd.services."bluetooth".serviceConfig =
  {
    StateDirectory = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Network.
  networking.hostName = "surfaceLaptop3";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Virtualization.
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings =
  {
    userland-proxy = false;
    #experimental = true;
    #metrics-addr = "0.0.0.0:9323";
    #ipv6 = true;
    #fixed-cidr-v6 = "fd00::/80";
  };


  # Systemd login manager.
  services.logind.extraConfig =
  ''
    HandlePowerKey=poweroff
    HandlePowerKeyLongPress=ignore
    HandleRebootKey=reboot
    HandleRebootKeyLongPress=poweroff
    HandleSuspendKey=suspend
    HandleSuspendKeyLongPress=hibernate
    HandleHibernateKey=hibernate
    HandleHibernateKeyLongPress=ignore
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
    LidSwitchIgnoreInhibited=no
  '';

  services.logind.lidSwitch = "ignore";
}
