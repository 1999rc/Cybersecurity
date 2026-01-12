#!/usr/bin/env bash 
set -euo pipefail 

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


#---------------------------------
#Memory
#---------------------------------
log "Disk Usage:"
df -h / >> "$LOG_FILE"

#---------------------------------
#Top processes
#---------------------------------
log "Top Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
