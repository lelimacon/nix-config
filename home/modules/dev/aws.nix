# AWS development tools.
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    pkgs-unstable.awscli2 # AWS CLI unified tool.
    ssm-session-manager-plugin
    (pkgs-unstable.aws-sam-cli.overrideAttrs (old: {
      disabledTests = (old.disabledTests or []) ++ [
        # Broken with Python 3.14 in 1.163.0.
        "test_toml_invalid_file_name"
      ];
    })) # CLI tool for local development and testing.
  ];
}
