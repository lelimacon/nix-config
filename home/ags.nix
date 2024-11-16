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
    # Dev dependencies.
    gtk3
    bun
    dart-sass # scss.
    slurp

    # CLI tools.
    fd

    # APIs.
    brightnessctl
    bluez # for `bluetoothctl`

    # Programs.
    swww
    wl-clipboard
    wayshot # screenshot tool.
    swappy # snapshot editing app.
    wf-recorder # screen recorder.
    hyprpicker # color picker.
    pavucontrol
    networkmanager
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
