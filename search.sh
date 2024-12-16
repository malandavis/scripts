#!/bin/bash

# Check if at least one argument is passed
if [ $# -lt 2 ]; then
    echo "Usage: $0 <key> <file> [num_instances] [refresh_rate]"
    exit 1
fi

key=$1
file=$2
num_lines=${3:-5}
refresh_rate=${4:-1}

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

    if grep -q "$key" "$file"; then
        grep "$key" $file | tail -n $num_lines | while IFS= read -r line; do
            printf "${DARKGRAY}%s${GRAY}\n" "$line"
        done
        break  # Break out of the loop once the term is found
    else
        echo -e "\033[1;30mSearching for '$key' in $file...\033[0;37m"
    fi
    
    # Sleep for the refresh rate
    sleep $refresh_rate
done
