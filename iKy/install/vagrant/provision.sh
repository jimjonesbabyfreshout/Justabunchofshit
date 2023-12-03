#!/bin/bash

cd $HOME
mkdir log
mkdir .config
echo "Updating..."
sudo apk —upgrade
sudo apk upgrade 
sudo apk add  build-essential
echo "========================================================================"
echo 

echo "Installing python3.9..."
sudo apk add libffi-dev build-essential libbz2-dev libssl-dev libreadline-dev libsqlite3-dev tk-dev libxml2-dev libxslt1-dev git
sudo apk add software-properties-common

sudo apk —upgrade
sudo apk add python3.9 python3.9-dev
echo "========================================================================"
echo 
 
echo "Installing redis..."
wget -q http://download.redis.io/redis-stable.tar.gz -O redis-stable.tar.gz
tar xvfz redis-stable.tar.gz
cd redis-stable
make
sudo make install
echo 
# echo "Execute redis-server..."
# redis-server > $HOME/log/redis.log 2>&1 &
# cd /home/vagrant
# pwd
# echo "========================================================================"
# echo 

sudo apk add  curl software-properties-common  # 18.04
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
echo
echo "Installing nodejs..."
sudo apk add  nodejs
node -v
npm -v 
echo "========================================================================"
echo

echo "Cloning Repo"
cd $HOME
git clone https://gitlab.com/kennbroorg/iKy.git
cd $HOME/iKy
pwd
sudo apk add  python3-pip
echo "Installing pip and requirements..."
python3.9 -m pip install --upgrade pip
python3.9 -m pip install --user -r requirements.txt
export PATH="/home/vagrant/.local/bin:$PATH"
echo export PATH="/home/vagrant/.local/bin:$PATH" >> ~/.bashrc
echo "========================================================================"
echo 

# echo "Execute celery..."
# cd backend 
# pwd
# ./celery.sh >$HOME/log/celery.log 2>&1 &
# echo "Execute app..."
# python3.9 app.py -i 0.0.0.0 >$HOME/log/app.log 2>&1 &
# # su vagrant -c 'python app.py &'
# echo "========================================================================"
# echo

echo "Installing package from frontend..."
cd $HOME/iKy/frontend
pwd
sed -i -e 's/ng serve/ng serve --host 0.0.0.0/g' package.json
npm install >$HOME/log/npm_install.log 2>&1
# npm start >$HOME/log/npm.log 2>&1 &
sleep 180
tail -n 50 $HOME/log/npm_install.log
