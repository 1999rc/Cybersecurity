#!/bin/bash 

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/system.log"

mkdir -p "$LOG_DIR"

echo "===== $(date) =====" >> "$LOG_FILE"
echo "Uptime:" >> "$LOG_FILE"
uptime >> "$LOG_FILE"

echo "Memory:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "Top Processes:" >> "$LOG_FILE"
ps -eo pid,comm,%cpu,%mem --soft=-%cpu | head -6 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"