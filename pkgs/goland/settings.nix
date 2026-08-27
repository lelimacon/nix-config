{
  config,
}:
{
  # JetBrains' font isn't ligature-aware, so it needs the "frozen" font variant.
  fonts =
  ''
    <application>
      <component name="DefaultFont">
        <option name="VERSION" value="1" />
        <option name="FONT_FAMILY" value="${config.theme.monoFont.frozenFamily}" />
        <option name="USE_LIGATURES" value="true" />
      </component>
    </application>
  '';
}
