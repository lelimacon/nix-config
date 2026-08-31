{
  pkgs,
  wrappers,
  package,
  settings,
  env ? { },
  runtimePkgs ? [ ],
}:
let
  inherit (import ../../lib/shell.nix) gitEnsureRepo gitCommit syncSettings;
  inherit (import ../../lib/wrapping.nix { inherit pkgs; }) wrapIfMacOsApp;

  configDir = "$HOME/.config/JetBrains.Rider-nix-wrapper";
  hardcodedDir = toString ./hardcoded-settings;

  colorsSchemeXml =
  ''
    <application>
      <component name="EditorColorsManagerImpl">
        <global_color_scheme name="${settings.colorScheme}" />
      </component>
    </application>
  '';

  editorXml =
  ''
    <application>
      <component name="EditorSettings">
        <option name="STRIP_TRAILING_SPACES" value="${settings.editor.stripTrailingSpaces}" />
        <option name="KEEP_TRAILING_SPACE_ON_CARET_LINE" value="${pkgs.lib.boolToString settings.editor.keepTrailingSpaceOnCaretLine}" />
      </component>
    </application>
  '';

  editorFontXml =
  ''
    <application>
      <component name="DefaultFont">
        <option name="VERSION" value="1" />
        <option name="FONT_FAMILY" value="${settings.fonts.fontFamily}" />
        <option name="USE_LIGATURES" value="${pkgs.lib.boolToString settings.fonts.useLigatures}" />
      </component>
    </application>
  '';

  lafXml =
  ''
    <application>
      <component name="LafManager">
        <laf themeId="${settings.themeId}" />
      </component>
    </application>
  '';

  generatedDir = pkgs.linkFarm "jetbrains-rider-settings"
  [
    { name = "options/colors.scheme.xml"; path = pkgs.writeText "colors.scheme.xml" colorsSchemeXml; }
    { name = "options/editor.xml";        path = pkgs.writeText "editor.xml" editorXml; }
    { name = "options/editor-font.xml";   path = pkgs.writeText "editor-font.xml" editorFontXml; }
    { name = "options/laf.xml";           path = pkgs.writeText "laf.xml" lafXml; }
  ];
in
wrapIfMacOsApp "Rider" "rider"
(wrappers.lib.wrapPackage ({ lib, ... }:
{
  inherit pkgs;

  inherit package;

  # Pass config/plugins paths as JVM system properties.
  # esc-fn = lib.id skips shell quoting so $HOME expands at runtime.
  addFlag =
  [
    { data = "-Didea.config.path=${configDir}";          esc-fn = lib.id; }
    { data = "-Didea.plugins.path=${configDir}/plugins"; esc-fn = lib.id; }
  ];

  inherit env runtimePkgs;

  runShell =
  [
    (gitEnsureRepo configDir "${hardcodedDir}/.gitignore")
    (gitCommit configDir "before")
    (syncSettings hardcodedDir configDir)
    (syncSettings "${generatedDir}" configDir)
    (gitCommit configDir "after")
  ];
}))
