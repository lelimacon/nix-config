# Nix tools.
{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # CLI tools.
    nix-du # used with alias to generate graph.
    nix-index # find nixos packages.
    nix-inspect # not working?
    nix-tree
  ];

  environment.shellAliases =
  {
    # TODO: Not found.
    # Depends on graphviz.
    "nix-graph" = "nix-du -s=500MB | dot -Tsvg > store.svg";
  };
}
