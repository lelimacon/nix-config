{
  pkgs,
  ...
}:
let
  mkOption = pkgs.lib.options.mkOption;
  types = pkgs.lib.types;

  emphasisColor = "#f42c8d";
  actionColor = "#7491af";

  windowThemeOptions = types.submodule
  ({
    options =
    {
      "radius" = mkOption
      {
        type = types.float;
        default = 5.0;
        description = "Border radius.";
      };
      "blur" = mkOption
      {
        type = types.float;
        default = 0.0;
        description = "Background blur amount.";
      };
      "opacity" = mkOption
      {
        type = types.float;
        default = 1.0;
        description = "Background opacity, 0 for transparent, 1 for opaque.";
      };
      "borderOpacity" = mkOption
      {
        type = types.float;
        default = 1.0;
        description = "Border opacity, 0 for transparent, 1 for opaque.";
      };
      "borderWidth" = mkOption
      {
        type = types.float;
        default = 2.0;
        description = "Border width.";
      };
      "activeBorderColor" = mkOption
      {
        type = types.str;
        default = emphasisColor;
        description = "Active border color.";
      };
      "inactiveBorderColor" = mkOption
      {
        type = types.str;
        default = actionColor;
        description = "Inactive border color.";
      };
    };
  });

  themeOptions = types.submodule
  ({
    options =
    {
      "name" = mkOption
      {
        type = types.str;
        default = "default";
        description = "Theme name.";
      };
      "bg" = mkOption
      {
        type = types.str;
        default = "#000000";
        description = "Background color.";
      };
      "fg" = mkOption
      {
        type = types.str;
        default = "#ffffff";
        description = "Foreground color.";
      };
      "emphasisColor" = mkOption
      {
        type = types.str;
        default = emphasisColor;
        description = "Emphasis color.";
      };
      "actionColor" = mkOption
      {
        type = types.str;
        default = actionColor;
        description = "Action color.";
      };
      "errorColor" = mkOption
      {
        type = types.str;
        default = "#ee1111";
        description = "Error color.";
      };
      "warningColor" = mkOption
      {
        type = types.str;
        default = "#11ee11";
        description = "Warning color.";
      };
      "infoColor" = mkOption
      {
        type = types.str;
        default = "#1111ee";
        description = "Info color.";
      };
      "transitionMs" = mkOption
      {
        type = types.int;
        default = 2000;
        description = "Transition duration (ms).";
      };
      "window" = mkOption
      {
        type = windowThemeOptions;
        default = {};
        description = "Window theme.";
      };
      "dialog" = mkOption
      {
        type = windowThemeOptions;
        default = {};
        description = "Dialog theme (popovers, modals, floating windows).";
      };
      "fontSize" = mkOption
      {
        type = types.float;
        default = 16.0;
        description = "Font size.";
      };
      "fontFamily" = mkOption
      {
        type = types.str;
        default = "Consolas";
        description = "Font family.";
      };
    };
  });

  rootOptions =
  {
    "themes" = mkOption
    {
      type = types.listOf themeOptions;
      default = [];
      description = "List of available themes.";
    };
    "currentThemeName" = mkOption
    {
      type = types.str;
      default = "default";
      description = "Name of theme to be applied.";
    };
    "pinnedApps" = mkOption
    {
      type = types.listOf types.str;
      default =
      [
        "defaultBrowser"
        "defaultFileExplorer"
      ];
      description = "List of pinned apps (used by taskbar).";
    };
    "iconSubstitutes" = mkOption
    {
      type = types.attrs;
      default = {};
      description = "Key-values for substituting icons.";
    };
    "appNameSubstitutes" = mkOption
    {
      type = types.attrs;
      default = {};
      description = "Key-values for substituting application names.";
    };
  };
in
{
  options."desktop" = rootOptions;

  # Rest of configuration will be completed with default values.
  config.desktop =
  {
    themes =
    [
      {
        name = "default";
      }
      {
        name = "other";
      }
    ];
    currentThemeName = "other";
    iconSubstitutes =
    {
        "system-file-manager" = "file-manager";
        "transmission-gtk" = "transmission";
        "audio-headset-bluetooth" = "audio-headphones-symbolic";
        "audio-card-analog-usb" = "audio-speakers-symbolic";
        "audio-card-analog-pci" = "audio-card-symbolic";
        "preferences-system" = "emblem-system-symbolic";
        "com.github.Aylur.ags-symbolic" = "controls-symbolic";
        "com.github.Aylur.ags" = "controls-symbolic";
    };
    appNameSubstitutes =
    {
        "GNU Image Manipulation Program" = "GIMP";
        "Telegram Desktop" = "Telegram";
        "VLC media player" = "VLC";
    };
  };
}
