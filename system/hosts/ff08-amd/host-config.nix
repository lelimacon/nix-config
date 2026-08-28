{
  imports =
  [
    ../../../lib/host-options.nix
  ];

  host.system = "x86_64-linux";
  host.name = "ff08-amd";

  user.name = "lelimacon";
  user.homeDirectory = "/home/lelimacon";

  currentThemeName = "red";
}
