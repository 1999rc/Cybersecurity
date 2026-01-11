#!/bin/bash

echo "===== SYSTEM MONITOR ===="
echo "Date:$(date)"
echo "Uptime:"
uptime 


echo 
echo "CPU Load:"
top bn1 | grep "Cpu(s)"


echo 
echo "Memory Usage:"
free -h 


echo 
echo "Disk Usage:"
df -h 
