# Mise configuration.
# Runtime version manager.
{
  ...
}:
{
  programs.mise =
  {
    enable = true;
    enableBashIntegration = true;
    #enableZshIntegration = true;

    settings =
    {
      experimental = true;
      verbose = false;
      auto_install = true;
    };
  };
}
