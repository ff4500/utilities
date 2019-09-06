#!/usr/bin/env bash

# CP and rename files in place, adding site specific extensions

for f in *.png; do
  cp "$f" "${f%.png}-x-small.png"
  cp "$f" "${f%.png}-small.png"
  cp "$f" "${f%.png}-medium.png"
  cp "$f" "${f%.png}-large.png"
  cp "$f" "${f%.png}-x-large.png"
done
