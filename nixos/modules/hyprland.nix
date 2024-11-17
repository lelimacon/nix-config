{
  pkgs,
  ...
}:
{
  # Enable hyprland compositor.
  programs.hyprland =
  {
    enable = true;

    # Enable X applications.
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
