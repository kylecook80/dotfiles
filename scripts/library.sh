#!/usr/bin/env bash

msg()
{
    echo "[ ${lbluef}$1${reset} ]: $2"
}

info()
{
    echo "[ ${lgreenf}INFO${reset} ]: $1"
}

warning()
{
    echo "[ ${lyellowf}WARNING${reset} ]: $1"
}

error()
{
    echo "[ ${lredf}ERROR${reset} ]: $1"
}

initializeANSI()
{
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
}

nicenumber()
{
    integer=$(echo $1 | cut -d. -f1)
    decimal=$(echo $1 | cut -d. -f2)

    if [ "$decimal" != "$1" ]; then
        result="${DD:= '.'}$decimal"
    fi

    thousands=$integer

    while [ $thousands -gt 999 ]; do
        remainder=$(($thousands % 1000))

        while [ ${remainder} -lt 3 ]; do
            remainder="0$remainder"
        done

        result="${TD:=","}${remainder}{result}"
        thousands=$(($thousands / 1000))
    done

    nicenum="${thousands}${result}"
    if [ ! -z $2 ]; then
        echo $nicenum
    fi
}

monthNumToName()
{
    if [ $# -eq 1 ]; then
        set -- $(echo $1 | sed 's/[\/\/-]/ /g')
    fi
    case $1 in
        1 ) month="Jan";; 2 ) month="Feb";;
        3 ) month="Mar";; 4 ) month="Apr";;
        5 ) month="May";; 6 ) month="Jun";;
        7 ) month="Jul";; 8 ) month="Aug";;
        9 ) month="Sep";; 10) month="Oct";;
        11) month="Nov";; 12) month="Dec";;
        * ) echo "$0: Unknown month value $1" >&2
            exit 1
    esac
    return 0
}

normDate()
{
    if [ -z $(echo $1|sed 's/[[:digit:]]//g') ]; then
        monthNumToName $1
    else
        month="$(echo $1|cut -c1|tr '[:lower:]' '[:upper:]')"
        month="$month$(echo $1|cut -c2-3 | tr '[:upper:]' '[:lower:]')"
    fi
    newdate="$month $2 $3"
    return $newdate
}

validAlphaNum()
{
    validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

    if [ "$validchars" = "$1" ]; then
        return 0
    else
        return 1
    fi
}

in_path()
{
    cmd=$1  ourpath=$2  result=1
    oldIFS=$IFS IFS=":"

    for directory in $ourpath
    do
        if [ -x $directory/$cmd ]; then
            result=0
        fi
    done

    IFS=$oldIFS
    return $result
}

checkForCmdInPath()
{
    var=$1

    if [ "$var" != "" ]; then
        if [ "${var%${var#?}}" = "/" ]; then
            if [ ! -x $var ]; then
                return 1
            fi
        elif ! in_path $var "$PATH"; then
            return 2
        fi
    fi
}

