
# Information Gathering Script for Hack The Box

## Overview

This script is designed to automate initial information gathering on Hack The Box machines. It performs a fast Nmap scan to identify open ports, runs detailed scans on identified ports, and conducts web reconnaissance using `feroxbuster` and `ffuf`.

## Prerequisites

Ensure the following tools are installed:

- **Nmap:** Network scanning tool
- **Feroxbuster:** Web directory discovery tool
- **FFUF (Fuzz Faster U Fool):** Web fuzzer

Install these tools on Kali Linux using:

```bash
sudo apt update
sudo apt install nmap feroxbuster ffuf
```

## Usage

1. **Run the Script:**

   Execute the script with:

   ```bash
   sudo ./ettscan.sh
   ```

2. **Enter Target Information:**

   - **Target IP:** The IP address of the machine to scan.
   - **Target Name:** A name to label the target and organize output files.

3. **Output Files:**

   The script saves results in a directory named after the target within the specified base directory.

## Script Workflow

1. **Input Gathering:**
   - Prompts for target IP and name.

2. **Directory Setup:**
   - Creates a directory for the target if it doesn't exist.

3. **Initial Nmap Scan:**
   - Conducts a fast scan to identify open ports.

4. **Extract Open Ports:**
   - Parses open ports from the initial scan results.

5. **Detailed Nmap Scan:**
   - Runs a detailed scan on open ports, saving results in Markdown format.

6. **Web Directory Scan:**
   - Uses `feroxbuster` for directory discovery.

7. **Header Fuzzing:**
   - Performs host header fuzzing using `ffuf`.

## Important Notes

- **Permissions:** Run the script with `sudo` to ensure all operations can be performed.
- **Modify Path:** Update the `DIRECTORY` variable in the script to specify where results should be stored.

## Disclaimer

Use this script responsibly and only on systems where you have explicit permission to perform security testing.
