let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

$env.config = {
    show_banner: false,
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
        }
    }
}

# Print version number.
print $"(ansi light_gray_bold)nu ((version).version)(ansi reset)"

# Shell aliases.
alias .. = cd ..
alias ... = cd ../..
alias l = eza
alias ll = eza -l --icons
alias tree = eza --tree
alias gl = git log --graph '--pretty=format:%Cgreen%ad%Creset %C(auto)%h %s %C(bold black)<%aN>%C(auto)%d%Creset' '--date=format-local:%Y-%m-%d %H:%M'
