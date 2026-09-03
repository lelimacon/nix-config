#!/usr/bin/env nu

# Interactively pick an AWS profile, run `aws sso login`, and export AWS_PROFILE.
#
# For AWS_PROFILE to persist in your shell, `source` this file and call
# `aws-login` directly -- running it as an external command (e.g. the
# packaged binary) can't modify your shell's environment.
export def --env aws-login [] {
    let profiles = (aws configure list-profiles | lines)
    if ($profiles | is-empty) {
        print "No AWS profiles configured. Run `aws configure sso` first."
        return
    }

    let profile = ($profiles | input list "Select AWS profile:")
    if ($profile | is-empty) {
        print "No profile selected."
        return
    }

    print $"Profile: '(ansi green)($profile)(ansi reset)'"

    aws sso login --profile $profile
    if $env.LAST_EXIT_CODE != 0 {
        print $"SSO login failed for profile '($profile)'."
        return
    }

    $env.AWS_PROFILE = $profile
    print $"AWS_PROFILE set to '(ansi green)($profile)(ansi reset)'."
}

# Entry point when run as a standalone script/binary (env changes won't
# persist to the calling shell in this mode).
export def main [] {
    aws-login
}
