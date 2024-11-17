{
  ...
}:
{
  environment.sessionVariables =
  {
    # If your cursor becomes invisible.
    WLR_NO_HARDWARE_CURSORS = "1";

    # Tell Firefox to use Wayland.
    MOZ_ENABLE_WAYLAND = "1";

    # Hint Electron apps to use Wayland.
    NIXOS_OZONE_WL = "1";
  };

  hardware =
  {
    # Opengl.
    graphics.enable = true;

    # Most wayland compositors need this.
    nvidia.modesetting.enable = true;
  };
}
