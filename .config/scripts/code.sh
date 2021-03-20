#!/usr/bin/env bash

# IF $var == "" go back to fzf
# Create a template for new files


source ~/.config/settings

cd $codedir

# pass an argument to create that file
if [ -n "$1" ]; then
touch $1.cpp
fi

function compile {
clear

# Edit file
nvim $var.cpp

# Compile it
g++ -time -o $var.out $var.cpp

echo -e "\n"
# Execute it
./$var.out

echo -e "\n"
# Wait for user input
read -n 1

# Repeat
compile
}

# If string is greater than 0
# If file $var exists and has write permissions
if [ -n "$var" ] && [ -w $var.cpp ]; then
echo "File exists, editing"
compile

# File Doesn't exist
else

# Ask for file
var=$(ls | grep ".cpp" | sed 's/\..*//g' | fzf --color 16 --ansi --layout=reverse)
compile

fi
