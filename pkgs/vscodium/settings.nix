{
  config,
  lib,
  pkgs,
}:
let
  join = sep: list: lib.concatStringsSep sep list;
  theme = config.theme;
  colors = config.theme.colors;

  cssLinearGradient = direction: stops:
    join ";" [
      "background: none"
      "background: -webkit-linear-gradient(${direction}, ${join "," stops})"
      "background: linear-gradient(${direction}, ${join "," stops})"
    ];

  fontFeatureSettings = "'liga', 'calt', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08'";
in
{
  # General.
  "update.mode" = "none";
  "breadcrumbs.enabled" = true;
  "files.trimTrailingWhitespace" = true;
  "files.eol" = "\n";
  "extensions.autoUpdate" = false;
  "terminal.external.linuxExec" = "kitty";
  "terminal.integrated.fontLigatures.enabled" = true;
  "terminal.integrated.fontLigatures.featureSettings" = fontFeatureSettings;
  "explorer.confirmDragAndDrop" = false;
  "editor.fontFamily" = "'${theme.monoFont.family}', 'FiraCode Nerd Font', Monaco, monospace";
  "editor.fontLigatures" = fontFeatureSettings;
  "editor.fontSize" = theme.monoFont.size;
  "editor.minimap.enabled" = false;
  "editor.stickyScroll.enabled" = false;
  "editor.inlayHints.enabled" = "off";
  "editor.mouseWheelZoom" = true;
  "editor.roundedSelection" = false;
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.renderWhitespace" = "boundary";
  "workbench.editor.revealIfOpen" = true;
  "workbench.tree.indent" = 16;
  "git.autofetch" = true;
  "diffEditor.ignoreTrimWhitespace" = false;

  # Theming.
  "workbench.colorTheme" = "Light+";
  "workbench.iconTheme" = "bearded-icons";
  "workbench.colorCustomizations"."[Light+]" =
    {
      "activityBar.background" = colors.primary;
      "activityBar.activeForeground" = colors.primary-fg-strong;
      "activityBar.inactiveForeground" = colors.primary-fg;
      "activityBarBadge.background" = colors.primary-dark;
      "editor.background" = colors.bg-strong;
      "editorGroupHeader.tabsBackground" = colors.primary-lighter;
      "sideBar.foreground" = colors.fg;
      "sideBar.background" = colors.primary-lighter;
      "sideBarSectionHeader.background" = colors.primary-light;
      "statusBar.background" = colors.primary;
      "statusBar.foreground" = colors.primary-fg-strong;
      "tab.inactiveBackground" = colors.primary-light;
      "tab.activeBackground" = colors.primary-lighter;
      "tab.activeBorder" = colors.primary-dark;
    };

  # Extension: Catppuccin Noctis Icons.
  "catppuccin-noctis-icons.hidesExplorerArrows" = true;

  # Extension: Nix IDE.
  # Absolute path avoids relying on $PATH, which GUI-launched apps don't
  # inherit from the shell (nix-instantiate would otherwise go unfound).
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

  # Extension: Rust Analyzer.
  "rust-analyzer.inlayHints.typeHints.enable" = false;
  "rust-analyzer.inlayHints.parameterHints.enable" = false;
  "rust-analyzer.inlayHints.closingBraceHints.enable" = false;

  # Extension: Markdown Header Coloring.
  "markdown-header-coloring.destroyMode" = true;
  "markdown-header-coloring.fontColor" = false;
  "markdown-header-coloring.userDefinedHeaderColor" =
    {
      "enabled" = true;
      "Header_1" =
        {
          "color" = colors.primary;
          "textDecoration" = "padding: 2px; font-size: 1.2em;";
          "backgroundColor" = cssLinearGradient "to top" [ "${colors.border} 1px" "rgba(0, 0, 0, 0) 2px" ];
          "overviewRulerColor" = colors.primary;
        };
      "Header_2" =
        {
          "color" = colors.primary;
          "textDecoration" = "padding: 1px; font-size: 1.1em;";
          "backgroundColor" = false;
          "overviewRulerColor" = colors.primary;
        };
      "Header_3" =
        {
          "color" = colors.primary-dark;
          "backgroundColor" = false;
          "overviewRulerColor" = colors.primary-dark;
        };
      "Header_4" =
        {
          "color" = colors.primary-dark;
          "backgroundColor" = false;
          "overviewRulerColor" = colors.primary-dark;
        };
      "Header_5" =
        {
          "color" = colors.primary-dark;
          "backgroundColor" = false;
          "overviewRulerColor" = colors.primary-dark;
        };
      "Header_6" =
        {
          "color" = colors.primary-dark;
          "backgroundColor" = false;
          "overviewRulerColor" = colors.primary-dark;
        };
    };
}
