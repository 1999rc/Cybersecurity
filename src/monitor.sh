#!/bin/bash

LOG_FILE="monitor.log"


echo "[INFO] Monitor started at $(date)" >> $LOG_FILE 

echo "[INFO] Checking disk usage (Memory-optimized mode)..." >> $LOG_FILE 
df -h >> $LOG_FILE 


echo "[INFO] Checking memory usage..." >> $LOG_FILE 
free -h >> $LOG_FILE 

echo "[INFO] Monitor finshed at $(date)" >> $LOG_FILE

