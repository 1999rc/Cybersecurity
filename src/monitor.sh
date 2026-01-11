#!/bin/bash

LOG_DIR="$(pwd)/logs"
LOG_FILE="$LOG_DIR/system.log"

mkdir -p "$LOG_DIR"

echo "=================================" >> "$LOG_FILE"
echo "Timestamp: $(date)" >> "$LOG_FILE"

echo "[CPU]" >> "$LOG_FILE"
uptime >> "$LOG_FILE"

echo "[MEMORY]" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "[DISK]" >> "$LOG_FILE"
df -h 2>/dev/null  >> "$LOG_FILE"

echo "--------------------------------" >> "$LOG_FILE"

