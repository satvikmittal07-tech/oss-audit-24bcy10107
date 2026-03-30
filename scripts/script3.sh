#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Course: Open-Source Software
# Purpose: Audit LibreOffice directories and system directories

# Define directories to audit
SYSTEM_DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")
LIBREOFFICE_DIRS=("/usr/lib64/libreoffice" "/usr/share/libreoffice" "/etc/libreoffice")
USER_CONFIG="$HOME/.config/libreoffice"

# Color codes for better readability (optional, works on Fedora)
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "=========================================="
echo "     DISK AND PERMISSION AUDITOR"
echo "     System: $(hostname)"
echo "     User: $(whoami)"
echo "     Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
echo ""

# ==========================================
# SECTION 1: System Directories Audit
# ==========================================
echo "📁 SYSTEM DIRECTORIES"
echo "===================="
echo ""

for DIR in "${SYSTEM_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Get permissions, owner, group
        PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" 2>/dev/null | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" 2>/dev/null | awk '{print $4}')
        
        # Get disk usage (human readable)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        
        # If du fails (no permission), try df for mount point
        if [ -z "$SIZE" ]; then
            SIZE="(Permission denied or empty)"
        fi
        
        echo "📍 $DIR"
        echo "   Permissions : $PERMS"
        echo "   Owner/Group : $OWNER:$GROUP"
        echo "   Size        : $SIZE"
        echo ""
    else
        echo -e "${RED}📍 $DIR does not exist on this system${NC}"
        echo ""
    fi
done

# ==========================================
# SECTION 2: LibreOffice Directories Audit
# ==========================================
echo "📂 LIBREOFFICE DIRECTORIES"
echo "========================="
echo ""

# Check if LibreOffice is installed first
if ! rpm -q libreoffice-core &>/dev/null; then
    echo -e "${YELLOW}⚠️  LibreOffice is not installed on this system${NC}"
    echo "To install: sudo dnf install libreoffice"
    echo ""
else
    for DIR in "${LIBREOFFICE_DIRS[@]}"; do
        if [ -d "$DIR" ]; then
            PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')
            OWNER=$(ls -ld "$DIR" 2>/dev/null | awk '{print $3}')
            GROUP=$(ls -ld "$DIR" 2>/dev/null | awk '{print $4}')
            SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
            
            echo "📍 $DIR"
            echo "   Permissions : $PERMS"
            echo "   Owner/Group : $OWNER:$GROUP"
            echo "   Size        : $SIZE"
            echo ""
        else
            echo "📍 $DIR does not exist"
            echo ""
        fi
    done
fi

# ==========================================
# SECTION 3: User Configuration Directory
# ==========================================
echo "👤 USER CONFIGURATION"
echo "===================="
echo ""

if [ -d "$USER_CONFIG" ]; then
    echo "✅ User config exists at: $USER_CONFIG"
    PERMS=$(ls -ld "$USER_CONFIG" 2>/dev/null | awk '{print $1}')
    OWNER=$(ls -ld "$USER_CONFIG" 2>/dev/null | awk '{print $3}')
    SIZE=$(du -sh "$USER_CONFIG" 2>/dev/null | cut -f1)
    FILE_COUNT=$(find "$USER_CONFIG" -type f 2>/dev/null | wc -l)
    
    echo "   Permissions : $PERMS"
    echo "   Owner       : $OWNER"
    echo "   Size        : $SIZE"
    echo "   Files       : $FILE_COUNT"
    echo ""
    echo "   Top-level contents:"
    ls -la "$USER_CONFIG" 2>/dev/null | head -8 | tail -5
    echo ""
else
    echo "❌ No LibreOffice user configuration found."
    echo "   Run LibreOffice once to create configuration."
    echo ""
fi

# ==========================================
# SECTION 4: Security Check
# ==========================================
echo "🔒 SECURITY NOTES"
echo "================="
echo ""

# Check if any LibreOffice directory has world-writable permissions
echo "Checking for insecure permissions in LibreOffice directories..."

WORLD_WRITABLE=0
for DIR in "${LIBREOFFICE_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')
        if [[ "$PERMS" == *"w"* && "$PERMS" == *"x"* ]] && [ "$(stat -c %a "$DIR" 2>/dev/null | cut -c3)" -ge 2 ]; then
            echo -e "${RED}⚠️  WARNING: $DIR has world-writable permissions ($PERMS)${NC}"
            WORLD_WRITABLE=1
        fi
    fi
done

if [ $WORLD_WRITABLE -eq 0 ]; then
    echo -e "${GREEN}✅ No world-writable LibreOffice directories found${NC}"
fi

echo ""
echo "=========================================="
echo "     AUDIT COMPLETE"
echo "=========================================="
