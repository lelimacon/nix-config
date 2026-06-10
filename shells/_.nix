# Index of all dev shells.
{
  pkgs,
  ...
}:
let
  beam-shell = import ./beam.nix { inherit pkgs; };
  dotnet-shell = import ./dotnet.nix { inherit pkgs; };
  web-shell = import ./web.nix { inherit pkgs; };
in
{
  beam = beam-shell;
  dotnet = dotnet-shell;
  web = web-shell;

  # Combined shells.
  beam-web = pkgs.mkShell
  {
    # TODO: Find description field.
    #description = "Beam + Web";
    inputsFrom = [ beam-shell web-shell ];
  };
}
