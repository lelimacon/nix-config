# Systemd login manager.
{
  ...
}:
{
  # services.logind.extraConfig =
  # ''
  #   HandlePowerKey=poweroff
  #   HandlePowerKeyLongPress=ignore
  #   HandleRebootKey=reboot
  #   HandleRebootKeyLongPress=poweroff
  #   HandleSuspendKey=suspend
  #   HandleSuspendKeyLongPress=hibernate
  #   HandleHibernateKey=hibernate
  #   HandleHibernateKeyLongPress=ignore
  #   HandleLidSwitch=ignore
  #   HandleLidSwitchExternalPower=ignore
  #   HandleLidSwitchDocked=ignore
  #   LidSwitchIgnoreInhibited=no
  # '';
  services.logind.settings =
  {
    Login.HandleLidSwitch = "ignore";
  };
}
