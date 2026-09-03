# AWS development tools.
{
  pkgs,
  pkgs-unstable,
  pkgs-ext,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    pkgs-unstable.awscli2 # AWS CLI unified tool.
    ssm-session-manager-plugin

    (pkgs-unstable.aws-sam-cli.overrideAttrs (old: {
      disabledTests = (old.disabledTests or []) ++ [
        # Broken with Python 3.14 in 1.163.0.
        "test_toml_invalid_file_name"
      ];
    })) # CLI tool for local development and testing.

    pkgs-ext.aws-login # Pick an AWS profile and SSO-login (source it to export AWS_PROFILE).
  ];

  environment.variables =
  {
    "AWS_CONFIG_FILE" = "~/.config/aws/config.toml";
    "AWS_SHARED_CREDENTIALS_FILE" = "~/.config/aws/credentials.toml";
  };
}
