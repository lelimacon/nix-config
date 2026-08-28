# Provides info about the given command.
#
# Runtime dependencies (see ext/index.nix)
# - nix-index: for `nix-locate`
# - toybox: lighter alt to coreutils/busybox, for `grep`, `wc`, `xargs`
# - which: show full path of commands
#
# Usage
# $ what echo

INF='\033[1;34m';DBG='\033[0m'

find_packages() {
    # Generate DB with `nix-index`
    LOCATIONS=$(nix-locate --no-group --minimal "bin/${COMMAND}" || true)

    DIRECT=$(echo "${LOCATIONS}" | grep -v "^(" || true)
    INDIRECT=$(echo "${LOCATIONS}" | grep "^(" || true)

    DIRECT_COUNT=$(echo "${DIRECT}" | wc -l)
    INDIRECT_COUNT=$(echo "${INDIRECT}" | wc -l)

    echo -e "${INF}${DIRECT_COUNT} package(s), ${INDIRECT_COUNT} dependencie(s) ${DBG}"
    echo "${DIRECT}"
}

find_libraries() {
    mapfile -t VALID_DIRS < <(echo "${LD_LIBRARY_PATH:-}" | tr ':' '\n' | while read -r dir; do if [ -d "$dir" ]; then echo "$dir"; fi; done)
    LIBRARIES=$(find "${VALID_DIRS[@]}" -name "*${COMMAND}*" 2>/dev/null || true)
    COUNT=$(echo "${LIBRARIES}" | wc -l)

    echo -e "${INF}${COUNT} library(ies)${DBG}"
    echo "${LIBRARIES}"
}


COMMAND=$1

echo -e "${INF}----${DBG}"
echo -e "${INF}${COMMAND}${DBG}"
echo -e "${INF}----${DBG}"


COMMAND_PATH=$(which "${COMMAND}")

echo -e "${INF}-> ${DBG}${COMMAND_PATH}"


find_packages
find_libraries
