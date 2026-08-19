nixpkgs: system: import nixpkgs
{
  system = system;
  config =
  {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}
