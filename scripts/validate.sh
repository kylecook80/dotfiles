#!/usr/bin/env bash

errors=0

. library.sh

initializeANSI

validate()
{
    varname=$1
    varvalue=$2

    if [ ! -z $varvalue ]; then
        if [ "${varvalue%${varvalue#?}}" = "/" ]; then
            if [ ! -x $varvalue ]; then
                error "$varname set to $varvalue, but I cannot find executable."
                (( errors++ ))
            fi
        else
            if ! in_path $varvalue $PATH; then
                error "$varname set to $varvalue, but I cannot find it in PATH."
                errors=$(( $errors + 1))
            fi
        fi
    fi
}

if [ ! -x ${SHELL:?"Cannot proceed without SHELL being defined."} ]; then
    error "SHELL set to $SHELL, but I cannot find that executable."
    errors=$(( $errors + 1 ))
fi

if [ ! -d ${HOME:?"You need to have your HOME set to your home directory"} ]
then
    error "HOME set to $HOME, but it's not a directory."
    errors=$(( $errors + 1 ))
fi

oldIFS=$IFS; IFS=":"

for directory in $PATH
do
    if [ ! -d $directory ]; then
        error "PATH contains invalid directory $directory."
        errors=$(( $errors + 1 ))
    fi
done

IFS=$oldIFS

validate "EDITOR" $EDITOR
validate "MAILER" $MAILER
validate "PAGER" $PAGER

if [ $errors -gt 0 ]; then
    echo "Errors encountered."
else
    echo "Environment is good."
fi

exit 0

