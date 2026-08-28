{
  imports =
  [
    ../../../lib/host-options.nix
  ];

  host.system = "aarch64-darwin";
  host.name = "mox-air-m4";

  user.name = "mox";
  user.homeDirectory = "/Users/mox";

  currentThemeName = "pink";
}
