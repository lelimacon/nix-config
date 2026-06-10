{
  pkgs,
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
    extraEnv = lib.concatStringsSep "\n" (lib.mapAttrsToList
      (name: value: "$env.${name} = ${builtins.toJSON (toString value)}")
      config.home.sessionVariables);

    extraConfig =
      ''
        #$env.SHELL = "${pkgs.bash}"
        $env.STORE_ROOT = "${toString ../../../..}"

        # Nushell does not source /etc/profile, so nix paths must be added explicitly.
        $env.PATH = ($env.PATH | prepend [
          "/etc/profiles/per-user/${config.user.name}/bin"
          "/nix/var/nix/profiles/default/bin"
          "/run/current-system/sw/bin"
          "/usr/local/bin"
          "${config.user.homeDirectory}/.local/bin"
        ])
      '';

    shellAliases =
    {
    };
  };

  programs.carapace =
  {
    enable = true;
    enableNushellIntegration = true;
  };
}
