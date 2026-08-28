{
  config,
  ...
}:
{
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking =
  {
    hostName = config.host.name;
    networkmanager.enable = true;
    nameservers =
    [
      # Cloudflare.
      "1.1.1.1"
      "1.0.0.1"
      # Google.
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # networking.wireless.enable = true; # wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
