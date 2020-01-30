#!/bin/bash

read -p "Paste link: " vidlink
youtube-dl -x --audio-format mp3 --exec 'sudo cp {} /mnt/c/Users/katak/OneDrive/Musik && rm {}' $vidlink
