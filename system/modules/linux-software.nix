{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports =
  [
    # TODO: Add
    #inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent =
  # {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # TODO: Add back.
  # services.flatpak =
  # {
  #   enable = true;
  #   packages =
  #   [
  #     "app.drey.Blurble" # Wordle clone.
  #   ];
  # };

  # Locate service, updates every night (`updatedb`).
  services.locate =
  {
    enable = true;
    package = pkgs.mlocate; # alternative to GNU findutils.
  };
}
