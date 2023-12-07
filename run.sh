#!/bin/sh

echo "Starting processing in directory: /mnt"

# Set the directory to search for .mov, .MOV, .mp4, and .MP4 files
SEARCH_DIR="/mnt"

# Loop through all .mov, .MOV, .mp4, and .MP4 files in the directory and its subdirectories
find "$SEARCH_DIR" -type f \( -iname "*.mov" -o -iname "*.mp4" \) | while read file; do
    # Determine the base file name and extension
    basefile=$(echo "$file" | sed 's/\.\(mov\|mp4\)$//i')
    extension="${file##*.}"
    thumbsheet="${basefile}-thumbsheet-${extension}.jpg"

    echo "Processing file: $file"
    echo "Thumbnail will be saved as: $thumbsheet"

    # Check if the thumbsheet file does not exist
    if [ ! -f "$thumbsheet" ]; then
        echo "Generating thumbnail sheet for: $file"
        vcsi "$file" -o "$thumbsheet" --metadata-font "/usr/share/fonts/ttf-dejavu/DejaVuSans-Bold.ttf" --metadata-font-size "20"
    else
        echo "Thumbnail sheet already exists for: $file"
    fi
done

echo "Processing complete."
exit 0;
