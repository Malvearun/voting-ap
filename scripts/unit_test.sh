#!/bin/bash

echo "Running unit tests..."

# Install dependencies
pip install -r requirements.txt

# Run unit tests using pytest
pytest --maxfail=1 --disable-warnings -q

if [ $? -eq 0 ]; then
    echo "Unit tests passed!"
else
    echo "Unit tests failed!"
    exit 1
fi
