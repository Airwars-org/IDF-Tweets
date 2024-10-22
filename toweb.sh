#!/bin/bash

input_dir="videos"
output_dir="videos"

for video in "$input_dir"/*.mp4; do
    base_name=$(basename "$video" .mp4)
    
    output_file="$output_dir/$base_name.webm"
    
    if [ -f "$output_file" ]; then
        echo "Skipping $video, $output_file already exists."
        continue
    fi
    
    ffmpeg -i "$video" -c:v libvpx-vp9 -b:v 1M -c:a libvorbis "$output_file"
    
    echo "Converted $video to $output_file"
done
