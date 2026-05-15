{
  pkgs,
  ...
}:
{
  # Jankyborders for window borders.
  # https://mynixos.com/nix-darwin/options/services.jankyborders
  services.jankyborders =
  {
    enable = false;
    ax_focus = true;

    order = "above"; # draw border on top of window.

    style = "round";
    width = 8.0;
    active_color = "0xffffffff";
    inactive_color = "0xfff9a8d4";
  };
}
