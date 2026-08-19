{
  lib,
  ...
}:
let
  str = description: lib.mkOption
  {
    type = lib.types.str;
    description = description;
  };
  path = description: lib.mkOption
  {
    type = lib.types.path;
    description = description;
  };
  hexColor = value: description: lib.mkOption
  {
    type = lib.types.str;
    default = value;
    description = description;
  };

  theme-options =
  {
    colors =
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
  };
in
{
  options =
  {
    flake-src.path = path "Path to this configuration's flake directory";
    flake-src.rev = str "Configuration revision (Git commit hash)";

    host.system = str "System architecture (x86_64-linux, aarch64-darwin)";
    host.name = str "Host name";

    theme = theme-options;

    user.name = str "User name";
    user.homeDirectory = str "Path to home directory";
  };
}
