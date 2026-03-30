#!/bin/bash
# Script 4: Log File Analyzer
# Author: [Your Name] | Course: Open-Source Software
# Purpose: Analyze log files for errors/warnings
# Usage: ./log_analyzer.sh [logfile] [keyword]

# Default values
LOGFILE=${1:-""}
KEYWORD=${2:-"error"}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to display usage
show_usage() {
    echo "Usage: $0 <logfile> [keyword]"
    echo ""
    echo "Examples:"
    echo "  $0 /var/log/messages"
    echo "  $0 /var/log/dnf.log warning"
    echo "  $0 ~/.config/libreoffice/4/user/log/error.log error"
    echo ""
    echo "If no logfile specified, will attempt to find LibreOffice logs."
}

# Function to find LibreOffice logs
find_libreoffice_logs() {
    LOCAL_CONFIG="$HOME/.config/libreoffice"
    
    if [ -d "$LOCAL_CONFIG" ]; then
        echo -e "${BLUE}🔍 Searching for LibreOffice logs...${NC}"
        LOGS=$(find "$LOCAL_CONFIG" -name "*.log" -type f 2>/dev/null)
        
        if [ -n "$LOGS" ]; then
            echo "Found LibreOffice log files:"
            echo "$LOGS" | while read -r log; do
                echo "  - $log"
            done
            echo ""
            echo "Run with: $0 /path/to/logfile to analyze a specific log"
        else
            echo "No LibreOffice log files found in $LOCAL_CONFIG"
        fi
        return 1
    else
        echo "LibreOffice user configuration not found."
        echo "Run LibreOffice once to create it."
        return 1
    fi
}

# ==========================================
# Main Script
# ==========================================

echo "=========================================="
echo "     LOG FILE ANALYZER"
echo "=========================================="
echo ""

# Check if logfile was provided
if [ -z "$LOGFILE" ]; then
    echo -e "${YELLOW}⚠️  No log file specified.${NC}"
    echo ""
    find_libreoffice_logs
    echo ""
    show_usage
    exit 1
fi

# Check if the log file exists
if [ ! -f "$LOGFILE" ]; then
    echo -e "${RED}Error: File '$LOGFILE' not found.${NC}"
    echo ""
    exit 1
fi

# Check if file is readable
if [ ! -r "$LOGFILE" ]; then
    echo -e "${RED}Error: File '$LOGFILE' is not readable.${NC}"
    echo "Try running with: sudo $0 $LOGFILE"
    exit 1
fi

# Get file info
FILE_SIZE=$(du -h "$LOGFILE" 2>/dev/null | cut -f1)
FILE_LINES=$(wc -l < "$LOGFILE" 2>/dev/null)
FILE_DATE=$(stat -c %y "$LOGFILE" 2>/dev/null | cut -d. -f1)

echo "📄 LOG FILE INFORMATION"
echo "-----------------------"
echo "File Path     : $LOGFILE"
echo "File Size     : $FILE_SIZE"
echo "Total Lines   : $FILE_LINES"
echo "Last Modified : $FILE_DATE"
echo ""

echo "🔍 SEARCH RESULTS"
echo "-----------------"
echo "Keyword       : $KEYWORD"
echo ""

# Count occurrences of keyword (case insensitive)
COUNT=0
LINE_NUMBERS=()

while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
        # Store line numbers for later (optional)
        LINE_NUMBERS+=($COUNT)
    fi
done < "$LOGFILE"

echo -e "${GREEN}Total matches : $COUNT${NC}"
echo ""

if [ $COUNT -gt 0 ]; then
    echo "📋 LAST 5 MATCHING LINES"
    echo "------------------------"
    grep -in "$KEYWORD" "$LOGFILE" | tail -5 | while IFS=: read -r LINE_NUM LINE_CONTENT; do
        echo -e "${YELLOW}[Line $LINE_NUM]${NC} $LINE_CONTENT"
    done
    
    echo ""
    
    # Show first occurrence as well
    echo "📋 FIRST MATCHING LINE"
    echo "----------------------"
    FIRST_MATCH=$(grep -in "$KEYWORD" "$LOGFILE" | head -1)
    if [ -n "$FIRST_MATCH" ]; then
        LINE_NUM=$(echo "$FIRST_MATCH" | cut -d: -f1)
        LINE_CONTENT=$(echo "$FIRST_MATCH" | cut -d: -f2-)
        echo -e "${YELLOW}[Line $LINE_NUM]${NC} $LINE_CONTENT"
    fi
    echo ""
    
    # Do-while style retries for empty file? (File is not empty, but we can demonstrate concept)
    echo "📊 STATISTICS"
    echo "-------------"
    echo "Match density : $(echo "scale=2; $COUNT * 100 / $FILE_LINES" | bc 2>/dev/null)%"
    
    # Check for specific error patterns
    echo ""
    echo "📌 COMMON PATTERNS IN THIS LOG"
    echo "------------------------------"
    
    # Check for crash patterns (common in LibreOffice)
    if grep -iq "crash\|segfault\|abort\|assert" "$LOGFILE" 2>/dev/null; then
        CRASH_COUNT=$(grep -ic "crash\|segfault\|abort\|assert" "$LOGFILE")
        echo "   Crashes/segfaults : $CRASH_COUNT"
    fi
    
    # Check for permission issues
    if grep -iq "permission\|denied\|access" "$LOGFILE" 2>/dev/null; then
        PERM_COUNT=$(grep -ic "permission\|denied\|access" "$LOGFILE")
        echo "   Permission issues : $PERM_COUNT"
    fi
    
    # Check for network issues
    if grep -iq "network\|connection\|timeout\|socket" "$LOGFILE" 2>/dev/null; then
        NET_COUNT=$(grep -ic "network\|connection\|timeout\|socket" "$LOGFILE")
        echo "   Network issues    : $NET_COUNT"
    fi
    
else
    echo -e "${GREEN}✅ No matches found for '$KEYWORD' in $LOGFILE${NC}"
fi

echo ""
echo "=========================================="
echo "     ANALYSIS COMPLETE"
echo "=========================================="
