{
  inputs,
  pkgs,
  ...
}:
{
  imports =
  [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs;
  [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    #inputs.matugen.packages.${system}.default
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
  ];

  programs.ags =
  {
    enable = true;
    configDir = ../ags;
    extraPackages = with pkgs;
    [
      accountsservice
    ];
  };

  # Manually create the link.
  home.file.".test".text =
  ''
    hi @{programs.ags}
  '';
}
