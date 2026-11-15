function git
{
    command git "$@" || return $?
    if [[ "$1" = init ]]; then
        # shellcheck disable=SC2034
        PROMPT_OLDPWD=
    fi
}

