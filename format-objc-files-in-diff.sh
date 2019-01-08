#!/usr/bin/env bash
# format-objc-files-in-diff.sh
# Formats cached and uncached Objective-C files in the repo in place.
# Copyright 2018 How Else

set -ex
IFS=$'\n'

start_date=$(date +"%s")

export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR"/lib/common-lib.sh

objc_files=$(objc_files_changed)
[ -z "$objc_files" ] && exit 0

echo -e "$objc_files" | xargs -I CMD -P 4 "$DIR"/format-objc-file.sh CMD || fail=yes

[ -z "$fail" ] || exit 1

end_date=$(date +"%s")
time_diff=$(($end_date-$start_date))
echo "$(($time_diff / 60)) minutes and $(($time_diff % 60)) seconds to format objc."

exit 0
