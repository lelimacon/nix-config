{
  pkgs-local,
  config,
  lib,
  ...
}:
{
  programs.nushell =
  {
    enable = true;
    # Config home: ~/Library/Application Support/nushell/
    configFile.source = ./config.nu;

    # Add env files for `home.sessionVariables`.
    # Those variables are written to hm-session-vars.sh but Nushell doesn't source the file.
    extraEnv = lib.concatStringsSep "\n" ([
      # Starship: use absolute path because PATH is not yet set up in env.nu.
      ''
        mkdir ~/.cache/starship
        ${pkgs-local.starship}/bin/starship init nu | save --force ~/.cache/starship/init.nu
      ''
    ] ++ lib.mapAttrsToList
      (name: value: "$env.${name} = ${builtins.toJSON (toString value)}")
      config.home.sessionVariables);

    extraConfig =
    ''
      # Starship.
      source ~/.cache/starship/init.nu
      # Set STARSHIP_CONFIG explicitly so any starship binary on PATH reads the wrapped config.
      $env.STARSHIP_CONFIG = "${pkgs-local.starship}/starship.toml"

      # Nushell does not source /etc/profile, so nix paths must be added explicitly.
      # Keep wrappers first so sudo resolves correctly on NixOS.
      $env.PATH = ($env.PATH | prepend [
        "/run/wrappers/bin"
        "/etc/profiles/per-user/${config.user.name}/bin"
        "/nix/var/nix/profiles/default/bin"
        "/run/current-system/sw/bin"
        "/usr/local/bin"
        "${config.user.homeDirectory}/.local/bin"
      ] | uniq)
    '';

    shellAliases =
    {
    };
  };

  # Carapace completion library.
  # https://github.com/carapace-sh/carapace
  programs.carapace =
  {
    enable = true;
    enableNushellIntegration = true;
  };
}
