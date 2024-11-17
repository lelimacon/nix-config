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
      common =
      {
        default = [ "hyprland" ];
      };
      hyprland =
      {
        default = [ "gtk" "hyprland" ];
      };
    };
    extraPortals = with pkgs;
    [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };
}
