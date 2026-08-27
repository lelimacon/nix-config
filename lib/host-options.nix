{
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
  path = value: description: lib.mkOption
  {
    type = lib.types.path;
    default = value;
    description = description;
  };
  # Defaults taken from the ff08-amd host, used as a fallback when no host
  # overrides them (e.g. this flake's own packages, built without a host).
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

    monoFont.family = str "MonaspiceAr Nerd Font" "Monospace font";
    monoFont.frozenFamily = str "Monaspace Argon Frozen" "Monospace font for apps without variants (e.g. IntelliJ).";
    monoFont.size = int 13 "Monospace font size";
  };
in
{
  options =
  {
    flake-src.path = path ../. "Path to this configuration's flake directory";
    flake-src.rev = str "-" "Configuration revision (Git commit hash)";

    host.system = str "x86_64-linux" "System architecture (x86_64-linux, aarch64-darwin)";
    host.name = str "default-host" "Host name";

    theme = theme-options;

    user.name = str "lelimacon" "User name";
    user.homeDirectory = str "/home/lelimacon" "Path to home directory";
  };
}
