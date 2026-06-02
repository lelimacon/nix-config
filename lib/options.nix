{
  lib,
  ...
}:
let
  hexColor = value: description: lib.mkOption
  {
    type = lib.types.str;
    default = value;
    description = description;
  };

  my-theme-options =
  {
    #enable = lib.mkEnableOption "Custom system styling";
    colors =
    {
      primary = hexColor "#ff0000ff" "Accent color used across the system.";
      primary-dark = hexColor "#9d174d" "Primary darker accent";
      primary-light = hexColor "#fce7f3" "Primary lighter accent";
      primary-lighter = hexColor "#fdf2f8" "Primary more lighter accent";
      primary-fg = hexColor "#FFFBF1" "Foreground on primary";
      primary-fg-strong = hexColor "#fff" "Flashy foreground on primary";
      fg = hexColor "#1c1917" "Foreground color";
      fg-strong = hexColor "#000" "Strong foreground (more contrasty)";
      bg = hexColor "#FFFBF1" "Background color";
      bg-soft = hexColor "#FFFBF1" "Soft background (less contrasty)";
      bg-strong = hexColor "#fff" "Strong background (more contrasty)";
      border = hexColor "#1c1917" "Border color";
      border-soft = hexColor "#b6a8a8ff" "Soft border (less contrasty)";
      border-strong = hexColor "#1c1917" "Strong border (more contrasty)";
    };
  };

  vars-options =
  {
    system = lib.mkOption
    {
      type = lib.types.str;
      description = "The system architecture (e.g., aarch64-darwin).";
    };
    config.name = lib.mkOption { type = lib.types.str; };
    config.homeDirectory = lib.mkOption { type = lib.types.str; };
    user.name = lib.mkOption { type = lib.types.str; };
    user.homeDirectory = lib.mkOption { type = lib.types.str; };
    hostName = lib.mkOption { type = lib.types.str; };
    theme = my-theme-options;
  };
in
{
  options.my-theme = my-theme-options;
  options.vars = vars-options;
}
