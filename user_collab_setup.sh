#!/bin/bash

# Create Users
echo "Creating users..."

for user in emma noah olivia alice bob
do
    sudo useradd -m $user
done

echo "Users created."

# Create Developers Group
echo "Creating developers group..."

sudo groupadd -g 4500 developers

# Add emma and noah as secondary members
sudo usermod -aG developers emma
sudo usermod -aG developers noah

# Set olivia primary group
sudo usermod -g developers olivia

echo "Developers group configured."

# Remove Noah from developers group
echo "Removing noah from developers group..."

sudo gpasswd -d noah developers

echo "Noah removed from developers."

# Create Shared Group
echo "Creating sharedgrp..."

sudo groupadd sharedgrp

sudo usermod -aG sharedgrp alice
sudo usermod -aG sharedgrp bob

# Create Shared Directory
echo "Creating shared folder..."

sudo mkdir -p /home/shared_folder

sudo chgrp sharedgrp /home/shared_folder

# Permissions
sudo chmod 770 /home/shared_folder

# Enable setgid
sudo chmod g+s /home/shared_folder

echo "Shared folder configured."

# Collaboration Test 
echo "Creating test file as alice..."

sudo -u alice touch /home/shared_folder/notes.txt

echo "Adding content as bob..."

sudo -u bob bash -c 'echo "Bob updated the file" > /home/shared_folder/notes.txt'

echo "Content added...."
