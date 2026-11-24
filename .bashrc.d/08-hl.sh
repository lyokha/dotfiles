function hlf
{
    local -a hlopts=()
    local -a fdopts=()

    local group=hlopts

    for arg in "$@"
    do
        if [[ "$arg" = '-' ]]; then
            group=fdopts
            continue
        fi

        if [[ "$group" = fdopts ]]; then
            if [[ "${arg:0:1}" != '-' ]]; then
                fdopts+=(--search-path)
            fi
            fdopts+=("$arg")
        else
            hlopts+=("$arg")
        fi
    done

    command "${FDFIND:-fd}" -H -t file "${fdopts[@]}" | hl -g "${hlopts[@]}"
}

if [ -f "$HOME/.hl_env" ]; then
    # shellcheck disable=SC1091
    . "$HOME/.hl_env"
fi

# export HL_ALIASES=$HOME/.hl_functions in $HOME/.hl_env
# export FDFIND=fdfind in $HOME/.profile in Debian and Ubuntu
if [[ "$TERM" != "linux" ]]; then
    if [[ -f "$HL_ALIASES" ]]; then
        # shellcheck disable=SC1090
        . "$HL_ALIASES"
        alias hlg='hlgrep -gi' hla='hlgrep -a'
    fi
    if ! command -v "${FDFIND:-fd}" >/dev/null 2>&1; then
        unset -f hlf
    fi
else
    unset -f hlf
fi

