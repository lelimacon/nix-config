# Shared shell-snippet generators for wrapped packages.
# Each function returns a string of bash code suitable for use in `runShell`.
{
  # Ensures the dir exists and the git repo is initialized.
  # Copies .gitignore from `gitignoreSrc` before the first init so ignored
  # files are never staged in the initial commit.
  gitEnsureRepo = dir: gitignoreSrc: ''
    mkdir -p "${dir}"
    if [ ! -d "${dir}/.git" ]; then
      [ -f "${gitignoreSrc}" ] && cp -f "${gitignoreSrc}" "${dir}/.gitignore"
      git -C "${dir}" init --quiet
    fi
  '';

  # Stages all changes and commits with a timestamp if anything changed.
  gitCommit = dir: label: ''
    (
      GIT="git -C ${dir}"
      $GIT add -A
      $GIT diff --cached --quiet || \
        $GIT commit --quiet -m "$(date -u '+%Y-%m-%dT%H:%M:%SZ') ${label}"
    )
  '';

  # Syncs every file from `src` into `dst`, always overwriting.
  # Uses find so dotfiles and nested subdirs are included.
  syncSettings = src: dst: ''
    if [ -d "${src}" ]; then
      while IFS= read -r file; do
        rel="''${file#${src}/}"
        target="${dst}/$rel"
        mkdir -p "$(dirname "$target")"
        cp -f "$file" "$target"
      done < <(find "${src}" -type f -not -name ".gitkeep")
    fi
  '';
}
