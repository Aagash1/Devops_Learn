#!/bin/bash

echo "Creating project_files directory.."
mkdir -p ~/project_files

# Find files larger than 50KB and copy them
echo "Finding files larger than 50KB in /var/log..."

sudo find /var/log -type f -size +50k -exec cp {} ~/project_files/ \;

echo "Files copied successfully."

echo "Setting permissions..."

sudo chmod 640 ~/project_files/*

echo "Permissions updated."

# Display disk usage
echo "Disk usage of ~/project_files:"

sudo du -sh ~/project_files/
