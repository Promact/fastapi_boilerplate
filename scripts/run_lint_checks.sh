#!/usr/bin/env bash

set -e

echo "Running code checks..."

# Determine Python command
if command -v python3 &> /dev/null; then
    PYTHON=python3
elif command -v python &> /dev/null; then
    PYTHON=python
else
    echo "Error: Python not found. Please install Python 3."
    exit 1
fi

# Function to run checks
run_check() {
    if command -v "" &> /dev/null; then
        echo "Running ..."
        ""
    else
        echo "Warning:  not found. Skipping."
    fi
}

# Change to the project root directory
cd "./.."

# Ensure pyproject.toml exists
if [ ! -f pyproject.toml ]; then
    echo "Error: pyproject.toml not found in the project root."
    exit 1
fi

# Run Black
run_check black --config pyproject.toml .

# Run Ruff
run_check ruff check --config pyproject.toml .

# Run mypy
run_check mypy --config-file pyproject.toml .

echo "All checks completed!"

