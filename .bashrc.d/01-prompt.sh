function prompt_command
{
    # shellcheck disable=SC2034
    printf -v PROMPT_DATE '%(%d/%m/%y %H:%M)T' -1
    if [[ "$PROMPT_OLDPWD" != "$PWD" ]]; then
        PROMPT_OLDPWD=$PWD
        PROMPT_GITDIR=$(git rev-parse --show-toplevel 2>/dev/null)
        PROMPT_WDIR=
        if [[ "$PWD" = / ]]; then
            PROMPT_WDIR=' /'
        elif [[ -z "$PROMPT_GITDIR" || "$PROMPT_GITDIR" != "$PWD" ]]
        then
            if [[ "$HOME" = "$PWD" ]]; then
                PROMPT_WDIR=' ~'
            else
                # shellcheck disable=SC2034
                PROMPT_WDIR=" ${PWD##*/}"
            fi
        fi
        if [[ -n "$PROMPT_GITDIR" ]]; then
            PROMPT_GITDIR=" 󰊢 ${PROMPT_GITDIR##*/}"
        fi
    fi
    PROMPT_GITDIR_MODIFIED=
    if [[ -n "$PROMPT_GITDIR" ]] && ! git diff --quiet HEAD -- 2>/dev/null
    then
        # shellcheck disable=SC2034
        PROMPT_GITDIR_MODIFIED='*'
    fi
}

function prompt_line
{
    local DATE_COLOR=$1
    local USER_COLOR=$2
    local AT_COLOR=$3
    local HOST_COLOR=$4
    local GIT_COLOR=$5
    local GIT_MODIFIED_COLOR=$6
    local DIR_COLOR=$7
    local PS2_COLOR=$8

    local N_COLORS
    N_COLORS=$(tput colors 2>/dev/null)

    # BEWARE: values of ${HOSTNAME} and \h may differ (they do in my Fedora 37)
    if (( N_COLORS >= 256 )); then
        local PROMPT_LINE="\
\[\e]0;\u@${HOSTNAME}:\w\a\]\
\[\e[38;5;${DATE_COLOR}m\]\${PROMPT_DATE} \
\[\e[38;5;${USER_COLOR}m\]\u\[\e[38;5;${AT_COLOR}m\]@\
\[\e[38;5;${HOST_COLOR}m\]${HOSTNAME}\
\[\e[38;5;${GIT_COLOR}m\]\${PROMPT_GITDIR}\
\[\e[38;5;${GIT_MODIFIED_COLOR}m\]\${PROMPT_GITDIR_MODIFIED}\
\[\e[38;5;${DIR_COLOR}m\]\${PROMPT_WDIR} \[\e[0m\] "
        local PROMPT_LINE2="\[\e[38;5;${PS2_COLOR}m\]\[\e[0m\] "
    elif (( N_COLORS >= 8 )); then
        local PROMPT_LINE="\
\[\e[32m\](\${PROMPT_DATE})\[\e[0m\]\
[\u\[\e[1;34m\]@${HOSTNAME}\[\e[0m\] \W]\[\e[31m\]$\[\e[0m\] "
        local PROMPT_LINE2='\[\e[31m\]>\[\e[0m\] '
    else
        local PROMPT_LINE="(\${PROMPT_DATE})[\u@${HOSTNAME} \W]$ "
        local PROMPT_LINE2='> '
    fi

    PS1=$PROMPT_LINE
    PS2=$PROMPT_LINE2

    PROMPT_DIRTRIM=2
    PROMPT_COMMAND=prompt_command
}

prompt_line 167 173 167 140 180 167 173 196
unset -f prompt_line

