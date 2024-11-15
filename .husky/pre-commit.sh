#!/bin/bash

DIRs=("debian-12" "ubuntu-22-04")

# Flag to track if any ansible-lint failures occur
lint_failures=0

# Iterate over each directory in the array
for DIR in "${DIRS[@]}"; do
  echo "----------------------------------------"
  echo "Checking for changes in directory: $DIR"

  # Check if there are any staged changes in the current directory
  if git diff --cached --name-only | grep --quiet "^$DIR/"; then
    echo -e "\nChanges detected in $DIR. Running ansible-lint..."

    # Navigate to the directory and run ansible-lint
    if (cd "$DIR" && ansible-lint); then
      echo "ansible-lint passed for $DIR."
    else
      echo "ansible-lint failed for $DIR."
      lint_failures=1  # Set flag if linting fails
    fi

  else
    echo "No changes in $DIR. Skipping ansible-lint."
  fi

  echo "----------------------------------------"
done

# Exit with a non-zero status if any ansible-lint failures occurred
if [ "$lint_failures" -ne 0 ]; then
  echo -e "\nPre-commit checks failed. Please fix the linting issues before committing."
  exit 1
else
  echo -e "\nAll pre-commit checks passed successfully."
  exit 0
fi