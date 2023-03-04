#!/bin/bash

# Log all output to a file with the current date in the name
LOG_FILE="install_$(date +"%Y-%m-%d").log"
exec &> >(tee -a "$LOG_FILE")

# Download the website code and config file from GitHub
git clone https://github.com/mkassaf/SimpleApacheApp.git

# Check if apache2 is installed, remove the current apache and install apache2 if necessary
if ! command -v apache2 &> /dev/null
then
    echo "apache2 is not installed. Removing old apache and installing apache2..."
    sudo apt-get remove apache2
    sudo apt-get install apache2
fi

# Move website pages to /var/www/SimpleApp
echo "Moving website pages to /var/www/SimpleApp..."
sudo mkdir -p /var/www/SimpleApp
sudo cp -R SimpleApacheApp/App/* /var/www/SimpleApp/

# Move simpleApp.conf to /etc/apache2/sites-available
echo "Moving simpleApp.conf to /etc/apache2/sites-available..."
sudo cp SimpleApacheApp/simpleApp.conf /etc/apache2/sites-available/

# Disable default apache config and enable the new config
echo "Disabling default apache config and enabling the new config..."
sudo a2dissite 000-default
sudo a2ensite simpleApp

# Restart apache2
echo "Restarting apache2..."
sudo systemctl restart apache2

# Verify installation using curl
echo "Verifying installation using curl..."
if curl -Is http://localhost | head -n 1 | grep "HTTP/1.1 200 OK" &> /dev/null
then
    echo "Website is working as expected."
else
    echo "Website is not working as expected."
fi