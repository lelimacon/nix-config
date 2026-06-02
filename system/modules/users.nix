{
  inputs,
  outputs,
  ...
}:
{
  imports =
  [
    # TODO: Remove this.
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
