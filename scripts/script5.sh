#!/bin/bash
# Script 5: Open-Source Manifesto Generator
# Author: [Your Name] | Course: Open-Source Software
# Purpose: Generate a personal open-source philosophy statement
# Inspired by: The Document Foundation's mission for LibreOffice

# Colors for better UI
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Clear screen for better presentation
clear

echo -e "${PURPLE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║     OPEN-SOURCE MANIFESTO GENERATOR                          ║"
echo "║     Inspired by LibreOffice & The Document Foundation        ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}This manifesto generator asks you three questions about"
echo "your relationship with open-source software. Your answers"
echo "will be woven into a personal philosophy statement.${NC}"
echo ""
echo "Press Enter to continue..."
read

clear

# ==========================================
# Collect user input
# ==========================================

echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Question 1 of 3${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Name one open-source tool you use every day:${NC}"
echo -e "(Examples: LibreOffice, Firefox, Linux, Git, VLC, GIMP)"
echo ""
read -p "➜ " TOOL
echo ""

echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Question 2 of 3${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}In one word, what does 'freedom' mean to you in software?${NC}"
echo -e "(Examples: choice, transparency, control, privacy, community)"
echo ""
read -p "➜ " FREEDOM
echo ""

echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Question 3 of 3${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Name one thing you would build and share freely:${NC}"
echo -e "(Examples: a document editor, a learning platform, a translation tool)"
echo ""
read -p "➜ " BUILD
echo ""

# ==========================================
# Get current date and user info
# ==========================================
DATE=$(date '+%d %B %Y')
USER_NAME=$(whoami)
HOSTNAME=$(hostname)
DISTRO=$(cat /etc/fedora-release 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)

# ==========================================
# Generate the manifesto
# ==========================================
OUTPUT="manifesto_${USER_NAME}_$(date +%Y%m%d).txt"

cat > "$OUTPUT" << EOF
╔═══════════════════════════════════════════════════════════════════════════╗
║                         OPEN-SOURCE MANIFESTO                             ║
║                         Generated: $DATE                                 ║
║                         By: $USER_NAME @ $HOSTNAME                       ║
║                         System: $DISTRO                                  ║
╚═══════════════════════════════════════════════════════════════════════════╝


MY COMMITMENT

I, $USER_NAME, commit to:
• Using and supporting open-source software where possible
• Sharing my knowledge with others learning to code
• Contributing to at least one open-source project in the coming year
• Advocating for open standards and digital sovereignty

Signed,
$USER_NAME
$DATE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

“Standing on the shoulders of giants, I will help build for those who come
after me.”

EOF

# ==========================================
# Display the result
# ==========================================
clear
echo -e "${GREEN}✅ Manifesto generated successfully!${NC}"
echo ""
echo -e "${YELLOW}Saved to: $OUTPUT${NC}"
echo ""
echo -e "${PURPLE}════════════════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}YOUR OPEN-SOURCE MANIFESTO${NC}"
echo -e "${PURPLE}════════════════════════════════════════════════════════════════════════════${NC}"
echo ""

# Show the manifesto with line numbers for readability
cat "$OUTPUT"

echo ""
echo -e "${PURPLE}════════════════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}Manifesto saved to $OUTPUT in the current directory.${NC}"
echo ""

# ==========================================
# Bonus: Create an alias suggestion
# ==========================================
# The concept of aliases in shell scripting:
# Aliases are shortcuts for commands. This script demonstrates
# how aliases can be created to quickly generate future manifestos.

echo -e "${YELLOW}💡 TIP: Add this alias to your ~/.bashrc for quick manifesto generation:${NC}"
echo -e "   alias manifesto='$PWD/$0'"
echo ""
echo -e "Then run 'source ~/.bashrc' and type 'manifesto' anytime."
echo ""

echo "Press Enter to exit..."
read
