#!/usr/bin/env bash
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
exec "$scriptDir/../share/dev.j7126.ttrpg_character_tools/ttrpg_character_tools" "$@"
