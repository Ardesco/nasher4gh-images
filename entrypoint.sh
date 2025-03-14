#!/usr/bin/env bash

RED='\033[0;31m'
CLS='\033[0m'

DEFAULT_OPTIONS=("--nssFlags:\"-lowkey\"" "--userName:\"nasher\"" "--packUnchanged true" "--abortOnCompileError true")

while [[ $# -gt 0 ]]; do
  case $1 in
    -option)
      ADDITIONAL_OPTIONS+="$2"
      shift
      shift
      ;;
    -usenwnscriptcomp)
      DEFAULT_OPTIONS=("--nssFlags:\"-y\"" "--nssCompiler:/root/.nimble/bin/nwn_script_comp" "--userName:\"nasher\"" "--packUnchanged true" "--abortOnCompileError true")
      shift
      ;;
    *)
      NASHER_COMMANDS+=("$1")
      shift
      ;;
  esac
done

for OPTION in "${DEFAULT_OPTIONS[@]}"; do
  echo -e " ${RED}Setting base config:${CLS} nasher config ${OPTION}"
  nasher config "${OPTION}"
done

for OPTION in "${ADDITIONAL_OPTIONS[@]}"; do
  echo -e " ${RED}Applying config override:${CLS} nasher config ${OPTION}"
  nasher config "${OPTION}"
done

nasher "${NASHER_COMMANDS[@]}"