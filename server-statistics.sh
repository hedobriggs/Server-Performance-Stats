#!/bin/bash 
echo "==================================================="
echo " SYSTEM RESOURCE MONITORING REPORT " 
echo " $(date '+%Y-%m-%d %H:%M:%S') " 
echo "===================================================" 

echo "Total CPU usage"
echo "======================================================"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}'
echo "=======================================================" 

echo ""
echo "Total memory usage (Free vs Used including percentage)"
echo "======================================================="
mem_used=$(free -m | awk 'NR==2{print $3}')
mem_total=$(free -m | awk 'NR==2{print $2}')
mem_percent=$(free -m | awk 'NR==2{printf("%.2f", $3*100/$2)}')
echo "Used Memory: ${mem_used}MB / ${mem_total}MB (${mem_percent}%)"
echo "========================================================" 

echo " Total disk usage (Free vs Used including percentage)"
echo "======================================================="
df -h | grep "/$" | awk '{print "Used: " $3 " / Total: " $2 " (" $5 " used)"}'
echo "========================================================" 

echo "4. Top 5 processes by CPU usage"
echo "========================================================"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "========================================================" 

echo "5. Top 5 processes by memory usage"
echo "========================================================"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "========================================================"

