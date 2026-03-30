#!/bin/bash
# Script 1: System Identity Report
# Author: [Your Name] | Course: Open-Source Software
# For: LibreOffice Audit on Fedora 43

# --- Variables ---
STUDENT_NAME="Your Name"
SOFTWARE_CHOICE="LibreOffice"
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')
CURRENT_USER=$(whoami)
HOME_DIR=$HOME
KERNEL_VERSION=$(uname -r)
UPTIME=$(uptime -p)

# --- Get distribution info ---
if [ -f /etc/fedora-release ]; then
    DISTRO=$(cat /etc/fedora-release)
elif [ -f /etc/os-release ]; then
    DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Get license info for Fedora ---
# Fedora uses a mix of licenses, but the kernel is GPL v2
OS_LICENSE="Linux Kernel: GPL v2 | Fedora: Contains MIT, GPL, BSD, and other FOSS licenses"

# --- Display ---
echo "=========================================="
echo "       OPEN SOURCE AUDIT"
echo "       $STUDENT_NAME"
echo "=========================================="
echo ""
echo "SYSTEM IDENTITY REPORT"
echo "----------------------"
echo "Distribution      : $DISTRO"
echo "Kernel Version    : $KERNEL_VERSION"
echo "Current User      : $CURRENT_USER"
echo "Home Directory    : $HOME_DIR"
echo "System Uptime     : $UPTIME"
echo "Current Date/Time : $CURRENT_DATE"
echo ""
echo "LICENSE INFORMATION"
echo "-------------------"
echo "$OS_LICENSE"
echo ""
echo "SOFTWARE AUDIT TARGET"
echo "---------------------"
echo "Chosen Software    : $SOFTWARE_CHOICE"
echo "License            : MPL 2.0 (Mozilla Public License)"
echo "Description        : LibreOffice is a free and open-source office suite,"
echo "                     developed by The Document Foundation. It was forked"
echo "                     from OpenOffice.org in 2010 when Oracle threatened"
echo "                     the project's independence."
echo "=========================================="
