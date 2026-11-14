{
  config,
  lib,
  ...
}:
let
  str = value: description: lib.mkOption
  {
    type = lib.types.str;
    default = value;
    description = description;
  };
  int = value: description: lib.mkOption
  {
    type = lib.types.int;
    default = value;
    description = description;
  };
  float = value: description: lib.mkOption
  {
    type = lib.types.float;
    default = value;
    description = description;
  };
  path = value: description: lib.mkOption
  {
    type = lib.types.path;
    default = value;
    description = description;
  };
  hexColor = value: description: lib.mkOption
  {
    type = lib.types.str;
    default = value;
    description = description;
  };

  colorsOptions =
  {
    primary = hexColor "#ff0000ff" "Accent color used across the system";
    primary-dark = hexColor "#900000ff" "Primary darker accent";
    primary-light = hexColor "#ff8888ff" "Primary lighter accent";
    primary-lighter = hexColor "#ffccccff" "Primary more lighter accent";
    primary-fg = hexColor "#ffeeeeff" "Foreground on primary";
    primary-fg-strong = hexColor "#ffffffff" "Flashy foreground on primary";
    fg = hexColor "#444444ff" "Foreground color";
    fg-strong = hexColor "#000000ff" "Strong foreground (more contrasty)";
    bg = hexColor "#eeeeeeff" "Background color";
    bg-soft = hexColor "#ccccccff" "Soft background (less contrasty)";
    bg-strong = hexColor "#ffffffff" "Strong background (more contrasty)";
    border = hexColor "#555555ff" "Border color";
    border-soft = hexColor "#aaaaaaff" "Soft border (less contrasty)";
    border-strong = hexColor "#444444ff" "Strong border (more contrasty)";
  };

  windowThemeOptions = lib.types.submodule
  {
    radius = float 5.0 "Border radius";
    blur = float 0.0 "Background blur amount";
    opacity = float 1.0 "Background opacity, 0 for transparent, 1 for opaque";
    borderOpacity = float 1.0 "Border opacity, 0 for transparent, 1 for opaque";
    borderWidth = float 2.0 "Border width";
  };

  themeOptions =
  {
    name = str "default" "Theme name";

    monoFont.family = str "MonaspiceAr Nerd Font" "Monospace font";
    monoFont.frozenFamily = str "Monaspace Argon Frozen" "Monospace font for apps without variants (e.g. IntelliJ).";
    monoFont.size = int 13 "Monospace font size";

    colors = colorsOptions;
    window = lib.mkOption
    {
      type = { options = windowThemeOptions; };
      default = { };
      description = "Window theme";
    };
    dialog = lib.mkOption
    {
      type = { options = windowThemeOptions; };
      default = { };
      description = "Dialog theme (popovers, modals, floating windows)";
    };
  };
in
{
  options =
  {
    flake-src.path = path ../. "Path to this configuration's flake directory";
    flake-src.rev = str "-" "Configuration revision (Git commit hash)";

    host.system = str "x86_64-linux" "System architecture (x86_64-linux, aarch64-darwin)";
    host.name = str "default-host" "Host name";

    theme = themeOptions;

    themes = lib.mkOption
    {
      type = lib.types.listOf (lib.types.submodule { options = themeOptions; });
      default =
      [
        {
          # Leaves all default options.
          name = "default";
        }
        {
          name = "red";
          # https://colorhunt.co/palette/fffbf1fff2d0ffb2b2e36a6a
          colors =
          {
            primary = "#E36A6A";
            primary-dark = "#755757";
            primary-light = "#FFF2D0";
            primary-lighter = "#FFFBF1";
            primary-fg = "#FFFBF1";
            primary-fg-strong = "#fff";
            fg = "#3f1e1e";
            fg-strong = "#000";
            bg = "#FFFBF1";
            bg-soft = "#FFFBF1";
            bg-strong = "#fff";
            border = "#654141ff";
            border-soft = "#b6a8a8ff";
            border-strong = "#3f1e1e";
          };
        }
        {
          name = "pink";
          # https://tailwindcss.com/docs/colors
          colors =
          {
            primary = "#db2777"; # Pink 600.
            primary-dark = "#9d174d"; # Pink 800.
            primary-light = "#fce7f3"; # Pink 100.
            primary-lighter = "#fdf2f8"; # Pink 50.
            primary-fg = "#FFFBF1";
            primary-fg-strong = "#fff";
            fg = "#1c1917"; # Stone 900.
            fg-strong = "#000"; # Stone 900.
            bg = "#FFFBF1";
            bg-soft = "#FFFBF1";
            bg-strong = "#fff";
            border = "#1c1917"; # Stone 900.
            border-soft = "#b6a8a8ff";
            border-strong = "#1c1917"; # Stone 900.
          };
        }
      ];
      description = "List of available themes";
    };

    currentThemeName = str "default" "Name of the active theme (see `themes`)";

    user.name = str "lelimacon" "User name";
    user.homeDirectory = str "/home/lelimacon" "Path to home directory";
  };

  config.theme = lib.findFirst
    (t: t.name == config.currentThemeName)
    (lib.head config.themes)
    config.themes;
}
