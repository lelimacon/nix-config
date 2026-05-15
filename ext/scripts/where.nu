#!/usr/bin/env nu

# Where utility.
export def main [name?: string] {
    let result = list-path-with-executables $name
    if $name == null {
        $result
    } else {
        # Filter by executable name.
        $result | where { |it| $it.files != null and ($it.files =~ $name) }
    }
}

def list-path-with-executables [name?: string] {
    $env.PATH
    | split row (char esep)
    | wrap path
    | upsert files { |it| list-executables $it.path $name }
}

def list-executables [path: string, filter?: string] {
    if ($path | path exists) {
        ls $path
            | where type == file
            | upsert baseName { |it| $it.name | path basename }
            | each { |it|
                let color = if $filter == null or ($it.baseName =~ $filter) { ansi green } else { ansi light_gray }
                $"($color)($it.baseName)(ansi reset)"
            }
            | str join ','
    } else {
        null
    }
}
