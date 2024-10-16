{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  colors =
  {
    primary = "f42c8d";
    secondary = "7491af";
  };
in
{
  imports =
  [
    inputs.hyprland.homeManagerModules.default
  ];

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

  # Hyperland configuration.
  wayland.windowManager.hyprland =
  {
    enable = true;

    package = pkgs.hyprland;
    systemd.enable = true;

    settings =
    {
      "$mod" = "SUPER";

      # Default programs.
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "anyrun";

      monitor =
      [
        "eDP-1, preferred, auto, 1"
        "DP-2, preferred, auto-up, 1"
      ];

      input =
      {
        kb_layout = "fr, br"; # `localectl list-x11-keymap-layouts`.
        kb_variant = "azerty, nodeadkeys"; # `localectl list-x11-keymap-variants br`.
        kb_options = "grp:alt_shift_toggle";

        resolve_binds_by_sym = 1; # key bindings specific to current layout.

        sensitivity = 0; # -1.0 to 1.0.

        natural_scroll = false;

        touchpad =
        {
            natural_scroll = true;
            scroll_factor = 0.8;
        };

        follow_mouse = 2; # allow to scroll in unfocused windows.
      };

      # List devices: `hyprctl devices`.
      # https://github.com/hyprwm/Hyprland/discussions/4768
      device =
      [
          # Mouse: Pulsar X2 Mini.
          {
            name = "compx-x2-mini-wireless";
            sensitivity = -0.6;
          }
          # Touchpad: Surface Laptop 3.
          {
              name = "microsoft-surface-045e:09af-touchpad";
              sensitivity = 0.4;
          }
          # Keyboard: Surface Laptop 3.
          {
              name = "microsoft-surface-045e:09ae-keyboard";
              kb_layout = "fr";
              kb_variant = "azerty";
          }
          # Keyboard: Geonix48.
          {
              name = "sporewoh-minipeg48";
              kb_layout = "br";
              kb_variant = "nodeadkeys";
          }
      ];

      gestures =
      {
        workspace_swipe = false;
      };

      # Startup apps.
      exec-once =
      [
        #"swww init & swww img ~/Pictures/pixel-black.png" # wallpaper.
        "nm-applet --indicator" # networkmanagerapplet.
        "waybar" # top bar.
        "dunst" # notifications.
        "telegram-desktop -startintray" # Telegram messenger minimized.
      ];

      env = lib.mapAttrsToList (name: value: "${name},${toString value}")
      {
        XCURSOR_SIZE = 24;
        HYPRCURSOR_SIZE = 24;
      };

      general =
      {
        border_size = 3;
        resize_on_border = false; # Resize windows by dragging borders and gaps.

        gaps_in = 3;
        gaps_out = 6;

        # Window borders.
        "col.active_border" = "rgb(${colors.primary})";
        "col.inactive_border" = "rgb(${colors.secondary})";

        # Tiling arrangement.
        layout = "dwindle";
      };

      # Tabbed groups.
      group =
      {
          # Borders.
          "col.border_active" = "rgb(${colors.primary})";
          "col.border_inactive" = "rgb(${colors.secondary})";
      };

      decoration =
      {
        # Border-radius.
        rounding = 0;

        # Transparency of focused and unfocused windows.
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        # Window box-shadow.
        drop_shadow = false;

        blur =
        {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      misc =
      {
        force_default_wallpaper = 0; # anime mascot wallpapers.
        disable_hyprland_logo = true; # logo / anime girl background.
        disable_splash_rendering = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      animations =
      {
        enabled = true;
      };

      # Mouse bindings.
      bindm =
      [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Keyboard bindings.
      bind =
      [
        "$mod, M, exit," # restart hyprland.

        # Apps.
        "$mod, T, exec, $terminal"
        "$mod, space, exec, $menu"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, ~/.config/waybar/launch.sh" # restart Waybar.

        # Windows.
        "$mod, Q, killactive,"
        "$mod, F, togglefloating,"
        "$mod, G, togglegroup,"

        # Switch workspaces.
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"

        # Move active window to a workspace.
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
      ];

      windowrulev2 =
      [
        "float, class:.*" # open all windows as floating.
        "suppressevent maximize, class:.*" # ignore maximize event.
      ];
    };

    # https://wiki.hyprland.org/Configuring/XWayland/
    xwayland.enable = true;
  };

  # Waybar.
  home.file.".config/waybar/config.jsonc".source = ./waybar-config.jsonc;
  home.file.".config/waybar/style.css".source = ./waybar-style.css;
  home.file.".config/waybar/launch.sh".source = ./scripts/waybar-launch.sh;
  home.file.".config/waybar/print-keyboard-layout.sh".source = ./scripts/print-keyboard-layout.sh;
  home.file.".config/waybar/switch-keyboard-layout.sh".source = ./scripts/switch-keyboard-layout.sh;
}
