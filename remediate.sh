#!/bin/bash

# Remediation Script for DB Config Issue
# Author: Michael Bubenko

CONFIG_FILE="./config/db.conf"
CORRECT_PORT="5432"

echo "Starting remediation check..."

# 1. Check if the file exists
if [ -f "$CONFIG_FILE" ]; then
    echo "Config file found."
else
    echo "Error: Config file not found!"
    exit 1
fi

# 2. Fix Permissions (Make it writable)
echo "Unlocking file permissions..."
chmod 600 $CONFIG_FILE

# 3. Update the Port using sed (Stream Editor)
# This finds '5433' and replaces it with '5432' automatically
echo "Correcting database port..."
sed -i "s/5433/$CORRECT_PORT/g" $CONFIG_FILE

# 4. Lock Permissions back down (Security Best Practice)
echo "Locking file permissions..."
chmod 400 $CONFIG_FILE

echo "✅ Remediation complete. Configuration updated."
