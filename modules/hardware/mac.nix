# Mac common hardware configuration.
# https://nix-darwin.github.io/nix-darwin/manual/index.html
{
  config,
  ...
}:
{
  # Unlock sudo with fingerprint.
  security.pam.services.sudo_local.touchIdAuth = true;

  system.startup.chime = false;

  # Peripherals.
  homebrew =
  {
    casks =
    [
      "monitorcontrol" # external monitors brightness and volume controls.
      "ukelele" # keyboard layout editor.
      "unnaturalscrollwheels" # natural scrolling on trackpad but regular on mouse.
    ];
  };

  networking.hostName = config.host.name;
  networking.computerName = config.host.name;
  networking.localHostName = config.host.name;
}
