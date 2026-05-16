# AWS development tools.
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    pkgs-unstable.awscli2 # CLI tool.
    ssm-session-manager-plugin
    pkgs-unstable.aws-sam-cli # CLI tool for local development and testing
  ];
}
