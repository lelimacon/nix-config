{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Gnome extensions.
  # https://extensions.gnome.org/
  environment.systemPackages = with pkgs; [
    pkgs.gnome3.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
  ];

  # Gnome settings.
  # TODO
  #"org/gnome/desktop/wm/preferences".button-layout = "minimize,maximize,close";
  #"org/gnome/desktop/wm/preferences" = {
  #  button-layout = "minimize,maximize,close";
  #};
}
