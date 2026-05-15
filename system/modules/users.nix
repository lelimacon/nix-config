{
  inputs,
  outputs,
  ...
}:
{
  imports =
  [
    inputs.home-manager.nixosModules.default
  ];

  # User account.
  # Set password with ‘passwd’.
  users.users."lelimacon" =
  {
    isNormalUser = true;
    description = "lelimacon";
    extraGroups =
    [
      "networkmanager"
      "wheel"
      "docker"
      "input" # for keyboard state access.
    ];
  };
}
