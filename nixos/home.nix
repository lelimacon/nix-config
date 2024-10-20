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
  users.users.lelimacon =
  {
    isNormalUser = true;
    description = "lelimacon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Tie Home Manager to system configuration.
  home-manager =
  {
    users."lelimacon" = import ../home;
    extraSpecialArgs =
    {
      inherit inputs;
    };
  };
}
