#!/bin/bash

# Check if a domain was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

# Set the target domain
DOMAIN=$1

# Set the output directory
OUTPUT_DIR="subdomain_screenshots"

# Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir $OUTPUT_DIR
fi

# Run Sublist3r to enumerate the subdomains
echo "Running Sublist3r to enumerate subdomains..."
sublist3r -d $DOMAIN -o subdomains.txt

# Read the subdomains from the file and take a screenshot of each one using Eyewitness
echo "Taking screenshots of identified subdomains using Eyewitness..."
while read subdomain; do
  eyewitness --web -f $subdomain --headless --prepend-https --threads 50 --timeout 30 --no-prompt --simple-report $OUTPUT_DIR
done < subdomains.txt

# Remove the temporary subdomains file
rm subdomains.txt

echo "Done."
