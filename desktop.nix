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

  appOptions = types.submodule
  ({
    options =
    {
      "appClass" = mkOption
      {
        type = types.nullOr types.str;
        default = null;
        description = "Application (wm) class/desktop to match entry.";
      };
      "clientClasses" = mkOption
      {
        type = types.listOf types.str;
        default = [];
        description = "Client classes to match entry.";
      };
      "category" = mkOption
      {
        type = types.nullOr types.str;
        default = null;
        description = "Optional application category.";
      };
      "name" = mkOption
      {
        type = types.nullOr types.str;
        default = null;
        description = "Optional application name override.";
      };
      "iconName" = mkOption
      {
        type = types.nullOr types.str;
        default = null;
        description = "Optional icon name override.";
      };
      "executable" = mkOption
      {
        type = types.nullOr types.str;
        default = null;
        description = "Optional CLI.";
      };
      "isHidden" = mkOption
      {
        type = types.bool;
        default = false;
        description = "Hide from lists (can still be shown and searched for).";
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
    "apps" = mkOption
    {
      type = types.listOf appOptions;
      default = {};
      description = "Application matching and overrides.";
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
    apps =
    [
      # Social.
      {
        appClass = "firefox";
        category = "Social";
      }
      {
        appClass = "org.telegram.desktop.desktop";
        category = "Social";
        name = "Telegram";
      }
      {
        appClass = "discord.desktop";
        category = "Social";
      }
      {
        appClass = "Slack";
        category = "Social";
      }

      # Utils.
      {
        appClass = "kitty.desktop";
        category = "Utils";
      }
      {
        appClass = "io.missioncenter.MissionCenter.desktop";
        category = "Utils";
      }
      {
        appClass = "1Password";
        category = "Utils";
      }
      {
        appClass = "cups.desktop";
        category = "Utils";
      }
      {
        clientClasses = ["com.github.Aylur.ags"];
        category = "Utils";
        name = "AGS inspector";
        iconName = "astal";
        executable = "ags -i";
      }
      {
        appClass = "nemo";
        iconName = "file-manager";
        category = "Utils";
      }
      {
        appClass = "org.pulseaudio.pavucontrol.desktop";
        category = "Utils";
        isHidden = true;
      }
      {
        appClass = "XTerm";
        category = "Utils";
        isHidden = true;
      }
      {
        appClass = "nixos-manual.desktop";
        category = "Utils";
        isHidden = true;
      }
      {
        appClass = "nm-connection-editor.desktop";
        category = "Utils";
        isHidden = true;
      }
      {
        appClass = "vim.desktop";
        category = "Utils";
        isHidden = true;
      }

      # Code.
      {
        appClass = "vscodium";
        clientClasses = ["codium-url-handler"];
        name = "Code";
        category = "Code";
      }
      {
        appClass = "postman.desktop";
        category = "Code";
      }
      {
        appClass = "jetbrains-rider";
        clientClasses = ["jetbrains-rider"];
        category = "Code";
      }

      # Media.
      {
        appClass = "nemo.desktop";
        category = "Media";
        name = "Nemo";
        iconName = "file-manager";
        isHidden = true;
      }
      {
        appClass = "Spotify";
        category = "Media";
      }
      {
        appClass = "gimp.desktop";
        category = "Media";
        name = "GIMP";
      }
      {
        appClass = "org.inkscape.Inkscape.desktop";
        category = "Media";
      }
      {
        appClass = "vlc.desktop";
        category = "Media";
        name = "VLC";
        isHidden = true;
      }
      {
        appClass = "Blender";
        category = "Media";
      }

      # Games.
      {
        appClass = "xmoto.desktop";
        clientClasses = [".xmoto-wrapped"];
        category = "Games";
      }
    ];
  };
}
