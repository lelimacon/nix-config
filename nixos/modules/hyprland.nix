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
}
