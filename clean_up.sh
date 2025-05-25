#!/bin/bash

# Get the directory to organize; default to the current directory if not provided
directory="/home/user/cp_temp/"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Loop through all files in the directory
for file in "$directory"/*; do
    # Skip if it's not a file
    if [ ! -f "$file" ]; then
        continue
    fi

    # Extract the file extension
    extension="${file##*.}"

    # Skip files without an extension
    if [ "$file" == "$extension" ]; then
        continue
    fi

    # Create the folder if it doesn't exist
    folder="$directory/$extension"
    if [ ! -d "$folder" ]; then
        mkdir "$folder"
    fi

    # Move the file into the folder
    mv "$file" "$folder/"
done

echo "Files have been organized by extension."
