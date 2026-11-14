{
  config,
  ...
}:
{
  # User account.
  # Set password with ‘passwd’.
  users.users.${config.user.name} =
  {
    name = config.user.name;
    description = config.user.name;
    home = config.user.homeDirectory;
  };

  system.primaryUser = config.user.name;
}
