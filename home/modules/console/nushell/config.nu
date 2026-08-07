let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

$env.config = {
    show_banner: false,
    completions: {
        case_sensitive: false
        quick: true # auto-select completions.
        partial: true # partial filling of the prompt.
        algorithm: "fuzzy"
        external: {
            enable: true # look into $env.PATH to find more suggestions.
            max_results: 100
            completer: $carapace_completer
        }
    }
}

#$env.PATH = (
#    $env.PATH
#    | split row (char esep)
#    | prepend /home/myuser/.apps
#    | append /usr/bin/env
#)

# Print version number.
print $"(ansi light_gray_bold)nu ((version).version)(ansi reset)"

# Load private config if any.
# https://github.com/nushell/nushell/issues/8214
source (
    if (($nu.home-path | path join ".config/private.config.nu") | path expand | path exists) {
        $nu.home-path | path join ".config/private.config.nu"
    }
    else {
        # Fallback to empty file.
        $nu.default-config-dir | path join "empty.nu"
    }
)
