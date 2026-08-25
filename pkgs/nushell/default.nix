{
  pkgs,
  wrappers,
  starship,
  ...
}:
let
  emptyNu = pkgs.writeText "empty.nu" "";
in
wrappers.wrappers.nushell.wrap
{
  inherit pkgs;

  "env.nu".content =
  ''
    mkdir ~/.cache/starship
    ${starship}/bin/starship init nu | save --force ~/.cache/starship/init.nu
    $env.STORE_ROOT = "${toString ../..}"
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

      # Load private config if any.
      source (
          if (($nu.home-dir | path join ".config/private.config.nu") | path expand | path exists) {
              $nu.home-dir | path join ".config/private.config.nu"
          }
          else { "${emptyNu}" }
      )

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
