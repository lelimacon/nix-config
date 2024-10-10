{
  pkgs,
  ...
}:

{
  imports =
  [
    #./desktop-gnome.nix
    ./desktop-hyprland.nix
    ./fonts.nix
    ./programs.nix
  ];

  nix.settings =
  {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # User account.
  # Set password with ‘passwd’.
  users.users.lelimacon = {
    isNormalUser = true;
    description = "lelimacon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs;
    [
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

  # Console keymap.
  console.keyMap = "fr";

  # Culture.
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings =
  {
    LANGUAGE = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    #LC_ALL = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
}
