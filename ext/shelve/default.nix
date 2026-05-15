{
  pkgs,
}:

pkgs.writeScriptBin "shelve" (builtins.readFile ./shelve)
