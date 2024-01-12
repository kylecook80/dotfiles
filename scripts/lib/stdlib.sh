#!/usr/bin/env bash

__currdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export PS4=' \[\010\][ ${lcyanf}TRACE${reset} ] (${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"

esc=""

blackf="${esc}[30m"; redf="${esc}[31m"; greenf="${esc}[32m"
yellowf="${esc}[33m"; bluef="${esc}[34m"; purplef="${esc}[35m"
cyanf="${esc}[36m"; whitef="${esc}[37m";

lblackf="${esc}[90m"; lredf="${esc}[91m"; lgreenf="${esc}[92m"
lyellowf="${esc}[93m"; lbluef="${esc}[94m"; lpurplef="${esc}[95m"
lcyanf="${esc}[96m"; lwhitef="${esc}[97m";

blackb="${esc}[40m"; redb="${esc}[41m"; greenb="${esc}[42m"
yellowb="${esc}[43m"; blueb="${esc}[44m"; purpleb="${esc}[45m"
cyanb="${esc}[46m"; whiteb="${esc}[47m"

lblackb="${esc}[100m"; lredb="${esc}[101m"; lgreenb="${esc}[102m"
lyellowb="${esc}[103m"; lblueb="${esc}[104m"; lpurpleb="${esc}[105m"
lcyanb="${esc}[106m"; lwhiteb="${esc}[107m"

boldon="${esc}[1m"; boldoff="${esc}[22m"
italicson="${esc}[3m"; italicsoff="${esc}[23m"
ulon="${esc}[4m"; uloff="${esc}[24m"
invon="${esc}[7m"; invoff="${esc}[27m"

reset="${esc}[0m"

drun()
{
    # Hack to execute arbitrary command
    # if debugging is enabled
    [[ "${DEBUG}" = "T" ]] && "$@" || :
}

debuginfo()
{
    echo "(${BASH_SOURCE[*]}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }"
}

msg()
{
    echo -n "[ ${lbluef}$1${reset} ]: "
    shift
    echo "$@"
}

output()
{
    echo "[ ${lbluef}${__base}${reset} ]: $*"
}

debug()
{
    if [[ "${DEBUG}" = "T" || "${DEBUG}" = "Y" ]]; then
        echo "[ ${lpurplef}DEBUG${reset} ]: $*"
    fi
}

info()
{
    echo "[ ${lyellowf}INFO${reset} ]: $*"
}

warning()
{
    echo "[ ${lyellowf}WARNING${reset} ]: $*"
}

error()
{
    echo "[ ${lredf}ERROR${reset} ]: $*"
}

require_root()
{
    if [[ "$EUID" != "0" ]]; then
        echo "This script requires root privileges."
        exit
    fi
}

_spin()
{
    local i=1
    local sp="/-\|"
    local n=${#sp}
    while true; do
        printf '\b%s' "${sp:i++%n:1}"
        sleep 0.5
    done
}

_prog()
{
    printf " "

    if check_bash_version; then
        _spin &
        progpid=$!
    fi
}

_progend()
{
    if [[ ! -z "${progpid+x}" ]]; then
        kill "${progpid}"
    fi
    printf '\b'
}

task()
{
    TASK_ACTIVE="T"
    echo -n "[ ${lbluef}$1${reset} ]: "
    _prog
}

taskerror()
{
    _progend
    if [[ "${TASK_ACTIVE}" = "T" ]]; then
        echo "${lredf}$1${reset}"
        unset TASK_ACTIVE
    fi
}

taskdone()
{
    _progend
    local msg="Complete"

    if [[ $# -ne 0 ]]; then
        msg=$1
    fi

    if [[ "${TASK_ACTIVE}" = "T" ]]; then
        echo "${lgreenf}${msg}${reset}"
        unset TASK_ACTIVE
    fi
}

run()
{
    if [[ -z "${RUN_STATUS+x}" ]]; then
        echo ""
        msg "COMMAND" "$@"
        "$@" || RUN_STATUS=$?
    fi
}

check()
{
    if [[ "${RUN_STATUS}" = "${1}" ]]; then
        CHECK_ERROR="${1}"

        if [[ "${TASK_ACTIVE}" = "Y" ]]; then
            taskerror "$2"
        else
            error "$2"
        fi
    fi
}

checkdone()
{
    unset RUN_STATUS
}

checkexit()
{
    if [[ ! -z "${CHECK_ERROR}" ]]; then
        _progend
        exit "${CHECK_ERROR}"
    fi
    unset RUN_STATUS
}

# Library-defined
ERROR_DOWNLOAD_FAILED=64
ERROR_EXTRACT_FAILED=65
ERROR_UNKNOWN=120

check_bash_version()
{
    if [ ! "${BASH_VERSINFO:-0}" -ge 4 ]; then
        return 1
    fi
    return 0
}

pushd()
{
    command pushd "$@" > /dev/null || return
}

popd()
{
    command popd > /dev/null || return
}

require()
{
    hash "$1" 2>/dev/null || { echo >&2 "$1 is not installed. Exiting."; exit 1; }
}

download_url()
{
    if hash wget 2>/dev/null; then
        if [[ -n "${1+x}" || -n "${2+x}" ]]; then
            wget -qO - "${1}" > "${2}" || return ${ERROR_DOWNLOAD_FAILED}
        fi
    elif hash curl 2>/dev/null; then
        if [[ -n "${1+x}" || -n "${2+x}" ]]; then
            curl -sL "${1}" > "${2}" || return ${ERROR_DOWNLOAD_FAILED}
        fi
    else
        return "${ERROR_NODOWNLOADER}"
    fi
    return 0
}

extract_archive()
{
    if [[ -n "${1+x}" || -n "${2+x}" ]]; then
        local stat
        pushd "${2}" || return
        stat=$(tar xf "${1}")
        popd || return
        if [[ "${stat}" -gt 0 ]]; then
            return ${ERROR_EXTRACT_FAILED}
        fi
    fi
    return 0
}

# Call within a subshell - $(upper "Text here")
upper()
{
    echo "${1}" | tr "[:lower:]" "[:upper:]"
}

# Call within a subshell - $(lower "TEXT HERE")
lower()
{
    echo "${1}" | tr "[:upper:]" "[:lower:]"
}

unset __currdir

# vim: ai et nu ts=4 sw=4 sts=4 ft=sh :
