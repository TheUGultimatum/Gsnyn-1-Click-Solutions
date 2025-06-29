#!/bin/bash

echo ' 

$$$$$$$$\ $$\                 $$\   $$\  $$$$$$\  
\__$$  __|$$ |                $$ |  $$ |$$  __$$\ 
   $$ |   $$$$$$$\   $$$$$$\  $$ |  $$ |$$ /  \__|
   $$ |   $$  __$$\ $$  __$$\ $$ |  $$ |$$ |$$$$\ 
   $$ |   $$ |  $$ |$$$$$$$$ |$$ |  $$ |$$ |\_$$ |
   $$ |   $$ |  $$ |$$   ____|$$ |  $$ |$$ |  $$ |
   $$ |   $$ |  $$ |\$$$$$$$\ \$$$$$$  |\$$$$$$  |
   \__|   \__|  \__| \_______| \______/  \______/ 
                                                  
                                                  
                                                  

                               
         By: The UG            
'






# Update system packages
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof

# Install UFW and allow necessary ports
sudo apt install -y ufw
sudo ufw allow 22
sudo ufw allow 3000/tcp
echo y | sudo ufw enable

# Install cloudflared
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs

# Add Yarn package repository and install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Clone the rl-swarm repository
git clone https://github.com/gensyn-ai/rl-swarm.git

# Navigate to rl-swarm, set up virtualenv, and run project within an isolated bash shell
bash -c "
cd rl-swarm &&
python3 -m venv .venv &&
source .venv/bin/activate &&
cd modal-login &&
yarn install &&
yarn upgrade &&
yarn add next@latest &&
yarn add viem@latest &&
cd .. 
#cd rl-swarm && python3 -m venv .venv && source .venv/bin/activate && ./run_rl_swarm.sh <<< $'Y\nA\n7'
