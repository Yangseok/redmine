#!/bin/bash

#docker usermod
read -p "install now? [y/n] : " yynn
if [ $yynn != 'y' ]
then
  echo "End Script"
  exit 1
fi

read -p "docker command account ex)ubuntu : " account

read -p "select account : "$account"? [y/n] : " yynn
if [ $yynn == 'y' ]
then
  echo "Start Script"
else
  echo "End Script"
  exit 1
fi

# - docker install -
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $account

# - docker compose install -
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo alias dcur=\"cd $HOME/redmine && docker-compose up -d redmine db\" >> ~/.bashrc
echo alias dcdr=\"cd $HOME/redmine && docker-compose down\" >> .bashrc
echo alias dcbr=\"cd $HOME/redmine && docker-compose build redmine db\" >> ~/.bashrc

docker-compose up -d redmine db