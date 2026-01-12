#!/usr/bin/env bash 
set -euo pipefail 
CPU_THRESHOLD=80
DISK_THRESHOLD=80
#------------------
#Paths
#------------------
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/system_$(date +%F).log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"
#-------------------------------
#Logger
#-------------------------------

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')]$1" >> "$LOG_FILE"
}
#------------------------------------
#Os Detection
#------------------------------------

OS_TYPE="Unknown"
KERNIL="$(uname -r)"

if [[ "$(uname -s)" == "Linux" ]]; then
    if grep -qi microsoft /proc/version; then 
       OS_TYPE="WSL"
    else 
       OS_TYPE="Linux"
    fi 
elif [[ "$(uname -s)" == "Darwin" ]]; then 
    OS_TYPE="macOS"
fi 


echo "===================================" >> "$LOG_FILE"
log "Operating Sytem:$OS_TYPE"
log "kernil:$KERNIL"
echo "===================================" >> "$LOG_FILE"

#---------------------------------
#Header
#---------------------------------
log "CPU Usage:"
if [[ "$OS_TYPE" == "Linux" || "$OS_TYPE" == "WSL" ]]; then 
    grep '^cpu' /proc/stat >> "$LOG_FILE"
else 
   log "CPU stats not supported on this OS"
fi 

#---------------------------------
#CPU
#---------------------------------
log "CPU Load Average:"
uptime | awk -F'load avrage:' '{print $2}' >> "$LOG_FILE"


CPU_USAGE=$(top -bn1 | grep "Cpu(S)" | awk '{print 100 -$8}')

if ((${CPU_USAGE%.*} > CPU_THRESHOLD)); then 
   echo "WARNING:High CPU usage detected:${CPU_USAGE}%" >> "$LOG_FILE"
fi

#---------------------------------
#Memory
#---------------------------------
log "Disk Usage:"
df -h / >> "$LOG_FILE"

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if ((DISK_USAGE > DISK_THRESHOLD)); then 
   echo "WARNING:High Disk usage detected:$ {DISK_USAGE}%" >> "$LOG_FILE"
fi 
#---------------------------------
#Top processes
#---------------------------------
log "Top Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
LOG_RETENTION_DAYS=7

find "$LOG_DIR" -type f -name "*.log" -mtime + $LOG_RETENTION_DAYS -exec rm -f {} \;

log "Old logs cleanup completed! (>$ {LOG_RETENTION_DAYS} days)
