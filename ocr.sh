#!/bin/bash

# temp file for the image
IMG=$(mktemp /tmp/ocr_img_XXXXXX.png)
# pull image from clipboard
xclip -selection clipboard -t image/png -o > "${IMG}"

# run tesseract, output to stdout
tesseract "${IMG}" stdout -l eng  # change language as needed

# clean up
rm "${IMG}"
