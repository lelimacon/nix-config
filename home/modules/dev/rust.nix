{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    # https://github.com/nixos/nixpkgs/issues/426815
    (pkgs-unstable.jetbrains.rust-rover.override {
      jdk = pkgs.openjdk21;
    }) # Rust IDE.
  ];
}
