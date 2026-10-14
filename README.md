
<img src="./ext/octopix.svg" alt="logo" width="300" height="300">

# Features

NixOS homeless**¹** non-blocking-config**²** setup.

**¹** Without a Home Manager, configuration is wrapped directly in the packages thanks to [nix-wrapper-modules](https://github.com/nix-community/nix-wrapper-modules).

**²** Some wrappers have a RW configuration folder (which allows to apply settings directly in-app) initialized with version control to track the changes and add them back to the package configuration.

# Folder Structure

- `ext/`: Aditional scripts & apps
- `hosts/`: Device-specific configuration that cherry-pick modules
- `modules/`: System-specific configuration, organized by modules
- `pkgs/`: Wrapped packages (via [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules))
- `lib/`: Nix helper functions
- `shells/`: Generic dev shells

Browse the folder READMEs for more information.
