#!/bin/bash
# Install Nginx and start the service
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
