{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # Development.
    # https://nixos.wiki/wiki/FAQ/I_installed_a_library_but_my_compiler_is_not_finding_it._Why%3F
    icon-library # icon browser.
    #gnome-builder # IDE.
  ];
}
