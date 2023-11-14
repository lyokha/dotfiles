function prompt_command
{
    if [ "$PROMPT_OLDPWD" != "$PWD" ]; then
        PROMPT_GIT_TOPLEVEL=$(git rev-parse --show-toplevel 2>/dev/null)
        PROMPT_OLDPWD=$PWD
    fi
}

function prompt_gitdir
{
    [ -n "$PROMPT_GIT_TOPLEVEL" ] && echo " 󰊢 ${PROMPT_GIT_TOPLEVEL##*/}"
}

function prompt_wdir
{
    if [ -z "$PROMPT_GIT_TOPLEVEL" ] || [ "$PROMPT_GIT_TOPLEVEL" != "$PWD" ]
    then
        [ "$HOME" = "$PWD" ] && echo " ~" || echo " ${PWD##*/}"
    fi
}

function prompt_line
{
    local DATE_COLOR=$1
    local USER_COLOR=$2
    local AT_COLOR=$3
    local HOST_COLOR=$4
    local GIT_COLOR=$5
    local DIR_COLOR=$6
    local PS2_COLOR=$7

    local N_COLORS
    N_COLORS=$(tput colors 2>/dev/null)

    # BEWARE: values of ${HOSTNAME} and \h may differ (they do in my Fedora 37)
    if (( N_COLORS >= 256 )); then
        local PROMPT_LINE="\
\[\e]0;\u@${HOSTNAME}:\w\a\]\
\[\e[38;5;${DATE_COLOR}m\]\$(date +%d/%m/%y\ %H:%M) \
\[\e[38;5;${USER_COLOR}m\]\u\[\e[38;5;${AT_COLOR}m\]@\
\[\e[38;5;${HOST_COLOR}m\]${HOSTNAME}\
\[\e[38;5;${GIT_COLOR}m\]\$(prompt_gitdir)\
\[\e[38;5;${DIR_COLOR}m\]\$(prompt_wdir) \[\e[0m\] "
        local PROMPT_LINE2="\[\e[38;5;${PS2_COLOR}m\]\[\e[0m\] "
    elif (( N_COLORS >= 8 )); then
        local PROMPT_LINE="\
\[\e[32m\](\$(date +%d/%m/%y\ %H:%M))\[\e[0m\]\
[\u\[\e[1;34m\]@${HOSTNAME}\[\e[0m\] \W]\[\e[31m\]$\[\e[0m\] "
        local PROMPT_LINE2='\[\e[31m\]>\[\e[0m\] '
    else
        local PROMPT_LINE="(\$(date +%d/%m/%y\ %H:%M))[\u@${HOSTNAME} \W]$ "
        local PROMPT_LINE2='> '
    fi

    PS1=$PROMPT_LINE
    PS2=$PROMPT_LINE2

    PROMPT_DIRTRIM=2
    PROMPT_COMMAND=prompt_command
}

prompt_line 167 173 167 140 180 173 196
unset prompt_line

