#! /usr/bin/env nix-shell
#! nix-shell -i bash -p toybox git

# Finds dirt.
#
# Dependencies
# - toybox: lighter alt to coreutils/busybox, for `wc`
# - git: for checking git repositories
#
# Usage
# $ dirt .

set -eE -o pipefail
INF='\033[1;34m';ERR='\033[0;31m';OK='\033[0;32m';DBG='\033[0m'
trap 'echo -e ${ERR}ERROR${DBG}' ERR


to_absolute_path() {
    # https://stackoverflow.com/a/21188136
    filename=$1
    parentdir=$(dirname "${filename}")

    if [ -d "${filename}" ]; then
        echo "$(cd "${filename}" && pwd)"
    elif [ -d "${parentdir}" ]; then
        echo "$(cd "${parentdir}" && pwd)/$(basename "${filename}")"
    fi
}

print_count() {
    count=$1
    count_formatted=$(printf "% 3d" $count)

    if test "$count" -ne 0 ; then
        echo -en "${ERR}${count_formatted}${DBG}"
    else
        echo -en "${OK}${count_formatted}${DBG}"
    fi
}

dirt() {
    local dir=$(to_absolute_path "$1")

    cd $dir

    if [ ! -d .git ]
    then
        for f in *
        do
            if [ -d "$dir/$f" ]
            then
                dirt "$dir/$f"
            fi
        done

        return
    fi

    echo -e "${INF}--- ${dir}${DBG}"

    staged_files_count=$(git diff-index --cached HEAD | wc -l)
    print_count $staged_files_count
    echo " staged files"

    untracked_files_count=$(git ls-files --exclude-standard --others | wc -l)
    print_count $untracked_files_count
    echo " untracked files"
}


absolute_dir=$(to_absolute_path "$1")

dirt $absolute_dir

echo -e "${INF}Done.${DBG}"

exit
