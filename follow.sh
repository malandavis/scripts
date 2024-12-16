#!/bin/bash

# Check if at least one argument is passed
if [ $# == 0 ]; then
    echo "Usage: $0 <file> [num_lines]"
    exit 1
fi

file=$1
num_lines=${2:-10}
refresh_rate=${3:-1}


# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Define color codes
DARKGRAY="\033[1;30m"   # Dark gray text (bright black)
GRAY="\033[0;37m"     # Reset to default color

# Hide the cursor (optional, for cleaner output)
tput civis

# Set a trap to show the cursor again when the script exits
trap "tput cnorm" EXIT

# Save the cursor position
tput sc

# Continuously display the last 'num_lines' lines, updating the same region of the screen
while true; do
    # Restore cursor position, clear the lines and output new content
    tput rc
    tput ed
    tail -n $num_lines "$file" | while IFS= read -r line; do
        printf "${DARKGRAY}%s${GRAY}\n" "$line"
    done
    
    # Sleep for the refresh rate
    sleep $refresh_rate
done
