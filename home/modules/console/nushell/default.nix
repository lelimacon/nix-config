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
