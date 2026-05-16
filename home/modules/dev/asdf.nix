# asdf configuration.
# https://asdf-vm.com/guide/getting-started.html#_2-configure-asdf
#
# asdf runtime version manager.
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs;
  [
    asdf-vm
  ];

  # Add shims to PATH
  #programs.bash.initExtra =
  #''
  #  # Configure asdf.
  #  #export PATH="$HOME/.asdf/shims:$PATH"
  #'';
}
