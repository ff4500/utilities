#!/usr/bin/env bash

set -o errexit
set -o nounset

input_dir="/media/tomove"

for file in $input_dir/*.* ; do
    dir="${file%.*}"
    mkdir -- "$dir"
    mv -- "$file" "$dir"
done
