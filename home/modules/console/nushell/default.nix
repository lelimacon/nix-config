{
  pkgs,
  vars,
  ...
}:
let
  nuLoadFileIfExists = path: "if ('${path}' | path exists) { source '${path}' }";
in
{
  programs.nushell =
  {
    enable = true;
    # Config home: ~/Library/Application Support/nushell/
    configFile.source = ./config.nu;
    extraConfig =
      ''
        #$env.SHELL = "${pkgs.bash}"
        $env.STORE_ROOT = "${toString ../../../..}"

        # Nushell does not source /etc/profile, so nix paths must be added explicitly.
        $env.PATH = ($env.PATH | prepend [
          "/etc/profiles/per-user/${vars.user.name}/bin"
          "/nix/var/nix/profiles/default/bin"
          "/run/current-system/sw/bin"
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
