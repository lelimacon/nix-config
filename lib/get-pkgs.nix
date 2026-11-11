nixpkgs: system: import nixpkgs
{
  system = system;
  config =
  {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [ "docker-28.5.2" ];
  };
}
