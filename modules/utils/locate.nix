{
  pkgs,
  ...
}:
{
  # Locate service, updates every night (`updatedb`).
  services.locate =
  {
    enable = true;
    package = pkgs.mlocate; # alternative to GNU findutils.
  };
}
