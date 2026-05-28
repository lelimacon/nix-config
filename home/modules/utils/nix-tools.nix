# Graphviz
# DOT file viewer.
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    # CLI tools.
    nix-du # used with alias to generate graph.
    nix-index # find nixos packages.
    nix-inspect # not working?
    nix-tree

    nixd # Nix language server.
  ];

  home.shellAliases =
  {
    # TODO: Not found.
    "nix-graph" = "nix-du -s=500MB | dot -Tsvg > store.svg";
  };
}
