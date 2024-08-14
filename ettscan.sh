#!/usr/bin/env bash


## INFO GATHERING
echo "What is your target IP: "
read IP
echo " " 
echo "What is your target name: "
read SITE
echo " " 

echo "$IP $SITE.htb" >> /etc/hosts 

## MAKE SITE FOLDER
DIRECTORY="/ENTER/PATH/HERE"
site_DIRECTORY="$DIRECTORY/$SITE"

if [ -d "$site_DIRECTORY" ]; then
    echo "$site_DIRECTORY is present"
    echo " " 
else
    echo "Making $site_DIRECTORY."
    mkdir "$site_DIRECTORY"
    echo " " 
fi


## INITAL NMAP SCAN; this is meant to be fast and aggressive
echo "Inital port scanning is starting."
echo " " 
nmap -p- -T 5 -Pn -n -oN $site_DIRECTORY/$SITE.md --disable-arp-ping $IP


## EXTRACT PORTS
open_ports=$(awk '/open/{print $1}' "$site_DIRECTORY/$SITE.md" | sed 's/\/tcp//')


## CHECK IF THERE IS PORTS OPEN
if [ -z "$open_ports" ]; then
    echo "No open ports found in $site_DIRECTORY/$SITE.md"
    exit
fi


## CONVERT OPEN PORTS TO SEPERATED LIST
port_list=$(echo "$open_ports" | tr '\n' ',' | sed 's/,$//')


## DETAILED NNMAP 
echo " " 
echo "Detailed NMAP Scan is taking place on open ports: $port_list"
echo " " 
nmap -p"$port_list" -A -Pn -n --disable-arp-ping -oN $site_DIRECTORY/detail_$SITE.md $IP


## INITIAL DIRECTORY SCAN
echo " " 
echo "Directory scan is starting."
echo " " 
feroxbuster -u http://$SITE.htb -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-med.txt -s 200 --output $site_DIRECTORY/dir_$SITE.json -t 100

## INITAIL Subdomain FUZZING
echo " " 
echo "Subdomain fuzzing is starting."
echo " " 
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -u http://FUZZ.$SITE.htb -mc 200 -o $site_DIRECTORY/subdom_$SITE.json -t 100

## INITAIL HOST HEADER FUZZING
echo " " 
echo "Header fuzzing is starting."
echo " " 
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -u http://$SITE.htb -H "Host: FUZZ.$SITE.htb" -mc 200 -o $site_DIRECTORY/headers_$SITE.json -t 100
