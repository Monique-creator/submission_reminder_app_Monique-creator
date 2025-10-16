#!/bin/bash

# *********************************************
# Copilot Shell Script
# *********************************************

# Path to the config file
DIR=$(ls -td submission_reminder_*/ | head -n 1)
CONFIG_FILE="$DIR/config/config.env"
chmod +w "$CONFIG_FILE"


#Validate the existance of config file

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file not found at $CONFIG_FILE"
    exit 1
fi

# Prompt user for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Check if the input is not empty
if [[ -z "$new_assignment" ]]; then
    echo "Error: Assignment name cannot be empty!"
    exit 1
fi

# Use sed to replace the current assignment in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

# Confirmation message
echo "Assignment name changed successfully in $CONFIG_FILE"
echo "********************************************"
echo "****************************************"
echo "New assignment: $new_assignment"
echo "--------------------------------------------"

# Rerun the startup script
echo "Re-running the Submission Reminder App..."
echo "****************************************"
bash "$DIR/startup.sh"
