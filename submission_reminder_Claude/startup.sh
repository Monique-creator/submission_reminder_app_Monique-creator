#!/bin/bash
echo "****************************************"
echo "Starting the Submission Reminder App"
echo "***********************************************"

# Change to the directory where this script is located
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR" || exit

# Check if important files exist
if [[ ! -f config/config.env ]]; then
    echo "config.env file is not found!"
    exit 1
fi

if [[ ! -f assets/submissions.txt ]]; then
    echo "submissions.txt file is not found! Check again!"
    exit 1
fi

# Run reminder app
bash ./app/reminder.sh
