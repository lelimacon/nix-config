{
  config,
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
    hello
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

  # Export home configuration to JSON to be used by AGS.
  home.file.".config/ags.config.json".text = builtins.toJSON config.desktop;
}
