#!/bin/bash

set_output(){
    echo setting ${1}: ${2}

    escaped=${2}
    escaped="${escaped//'%'/'%25'}"
    escaped="${escaped//$'\n'/'%0A'}"
    escaped="${escaped//$'\r'/'%0D'}"

    echo "::set-output name=${1}::${escaped}"
    echo
}

OUTPUT_TAG_CURRENT="tag-current"
OUTPUT_TAG_LAST="tag-last"
OUTPUT_CHANGES_RAW="changes-since-last"
OUTPUT_CHANGES_FORMATTED="changes-formatted"

# current tag
if TAG_CURRENT=$(git describe --tags 2>&-); then
    set_output ${OUTPUT_TAG_CURRENT} "${TAG_CURRENT}"
else
    set_output ${OUTPUT_TAG_CURRENT} "unknown"
fi

# last tag, changes
if TAG_LAST=$(git describe --abbrev=0 ${TAG_CURRENT}^ 2>&-); then
    CHANGES_RAW=$(git --no-pager log --oneline --no-decorate ${TAG_LAST}...HEAD 2>&-)
else
    TAG_LAST="unknown"
    CHANGES_RAW=$(git --no-pager log --oneline --no-decorate 2>&-)
fi

if [ -z "${CHANGES_RAW}" ]; then
    CHANGES_RAW="nothing"
fi

set_output ${OUTPUT_TAG_LAST} "${TAG_LAST}"
set_output ${OUTPUT_CHANGES_RAW} "${CHANGES_RAW}"

# foarmatted changes
CHANGES_FORMATTED=$'## Changes\n\n'

IFS="
"
function format_change
{
    while test $# -gt 0
    do
        CHANGES_FORMATTED="${CHANGES_FORMATTED}- ${1}"
        CHANGES_FORMATTED=${CHANGES_FORMATTED}$'\n'
        shift
    done
}
format_change ${CHANGES_RAW}
unset IFS

set_output ${OUTPUT_CHANGES_FORMATTED} "${CHANGES_FORMATTED}"
