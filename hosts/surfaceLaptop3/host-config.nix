{
  imports =
  [
    ../../lib/host-options.nix
  ];

  host.system = "x86_64-linux";
  host.name = "surfaceLaptop3";

  user.name = "lelimacon";
  user.homeDirectory = "/home/lelimacon";

  currentThemeName = "red";
}
