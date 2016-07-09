#!/bin/bash

$SETTING = /usr/local/nginx/conf/nginx.conf
$USER = ""

echo $(whoami) > $USER

echo "==============================="
echo "   Installazione di DeskCast   "
echo "==============================="

echo "--> Aggiorno e installo le dipendenze..."
#sudo apt-get update
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev

echo "--> Scarico NGINX e il modulo RTMP..."
if [ ! -f "nginx-1.11.2.tar.gz" ]; then
	wget http://nginx.org/download/nginx-1.11.2.tar.gz
fi

if [ ! -f "master.zip" ]; then
	wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
fi

if [ ! -d "nginx-1.11.2" ]; then
	tar -zxvf nginx-1.11.2.tar.gz
fi

if [ ! -d "nginx-rtmp-module-master" ]; then
	unzip master.zip
fi

echo "--> Installo NGINX e il modulo RTMP..."
cd nginx-1.11.2
bash ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install

echo "--> Pulisco le directory..."
#cd ..
#rm -R nginx-1.11.2
#rm -R nginx-rtmp-module-master
#rm nginx-1.11.2.tar.gz
#rm master.zip

echo "--> Edito la configurazione..." 
sudo sed -i 's/user  nobody/user  $USER/' $SETTING #> /usr/local/nginx/conf/nginx.conf
sudo sed -i '118i rtmp {' $SETTING
sudo sed -i '119i server {' $SETTING
sudo sed -i '120i listen 1935;' $SETTING
sudo sed -i '121i chunk_size 128;' $SETTING
sudo sed -i '122i application live {' $SETTING
sudo sed -i '123i live on;' $SETTING
sudo sed -i '124i exec_push omxplayer --live rtmp://localhost:1935/live/stream;' $SETTING
sudo sed -i '125i record off;' $SETTING
sudo sed -i '126i }' $SETTING
sudo sed -i '127i }' $SETTING
sudo sed -i '128i }' $SETTING

echo "--> Imposto avvio automatico..."
sudo bash -c "echo 'sudo /usr/local/nginx/sbin/nginx' > /etc/init.d/nginx"
sudo chmod 775 /etc/init.d/nginx 
sudo /usr/sbin/update-rc.d -f nginx defaults

echo "--> Avvio server..."
sudo /usr/local/nginx/sbin/nginx

exit 0



