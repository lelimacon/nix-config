{
  pkgs,
  ...
}:
{
  # XDG portal (handles interactions between apps).
  xdg.portal =
  {
    enable = true;
    config =
    {
    };
    extraPortals =
    [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs;
  [
    xdg-utils # e.g. "open in browser"
  ];
}
