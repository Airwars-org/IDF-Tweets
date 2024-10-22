#!/bin/bash

mkdir -p gifs

for video in videos/*; do
    filename=$(basename -- "$video")
    filename="${filename%.*}"
    
    ffmpeg -i "$video" -vf "fps=8,scale=240:-1:flags=lanczos,palettegen=stats_mode=diff" -y "gifs/$filename-palette.png"    
    ffmpeg -i "$video" -i "gifs/$filename-palette.png" -lavfi "fps=8,scale=240:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=sierra2_4a" -y "gifs/$filename.gif"

    rm "gifs/$filename-palette.png"
done

echo "All videos have been converted to lightweight GIFs and saved in the gifs/ directory."
