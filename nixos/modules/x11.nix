{
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver =
  {
    enable = true;
    # Fix attempt at https://discourse.nixos.org/t/how-to-enable-login-screen-and-start-hyperland-after-login/37775
    #displayManager.sddm.enable = true;
    #displayManager.sddm.wayland.enable = true;

    # Keymap.
    exportConfiguration = true; # for `localectl`.
    xkb =
    {
      layout = "fr";
      variant = "";
    };
  };
}
