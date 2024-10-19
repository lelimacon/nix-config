#! /usr/bin/env nix-shell
#! nix-shell -i bash -p toybox nix-index

# Provides info about the given command.
#
# Dependencies
# - toybox: lighter alt to coreutils/busybox, for `grep`, `wc`
# - nix-index: for `nix-locate`
#
# Usage
# $ what echo

set -e -o pipefail
INF='\033[1;34m';ERR='\033[0;31m';DBG='\033[0m'


COMMAND=$1

echo -e "${INF}---- ${DBG}"
echo -e "${INF}${COMMAND} ${DBG}"
echo -e "${INF}---- ${DBG}"


COMMAND_PATH=$(which "${COMMAND}")

echo -e "${INF}-> ${DBG} ${COMMAND_PATH}"


# Generate DB with `nix-index`
LOCATIONS=$(nix-locate --no-group --minimal "bin/${COMMAND}")

DIRECT=$(echo "${LOCATIONS}" | grep -v "^(")
INDIRECT=$(echo "${LOCATIONS}" | grep "^(")

DIRECT_COUNT=$(echo "${DIRECT}" | wc -l)
INDIRECT_COUNT=$(echo "${INDIRECT}" | wc -l)

echo -e "${INF}${DIRECT_COUNT} package(s), ${INDIRECT_COUNT} dependencie(s) ${DBG}"
echo ${DIRECT}
