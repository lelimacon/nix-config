#!/usr/bin/env nu

# Report uncommitted changes in every git repository under a directory.
#
# Recurses into `--dir`, stopping at each repo boundary (a repo's own
# contents are never descended into). Defaults to the current directory —
# running this with no arguments in this repo reports its own drift, and
# pointed at `~/.config` it reports drift in wrapped-package config dirs
# (see pkgs/helpers.nix), which are synced from this repo on every launch.
export def main [
    filter?: string          # Only check repos whose folder name contains this substring.
    --dir: string       # Directory to scan, recursively. Defaults to the current directory.
    --verbosity (-v): string = "count"  # 'count' (default), 'files', or 'full'.
] {
    if $verbosity not-in ["count" "files" "full"] {
        print $"(ansi red)Invalid --verbosity '($verbosity)', expected 'count', 'files', or 'full'.(ansi reset)"
        return
    }

    let target = ($dir | default "." | path expand)

    if not ($target | path exists) {
        print $"(ansi red)($target) does not exist.(ansi reset)"
        return
    }

    let repos = (find-git-repos $target $filter)
    if ($repos | is-empty) {
        print $"(ansi grey)No git repos found under ($target).(ansi reset)"
        return
    }
    for dir in $repos {
        report-repo $dir $verbosity
    }
}

# Show help.
def "main help" [] {
    help commands main
}

def is-git-repo [dir: string]: nothing -> bool {
    ($dir | path join ".git") | path exists
}

# Recursively finds git repos under `dir`, stopping at each repo boundary
# instead of descending into it. Inaccessible directories are skipped.
def find-git-repos [dir: string, filter?: string] {
    if (is-git-repo $dir) {
        if $filter == null or ($dir | path basename | str contains $filter) {
            [$dir]
        } else {
            []
        }
    } else {
        try { ls $dir } catch { [] }
        | where type == dir
        | get name
        | each { |sub| find-git-repos $sub $filter }
        | flatten
    }
}

def has-head [dir: string]: nothing -> bool {
    (git -C $dir rev-parse --verify HEAD | complete | get exit_code) == 0
}

# Each entry is a 2-char status code (index/worktree) followed by the path,
# e.g. " M path", "A  path", "?? path" — see `git status --porcelain`.
# `-z` disables path quoting, so paths with spaces or special characters
# come through unquoted (NUL-separated instead of newline-separated).
def repo-status [dir: string] {
    git -C $dir status --porcelain -z --untracked-files=normal
    | complete
    | get stdout
    | split row (char -i 0)
    | where ($it | str length) > 0
    | each { |l| { code: ($l | str substring 0..1), path: ($l | str substring 3..) } }
}

def status-label [code: string] {
    if ($code | str contains "?") {
        $"(ansi blue)untracked(ansi reset)"
    } else if ($code | str contains "A") {
        $"(ansi green)added(ansi reset)"
    } else if ($code | str contains "D") {
        $"(ansi red)deleted(ansi reset)"
    } else if ($code | str contains "R") {
        $"(ansi magenta)renamed(ansi reset)"
    } else {
        $"(ansi yellow)modified(ansi reset)"
    }
}

def report-repo [dir: string, verbosity: string] {
    let rows = (repo-status $dir)
    let clean = ($rows | is-empty)

    let symbol = if $clean { "✓" } else { "✗" }
    let color = if $clean { (ansi dark_gray) } else { (ansi red) }
    let count_suffix = if $clean {
        ""
    } else {
        let count = ($rows | length)
        $" [($count)]"
    }
    print $"($color)($symbol) ($dir | path basename)(ansi light_gray)($count_suffix)(ansi reset)"

    if $clean {
        return
    }

    if $verbosity == "files" {
        for row in $rows {
            print $"  (status-label $row.code) ($row.path)"
        }
    } else if $verbosity == "full" {
        if (has-head $dir) {
            git -C $dir diff HEAD --color=always | lines | each { |l| print $l }
        }
        for row in ($rows | where ($it.code | str contains "?")) {
            print $"  (ansi blue)untracked(ansi reset) ($row.path)"
        }
    }
}
