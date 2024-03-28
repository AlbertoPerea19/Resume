#! /bin/bash

echo "Stoping nginx service"
sudo systemctl stop nginx

echo "Updating repository"
cd Resume/ || exit
git pull

echo "Starting nginx"
sudo systemctl start nginx

echo "Generating Ngrok url"
ngrok http 8080 > /dev/null &

sleep 1
ngrok_url=$(curl -s http://localhost:4040/api/tunnels/ | jq -r .tunnels[0].public_url)

echo "Ngrok url= $ngrok_url"
