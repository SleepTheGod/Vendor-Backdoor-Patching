# Vendor-Backdoor-Patching
Patching Port 443 With EGRESS Filtering from the host domain at the application Layer using TLS
![Uploading image.png…]()


# Security Monitoring Bash Script

This repository contains a Bash script designed for basic security monitoring on Linux servers. Developed by Taylor Christian Newsome and Andrew Prendergast, this script offers functionalities like monitoring TCP connections, parsing access logs for SQL injection attempts, and blocking suspicious IP addresses.

## Features

- **TCP Connection Monitoring**: Monitors new TCP connections on port 443, logging the connection counts from each IP address.
- **SQL Injection Detection**: Parses HTTP access logs for patterns indicative of SQL injection attempts, logging these attempts separately.
- **IP Blocking**: Facilitates blocking of specific IP addresses through `iptables`, mitigating potential threats.

## Prerequisites

To run this script, you must have:
- Access to a Linux server
- Sudo or root privileges for managing firewall rules
- `netstat` and `iptables` installed on your system
- Access logs from an HTTP server, typically found at `/var/log/httpd/access_log`

## Installation

1. Clone the repository to your local machine or server:
   ```bash
   git clone <repository-url>

Navigate to the cloned directory

cd <cloned-directory>

Make the script executable

chmod +x security_monitor.sh

Usage
To run the script, simply execute it with root or sudo privileges

sudo ./security_monitor.sh

The script performs the following actions:

Monitors TCP connections on port 443: Logs are appended to /var/log/connection_monitor.log, with alerts for IPs exceeding 100 connections.

Checks for SQL Injection Attempts: Access logs are parsed, and any suspicious activity is logged to /var/log/suspicious_requests.log.

Blocks a specific IP address (192.168.1.100): This action is logged, and the IP is added to the server's firewall rules to prevent access.

Customization
You can modify the script to monitor different ports, scan for other types of suspicious activities, or block different IP addresses based on your requirements.

Contributing
We welcome contributions to improve this script. Please feel free to fork the repository, make your changes, and submit a pull request.

License
This project is open source and available under the MIT License.

Disclaimer
This script is provided as-is with no warranty. Use it at your own risk. The authors are not responsible for any damages or security breaches that might occur.

Made with ❤️ by Taylor Christian Newsome and Andrew Prendergast


Note: Replace `<repository-url>` and `<cloned-directory>` with the actual URL of your repository and the name of the directory into which you clone the repository, respectively. Additionally, if you're planning to include a LICENSE file (as referenced in the "License" section), ensure it's present in your repository and correctly linked.
