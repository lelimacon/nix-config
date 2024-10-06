{ config, pkgs, inputs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Fix attempt with https://discourse.nixos.org/t/how-to-enable-login-screen-and-start-hyperland-after-login/37775
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11.
  services.xserver.exportConfiguration = true; # enable `localectl`.
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Mount drives automatically.
  services.udisks2.enable = true;

  # Add user to group input for keyboard state access.
  users.groups.input.members = ["lelimacon"];

  programs.hyprland = {
    enable = true;

    # Enable X applications.
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible.
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wayland.
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # Opengl.
    opengl.enable = true;

    # Most wayland compositors need this.
    nvidia.modesetting.enable = true;
  };

  # XDG portal (handles interactions between apps).
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [
    # Apps.
    kitty # terminal emulator.
    libnotify dunst # notifications.
    anyrun walker # app launchers.
    cinnamon.nemo # file explorer.
    wlogout # full-screen logout menu.

    # Daemons.
    swww # wallpaper daemon.

    # Plugins.
    ags # widget system.
    waybar
    networkmanagerapplet # tray applet for managing networks.
    udiskie # drives applet.
  ];
}
