#!/bin/bash

# *********************************************
# *************************************************
# create_environment.sh

# Prompt the user to enter their name
read -p "Enter your name: " username

# Define the base directory
main_dir="submission_reminder_${username}"

# Create subdirectories
mkdir -p "$main_dir"/{app,modules,config,assets}

# **********************************
# Create config.env file
cat << 'EOF' > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# **********************************************
# Create submissions.txt file
cat << 'EOF' > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
John, Shell Navigation, not submitted

#Additional students
Angelo, Git, not submitted
Innocent, Shell Navigation, submitted
Umuton, Shell Basics, submitted
Ineza, Shell Navigation, not submitted
Umutesi, Git, submitted
EOF

# *************************************************
# Create functions.sh file
cat << 'EOF' > "$main_dir/modules/functions.sh"
#!/bin/bash

check_submissions() {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and read each line
    while IFS=, read -r student assignment status; do
        # Remove extra spaces
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if student has not submitted the current assignment
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF

# ******************************************
# Create reminder.sh file.
cat << 'EOF' > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# ****************************************
# Create startup.sh file.
cat << 'EOF' > "$main_dir/startup.sh"
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
EOF

# *************************************
# Give execution permissions
chmod +x "$main_dir"/app/*.sh
chmod +x "$main_dir"/modules/*.sh
chmod +x "$main_dir"/startup.sh

# *************************************************
# Final message
echo "Environment setup is ready now!"
echo "****************************************"
echo "******************************************"
echo "Directory created: $main_dir"
echo "To start the app, run:"
echo "cd $main_dir && ./startup.sh"





























