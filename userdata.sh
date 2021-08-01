#!/bin/bash

# install NGINX
yum install nginx -y

# Create SSL conf for NGINX
cat << EOF > /etc/nginx/conf.d/ssl.conf
      server {
        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/selfsigned.crt;
        ssl_certificate_key /etc/nginx/ssl/selfsigned.key;
      }
EOF

# Generate SelfSigned cert for NGINX
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/selfsigned.key -out /etc/nginx/ssl/selfsigned.crt -subj "/C=US/ST=California/L=SanDiego/O=Org/CN=www.example.com"

# Restart NGINX service
service nginx restart

# Install and configure AWS Cli
yum install unzip -y
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure set aws_access_key_id "<access_key>"
aws configure set aws_secret_access_key "<secret_key>"
aws configure set aws_default_region "sa-east-1"


## Configure NGINX logs upload to S3 bucket
cat << EOF > /etc/nginx/s3-upload.sh
for log in /var/log/nginx/*
do
  /usr/local/bin/aws s3 cp $log s3://xrbispo-s3-nginx/$(date +"%d-%m-%y_%H-%M")/
done
EOF
chmod +x /etc/nginx/s3-upload.sh
echo "2 * * * * root /etc/nginx/s3-upload.sh" >> /etc/crontab
