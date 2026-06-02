{
  config,
  pkgs,
  ...
}:
let
  editorBinding = key: command:
  {
    key = key;
    command = command;
    when = "editorTextFocus && !editorReadonly";
  };
  colors = config.theme.colors;

  # Lib.
  css-linear-gradient = direction: stops:
    pkgs.lib.strings.join ";"
    [
      # Fallback.
      "background: none; /* fallback */"
      # Chrome 10-25, Safari 5.1-6.
      "background: -webkit-linear-gradient(${direction}, ${pkgs.lib.join "," stops})"
      # W3C, Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+.
      "background: linear-gradient(${direction}, ${pkgs.lib.join "," stops})"
    ];

  font-feature-settings = "'liga', 'calt', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08'";
in
{
  home.shellAliases =
  {
    "code" = "codium";
  };

  programs.vscode =
  {
    enable = true;
    package = pkgs.vscodium;

    profiles.default =
    {
      keybindings =
      [
        (editorBinding "ctrl+shift+u" "editor.action.transformToUppercase")
        (editorBinding "ctrl+shift+i" "editor.action.transformToLowercase")
        (editorBinding "shift+cmd+numpad0" "editor.action.fontZoomReset")
        (editorBinding "ctrl+numpad_divide" "editor.action.commentLine")
      ];

      # General settings.
      userSettings =
      {
        "update.mode" = "none";
        "breadcrumbs.enabled" = true;

        #"files.autoSave" = "off";
        "files.trimTrailingWhitespace" = true;
        "files.eol" = "\n";

        "extensions.autoUpdate" = false; # fixes vscode freaking out when theres an update.

        #"window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
        #"window.menuBarVisibility" = "toggle";
        #"terminal.integrated.fontFamily" = "'Maple Mono', 'SymbolsNerdFont'";
        "terminal.external.linuxExec" = "ghostty";
        "terminal.integrated.fontLigatures.enabled" = true;
        "terminal.integrated.fontLigatures.featureSettings" = font-feature-settings;

        #"material-icon-theme.folders.theme" = "classic";
        #"vsicons.dontShowNewVersionMessage" = true;

        "explorer.confirmDragAndDrop" = false;
        #"explorer.openEditors.visible" = 0;

        "editor.fontFamily" = "'MonaspiceAr Nerd Font', 'FiraCode Nerd Font', Monaco, monospace";
        #"editor.fontFamily" = "'${config.my-fonts.monaspace-nerd.ar}', 'FiraCode Nerd Font', Monaco, monospace";
        # => -> --> >= <= ===
        # /= ~> >-> <-< <> |>
        #"editor.fontLigatures" = true;
        "editor.fontLigatures" = font-feature-settings;
        "editor.fontSize" = 13;
        "editor.minimap.enabled" = false;
        "editor.stickyScroll.enabled" = false;
        #"editor.formatOnSave" = true;
        #"editor.formatOnType" = true;
        #"editor.formatOnPaste" = true;
        "editor.inlayHints.enabled" = "off";
        #"editor.renderControlCharacters" = false;
        #"editor.scrollbar.verticalScrollbarSize" = 2;
        #"editor.scrollbar.horizontalScrollbarSize" = 2;
        #"editor.scrollbar.vertical" = "hidden";
        #"editor.scrollbar.horizontal" = "hidden";
        "editor.mouseWheelZoom" = true;
        "editor.roundedSelection" = false;
        "editor.multiCursorModifier" = "ctrlCmd";
        "editor.renderWhitespace" = "boundary";

        #"workbench.colorTheme" = "Gruvbox Dark Hard";
        #"workbench.iconTheme" = "gruvbox-material-icon-theme";
        #"workbench.colorTheme" = "Smoothy 7";
        #"workbench.editor.limit.enabled" = true;
        #"workbench.editor.limit.value" = 10;
        #"workbench.editor.limit.perEditorGroup" = true;
        #"workbench.editor.showTabs" = "none";
        "workbench.editor.revealIfOpen" = true;
        #"workbench.startupEditor" = "none";
        #"workbench.layoutControl.type" = "menu";
        #"workbench.activityBar.location" = "hidden";
        #"workbench.statusBar.visible" = false;
        #"workbench.layoutControl.enabled" = false;
        "workbench.tree.indent" = 16;

        "git.autofetch" = true;

        #"git.openRepositoryInParentFolders" = "never";
        "diffEditor.ignoreTrimWhitespace" = false;
        #"security.workspace.trust.untrustedFiles" = "open";
      };

      # Theming.
      # https://code.visualstudio.com/api/references/theme-color
      userSettings =
      {
        #"workbench.colorTheme" = "Koala";
        "workbench.colorTheme" = "Default Light+";
        #"workbench.iconTheme" = "catppuccin noctis icons";
        #"workbench.iconTheme" = "file-icons";
        "workbench.iconTheme" = "bearded-icons";
        "workbench.colorCustomizations" =
        {
          "[Default Light+]" =
          {
              "activityBar.background" = colors.primary;
              #"activityBar.background" = osConfig.my-theme.colors.primary;
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
              #"titleBar.activeBackground" = "#0b1014";
          };
        };
      };

      # Extension: Icon Theme: Catppuccin Noctis Icons.
      # https://open-vsx.org/extension/alexdauenhauer/catppuccin-noctis-icons
      userSettings =
      {
        "catppuccin-noctis-icons.hidesExplorerArrows" = true;
      };

      # Extension: Rust Analyzer.
      # https://open-vsx.org/extension/rust-lang/rust-analyzer
      userSettings =
      {
        "rust-analyzer.inlayHints.typeHints.enable" = false;
        "rust-analyzer.inlayHints.parameterHints.enable" = false;
        "rust-analyzer.inlayHints.closingBraceHints.enable" = false;
      };

      # Extension: Markdown Header Coloring.
      # https://open-vsx.org/extension/satokaz/vscode-markdown-header-coloring
      userSettings =
      {
        "markdown-header-coloring.destroyMode" = true;
        "markdown-header-coloring.fontColor" = false;
        "markdown-header-coloring.userDefinedHeaderColor" =
        {
          "enabled" = true;
          "Header_1" =
          {
              "color" = colors.primary;
              "textDecoration" = "padding: 2px; font-size: 1.2em;";
              "backgroundColor" = css-linear-gradient "to top" [ "${colors.border} 1px" "rgba(0, 0, 0, 0) 2px" ];
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
      };
    };
  };
}
