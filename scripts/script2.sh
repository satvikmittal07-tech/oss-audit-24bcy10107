#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Course: Open-Source Software
# Purpose: Check if LibreOffice is installed and display package info

PACKAGE="libreoffice-core"  # Core package name in Fedora

echo "=========================================="
echo "     FOSS PACKAGE INSPECTOR"
echo "     Target: $PACKAGE"
echo "=========================================="
echo ""

# Check if package is installed using rpm
if rpm -q $PACKAGE &>/dev/null; then
    echo "✅ $PACKAGE is INSTALLED on this system"
    echo ""
    echo "Package Details:"
    echo "----------------"
    rpm -qi $PACKAGE | grep -E 'Version|License|Architecture|Vendor|Build Date'
    
    # Get the actual version string
    VERSION=$(rpm -q $PACKAGE | cut -d'-' -f2-3)
    echo ""
    echo "Full Version      : $VERSION"
    
    # Check if running version matches installed
    if command -v libreoffice &>/dev/null; then
        RUNNING_VER=$(libreoffice --version | head -1)
        echo "Running Version   : $RUNNING_VER"
    fi
else
    echo "❌ $PACKAGE is NOT installed on this system"
    echo ""
    echo "To install on Fedora 43, run:"
    echo "  sudo dnf install libreoffice"
    echo ""
    echo "To install the full suite with all components:"
    echo "  sudo dnf install libreoffice-*"
fi

echo ""
echo "=========================================="
echo "     PHILOSOPHY NOTES (by package)"
echo "=========================================="

# Case statement to explain the philosophy behind each package
case "$PACKAGE" in
    libreoffice-core|libreoffice)
        echo ""
        echo "📄 LIBREOFFICE PHILOSOPHY"
        echo "------------------------"
        echo "Born from a community fork in 2010 when Oracle threatened"
        echo "to control OpenOffice.org. The Document Foundation was"
        echo "established to ensure this software remains free forever."
        echo ""
        echo "License: MPL 2.0 (Mozilla Public License)"
        echo "   - File-based copyleft"
        echo "   - Allows commercial partnerships (Collabora, CIB)"
        echo "   - Ensures core improvements remain open"
        echo ""
        echo "Mission: Digital Sovereignty"
        echo "   - Your documents stay yours"
        echo "   - No vendor lock-in"
        echo "   - OpenDocument Format (ODF) is ISO standard"
        echo "   - No telemetry, runs locally by default"
        ;;
    httpd)
        echo "🌐 APACHE HTTP SERVER"
        echo "The web server that built the open internet. Apache 2.0 license"
        echo "powers ~30% of websites globally."
        ;;
    mysql)
        echo "🗄️ MYSQL"
        echo "Open-source database at the heart of millions of applications."
        echo "Dual-licensed: GPL for open source, commercial for proprietary."
        ;;
    vlc)
        echo "🎬 VLC MEDIA PLAYER"
        echo "\"Plays anything\" — built by students in Paris. LGPL/GPL licensed."
        echo "Supports virtually every media format without codec packs."
        ;;
    firefox)
        echo "🦊 FIREFOX"
        echo "A non-profit fighting for an open web. MPL 2.0 licensed."
        echo "Developed by Mozilla Foundation since 2002."
        ;;
    *)
        echo "Package: $PACKAGE"
        echo "No specific philosophy note configured for this package."
        ;;
esac

echo ""
echo "=========================================="
echo "     OPEN-SOURCE PRINCIPLES IN ACTION"
echo "=========================================="
echo "The existence of this package on Fedora 43"
echo "demonstrates that software can be:"
echo "  • Developed by a non-profit (The Document Foundation)"
echo "  • Distributed freely by Fedora"
echo "  • Used without paying subscription fees"
echo "  • Modified to meet specific needs"
echo ""
