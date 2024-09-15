{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./hardware-overrides.nix
    ./programs.nix
    ./home.nix
    ./desktop-gnome.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lelimacon = {
    isNormalUser = true;
    description = "lelimacon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  # Configure console keymap.
  console.keyMap = "fr";

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";
}
