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
