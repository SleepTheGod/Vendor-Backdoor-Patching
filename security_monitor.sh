#!/bin/bash

# Made By Taylor Christian Newsome And Andrew Prendergast

# Define the log file paths
CONNECTION_LOG="/var/log/connection_monitor.log"
ACCESS_LOG="/var/log/httpd/access_log"
SUSPICIOUS_LOG="/var/log/suspicious_requests.log"

# IP address to block
IP_TO_BLOCK="192.168.1.100"

# 1. Monitor new TCP connections on port 443
echo "Monitoring new TCP connections on port 443..."
netstat -tunapl | awk '$4 ~ /:443$/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | while read count ip
do
    if [ "$count" -gt 100 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT: $count connections from $ip" | tee -a "$CONNECTION_LOG"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: $count connections from $ip" >> "$CONNECTION_LOG"
    fi
done

# 2. Parse access logs for suspicious SQL injection attempts
echo "Checking access logs for suspicious SQL injection attempts..."
grep -Ei "union select|select.*from|insert into|delete from|update.*set" "$ACCESS_LOG" > "$SUSPICIOUS_LOG"

if [ -s "$SUSPICIOUS_LOG" ]; then
    echo "Suspicious activity found in access logs:"
    cat "$SUSPICIOUS_LOG"
    # Here, you could add code to send an alert, e.g., via email or a webhook
fi

# 3. Block a specific IP address
echo "Blocking IP address: $IP_TO_BLOCK"
iptables -A INPUT -s "$IP_TO_BLOCK" -j DROP
iptables-save > /etc/iptables/rules.v4
echo "Blocked IP $IP_TO_BLOCK"

# Block a specific IP address
IP_TO_BLOCK="192.168.1.100"

# Add the IP to the firewall rules
iptables -A INPUT -s "$IP_TO_BLOCK" -j DROP

# Save the rules (Debian/Ubuntu specific command)
iptables-save > /etc/iptables/rules.v4

echo "Blocked IP $IP_TO_BLOCK"

# Access log file path
ACCESS_LOG="/var/log/httpd/access_log"

# Look for common SQL injection patterns
grep -Ei "union select|select.*from|insert into|delete from|update.*set" "$ACCESS_LOG" > /var/log/suspicious_requests.log

if [ -s /var/log/suspicious_requests.log ]; then
    echo "Suspicious activity found in access logs:"
    cat /var/log/suspicious_requests.log
    # Here, you could add code to send an alert, e.g., via email or a webhook
fi

# Log file path
LOG_FILE="/var/log/connection_monitor.log"

# Monitor new TCP connections on port 443
netstat -tunapl | awk '$4 ~ /:443$/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | while read count ip
do
    # Simple logic to alert on more than N connections from the same IP
    if [ "$count" -gt 100 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT: $count connections from $ip" | tee -a "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: $count connections from $ip" >> "$LOG_FILE"
    fi
done

# Specify the host to search for
TARGET_HOST="Host: blah.acmecorp.com"
# Specify the network interface to listen on
INTERFACE="eth0"
# Specify the duration to run the capture
DURATION="60" # seconds

# Run tcpdump to capture HTTP packets, adjusting the duration as needed
tcpdump -i $INTERFACE -A -s 0 'tcp port 80' -l -G $DURATION | \
grep --line-buffered -o "$TARGET_HOST" | \
while read -r line ; do
    echo "Match found: $line"
    # Place any actions you want to take here.
    # Note: Dropping the packet or modifying the network traffic from here is not feasible.
done

echo "Capture complete."


