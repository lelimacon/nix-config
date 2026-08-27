{
  imports =
  [
    ../../../lib/host-options.nix
  ];

  host.system = "x86_64-linux";
  host.name = "ff08-amd";

  user.name = "lelimacon";
  user.homeDirectory = "/home/lelimacon";

  theme =
  {
    # https://colorhunt.co/palette/fffbf1fff2d0ffb2b2e36a6a
    colors.primary = "#E36A6A";
    colors.primary-dark = "#755757";
    colors.primary-light = "#FFF2D0";
    colors.primary-lighter = "#FFFBF1";
    colors.primary-fg = "#FFFBF1";
    colors.primary-fg-strong = "#fff";
    colors.fg = "#3f1e1e";
    colors.fg-strong = "#000";
    colors.bg = "#FFFBF1";
    colors.bg-soft = "#FFFBF1";
    colors.bg-strong = "#fff";
    colors.border = "#654141ff";
    colors.border-soft = "#b6a8a8ff";
    colors.border-strong = "#3f1e1e";

    monoFont.family = "MonaspiceAr Nerd Font";
    monoFont.frozenFamily = "Monaspace Argon Frozen";
    monoFont.size = 13;
  };
}
