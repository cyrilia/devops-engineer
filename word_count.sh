#!/bin/bash

# Script to count the number of words in a text file

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 ~/Documents/tmp/devops-engineer/word_count.txt"
  exit 1
fi

# Store the file path from the command-line argument
file_path="$1"

# Check if the file exists using the test command
if [ ! -f "$file_path" ]; then
  echo "Error: File not found at $file_path. Creating a new text file..."

  # Create a new text file with some sample content
  echo "Hello, this is a sample text file." > "$file_path"
  echo "Hello, I am creating a sample text file in order to proceed with the bash scripting exercise." >> "$file_path"
fi

# Use cat to display the contents and wc to count words ('wc -w' can count words directly without the need for additional filtering)
word_count=$(cat "$file_path" | wc -w)

# Display the word count
echo "The number of words in $file_path is: $word_count"