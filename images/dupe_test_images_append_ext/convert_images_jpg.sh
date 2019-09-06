#!/usr/bin/env bash

input_dir="$HOME/Desktop/convert"
exts="jpg,jpeg,JPG,png,gif"
output_dir="$HOME/Desktop/convert/processed"

if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

for f in $input_dir/*."{$exts}" ; do
  convert "$f" \
    -resize 500x \
    -set filename:fname '%t-x-small' \
    "$output_dir"/'%[filename:fname].jpg'
  convert "$f" \
    -resize 700x \
    -set filename:fname '%t-small' \
    "$output_dir"/'%[filename:fname].jpg'
  convert "$f" \
    -resize 900x \
    -set filename:fname '%t-medium' \
    "$output_dir"/'%[filename:fname].jpg'
  convert "$f" \
    -resize 1000x \
    -set filename:fname '%t-large' \
    "$output_dir"/'%[filename:fname].jpg'
  convert "$f" \
    -resize 1400x \
    -set filename:fname '%t-x-large' \
    "$output_dir"/'%[filename:fname].jpg'
done

# Run the mac ImageOptim app via command line
# Slow. as. hell. Try running imageoptim-cli below instead
# ------------------------------------------------------------------------------
# for f in $output_dir/*.jpg ; do
#   "/Applications/ImageOptim.app/Contents/MacOS/ImageOptim" "$f"
# done

# Run imageoptim-cli
# brew install imageoptim-cli, if you don't already have it
# A little bit faster than running the app, but not much. JPG files are quicker.
# ------------------------------------------------------------------------------
imageoptim $output_dir

# Copy the original image to the processed folder AFTER running imageoptim
# ------------------------------------------------------------------------------
cp $input_dir/*.* $output_dir/
