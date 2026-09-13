function hlf
{
    local -a hlopts=()
    local -a files=()

    local group=hlopts

    for arg in "$@"
    do
        if [ "$arg" = '-' ]
        then
            group=files
            continue
        fi

        if [ "$group" = files ]
        then
            files+=(--search-path "$arg")
        else
            hlopts+=("$arg")
        fi
    done

    command fd -H -t file "${files[@]}" | hl -g "${hlopts[@]}"
}

if [ "$TERM" != "linux" ] && [ -n "$HL_ALIASES" ] && [ -f "$HL_ALIASES" ]
then
    # shellcheck disable=SC1090
    . "$HL_ALIASES"
    alias hlg=hlgrep
    if ! command -v fd >/dev/null 2>&1
    then
        unset hlf
    fi
else
    unset hlf
fi

