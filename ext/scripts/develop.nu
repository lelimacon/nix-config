#!/usr/bin/env nu

# Develop utility.
export def main [path: string] {
    let devShell = prompt-shell $path

    if ($devShell == null) {
        print $"(ansi grey)No devShell selected. Exiting.(ansi reset)"
        exit
    }

    print $"Entering (ansi green)($devShell.name)(ansi reset)..."

    nix develop $"path:($path)#($devShell.name)"
}

# Show help.
def "main help" [] {
    help commands main
}

def prompt-shell [path: string] {
    let shells = list-shells $path

    if ($shells | is-empty) {
        print $"(ansi grey)No devShells found in flake. Exiting.(ansi reset)"
        exit
    }

    # Build options.
    let options = ($shells | insert display { |row| 
        $"(ansi green)($row.name)(ansi reset) ((ansi cyan)($row.system)(ansi reset)) - ($row.description)"
    })

    # Show menu.
    let selectedLine = ($options.display | input list --fuzzy "Select devShell:")

    if ($selectedLine != null) {
        let selectedShell = ($options | where display == $selectedLine | first)

        return $selectedShell
    }

    return null
}

def list-shells [path: string] {
    let flakeInfo = nix flake show $"path:($path)" --json err> /dev/null | from json
    if ($flakeInfo | is-empty) {
        print $"(ansi grey)Flake not found. Exiting(ansi reset)"
        exit
    }

    # { "system"."devShell".{ description, name, type } }
    let devShells = (
        $flakeInfo.devShells |
        | items { |system, shells| 
            $shells
                #| filter { $in.description != null }
                | items { |shellName, details| 
                    {
                        system: $system,
                        name: $shellName,
                        description: ($details | get -o description)
                    }
            }
        }
        | flatten
        | where { $in.description != null }
    )
    $devShells
}
