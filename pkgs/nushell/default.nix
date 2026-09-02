{
  pkgs,
  wrappers,
  starship,
  ...
}:
let
  configDir = "~/.config/Nushell-nix-wrapper";
  privateConfigPath = "${configDir}/private.config.nu";
in
wrappers.wrappers.nushell.wrap
{
  inherit pkgs;

  "env.nu".content =
  ''
    $env.STORE_ROOT = "${toString ../..}"

    # Starship.
    mkdir ~/.cache/starship
    ${starship}/bin/starship init nu | save --force ~/.cache/starship/init.nu

    # Create the private config if it doesn't exist yet, since `source` in
    # config.nu resolves its path at parse time, before any of config.nu's
    # own statements have run.
    if not ("${privateConfigPath}" | path expand | path exists) {
        mkdir ("${privateConfigPath}" | path expand | path dirname)
        touch ("${privateConfigPath}" | path expand)
    }
  '';

  "config.nu".content =
    (builtins.readFile ./config.nu)
    + ''
      # Shell aliases referencing Nix store paths.
      alias dev         = develop ${toString ../..}
      alias dev-builder = nix develop path:${toString ../../shells/gtk}    --command gnome-builder
      alias dev-rider   = nix develop path:${toString ../../shells/dotnet} --command rider
      alias dev-rover   = nix develop path:${toString ../../shells/rust}   --command rust-rover
      alias dev-unity   = nix develop path:${toString ../../shells/dotnet} --command unityhub
      alias nix-dirt    = dirt --dir ~/.config --verbosity files
      alias what        = bash ${toString ../../ext/scripts/what.sh}

      # Load private config (env.nu creates it if missing).
      source "${privateConfigPath}"

      # Starship.
      source ~/.cache/starship/init.nu
      $env.STARSHIP_CONFIG = "${starship}/starship.toml"

      # Nushell does not source /etc/profile, so nix paths must be added explicitly.
      # Keep wrappers first so sudo resolves correctly on NixOS.
      $env.PATH = ($env.PATH | prepend [
          "/run/wrappers/bin"
          $"/etc/profiles/per-user/($env.USER)/bin"
          "/nix/var/nix/profiles/default/bin"
          "/run/current-system/sw/bin"
          "/usr/local/bin"
          $"($env.HOME)/.local/bin"
      ] | uniq)
    '';
}
