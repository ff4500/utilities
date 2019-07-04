#!/usr/bin/env bash

input_dir="$HOME/Desktop/Definitely_NOT_Porn"
exts="jpg,jpeg,JPG,png,gif"
output_dir="$HOME/Desktop/notporn_thumbnails"

if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

for notpornimages in $input_dir/*."{$exts}" ; do
  convert "$notpornimages" \
    -thumbnail 250x250^ \
    -gravity center \
    -extent 250x250 \
    -set filename:fname '%t_thumb' \
    "$output_dir"/'%[filename:fname].jpg'
done
