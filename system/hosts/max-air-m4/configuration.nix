{
  self,
  ...
}:
{
  imports =
  [
    ../../../lib/options.nix
  ];

  config-src.path = ./.;
  config-src.rev = self.rev or self.dirtyRev or null;

  host.system = "aarch64-darwin";
  host.name = "max-air-m4";

  user.name = "max";
  user.homeDirectory = "/Users/max";

  theme =
  {
    # Theme colors.
    # https://tailwindcss.com/docs/colors
    colors.primary = "#db2777"; # Pink 600.
    colors.primary-dark = "#9d174d"; # Pink 800.
    colors.primary-light = "#fce7f3"; # Pink 100.
    colors.primary-lighter = "#fdf2f8"; # Pink 50.
    colors.primary-fg = "#FFFBF1";
    colors.primary-fg-strong = "#fff";
    colors.fg = "#1c1917"; # Stone 900.
    colors.fg-strong = "#000"; # Stone 900.
    colors.bg = "#FFFBF1";
    colors.bg-soft = "#FFFBF1";
    colors.bg-strong = "#fff";
    colors.border = "#1c1917"; # Stone 900.
    colors.border-soft = "#b6a8a8ff";
    colors.border-strong = "#1c1917"; # Stone 900.
  };
}
