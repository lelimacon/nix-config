# yabai, a tiling window manager for MacOS
# https://github.com/asmvik/yabai
{
  pkgs,
  ...
}:
let
  # SketchyBar.
  top-bar.height = 12;
in
{
  services.yabai =
  {
    enable = true;
    enableScriptingAddition = true;

    # https://github.com/asmvik/yabai/blob/master/doc/yabai.asciidoc
    config =
    {
      # Float windows by default.
      layout = "float";
      #layout = "bsp";
      #window_placement = "second_child";

      # padding set to 6px
      top_padding = 6;
      bottom_padding = 6;
      left_padding = 6;
      right_padding = 6;
      window_gap = 6;

      # Window border configuration not working.
      #window_border_radius = 0;
      #window_border = "on";
      #window_border_width = 4;

      focus_follows_mouse = "off";
      #mouse_modifier = "alt";
      mouse_modifier = "ctrl";
      mouse_action1 = "move";
      mouser_action2 = "resize";
      mouse_drop_action = "swap";

      window_topmost = "off";
      window_shadow = "off";

      # Opacity.
      #window_opacity = "on";
      #window_animation_duration = 0.15;
      #window_opacity_duration = 0.25;
      #normal_window_opacity = 0.98;
      #active_window_opacity = 1.0;

      # Tiling configuration.
      auto_balance = "off";
      split_ratio = 0.5;

      # Top bar.
      #menubar_opacity = 0.0; # hide MacOS top bar.
      external_bar = "all:${toString(top-bar.height)}:2";
    };

    extraConfig =
    ''
      # Notify sketchybar when space changes
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_title_changed action="sketchybar --trigger title_change"

      # Rules for specific apps
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="KeePassXC" app="^KeePassXC$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      yabai -m rule --add label="mpv" app="^mpv$" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
    '';
  };

  # Use skhd for keyboard shortcuts.
  # https://github.com/amsynist/zero-darwin/blob/01c0be900b68fc9b7498ccb0b13b4719a0648d3f/modules/darwin/services/skhd.nix
  services.skhd =
  {
    enable = true;
    package = pkgs.skhd;

    skhdConfig =
    ''
      # Toggle window float and sticky terminal.
      shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2  # Toggle float with grid
      alt - p : yabai -m window --toggle sticky --grid 20:20:15:12:10:10   # Toggle sticky terminal
    '';
  };
}
