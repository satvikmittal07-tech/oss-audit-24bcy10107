# Open-Source Audit: LibreOffice on Linux Mint 

**Student Name:** Satvik Mittal </br>
**Roll Number:** 24BCY10107 </br>
**Course:** Open-Source Software  </br>
**Date:** March 2026

## Chosen Software
LibreOffice — A free and open-source office suite, developed by The Document Foundation.

## System Details
- Distribution: Linux Mint 
- Kernel: $(satvik -r)
- LibreOffice Version: 26.2.0.3

## File Structure
GitHub Repository Structure
```bash
oss-audit-24BCY10107/
├── README.md
├── Project_Report.pdf
├── scripts/
│   ├── script1.sh
│   ├── script2.sh
│   ├── script3.sh
│   ├── script4.sh
│   └── script5.sh
└── screenshots/
    ├── script1.png
    ├── script2.png
    ├── script3.png
    ├── script4.png
    └── script5.png
```


## Scripts Description

| Script | Purpose | Key Concepts |
|--------|---------|--------------|
| script1.sh | System information report | Variables, command substitution |
| script2.sh | Check LibreOffice installation | rpm queries, case statements |
| script3.sh | Directory permissions audit | For loops, arrays, permissions |
| script4.sh | Log file error analysis | While read loops, grep, counters |
| script5.sh | Interactive philosophy generator | User input, file writing |

## How to Run

### Prerequisites
- Linux Mint  (or any Linux distribution with Bash)
- LibreOffice installed (`sudo dnf install libreoffice`)

### Run Scripts
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run each script
./scripts/script1.sh
./scripts/script2.sh
./scripts/script3.sh
./scripts/script4.sh /var/log/messages
./scripts/script5.sh
```

## Dependencies
-	bash (built-in)
-	apt (Linux Mint/RHEL package manager)
-	grep, awk, cut (standard Unix utilities)
  
## Notes
All scripts are tested on Linux Mint . For other distributions, adjust package manager commands.
This completes the full LibreOffice Audit project for Linux Mint . All scripts are ready to run, and the report provides comprehensive coverage of the origin story, license analysis, ethical reflections, Linux footprint, ecosystem mapping, and comparison with proprietary alternatives.
