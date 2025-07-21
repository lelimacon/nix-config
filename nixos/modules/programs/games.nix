{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports =
  [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  environment.systemPackages = with pkgs;
  [
    xmoto
  ];

  programs.steam =
  {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.flatpak =
  {
    enable = true;
    packages =
    [
      "app.drey.Blurble" # Wordle clone.
    ];
  };
}
