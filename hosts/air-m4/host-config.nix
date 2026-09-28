{
  imports =
  [
    ../../lib/host-options.nix
  ];

  host.system = "aarch64-darwin";
  host.name = "air-m4";

  user.name = "nandroid";
  user.homeDirectory = "/Users/nandroid";

  currentThemeName = "pink";
}
