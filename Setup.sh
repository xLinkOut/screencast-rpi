#!/bin/bash

#=========================================================#
# ScreenCast For Raspberry Pi:
#	This script install required software to stream your Desktop 
#	from any computer to your RPi or any Linux machine.
#	It use NGINX and it's RTMP Module to start a web 
#	server and get audio-video stream from other computers.
#
#	To stream your desktop use OBS, Open Broadcaster 
#	Softwate, available for Windows, Mac and Linux.
#	https://obsproject.com/download -> Studio Version.
#
#	This module doesn't have lag (less than 1 sec) but using 
#	other software or a 100mbps lan can increase latency up to
#	5/6 second.
#===========================================================#
echo "==================================="
echo "   Installing ScreenCast for RPi   "
echo "==================================="

echo "--> Install/Update required software..."
sudo apt-get update
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev omxplayer

echo "--> Download NGINX and RTMP module..."
if [ ! -f "nginx-1.11.2.tar.gz" ]; then
	wget http://nginx.org/download/nginx-1.11.2.tar.gz -nv
fi

if [ ! -f "master.zip" ]; then
	wget https://github.com/arut/nginx-rtmp-module/archive/master.zip -nv
fi

if [ ! -d "nginx-1.11.2" ]; then
	tar -zxvf nginx-1.11.2.tar.gz
fi

if [ ! -d "nginx-rtmp-module-master" ]; then
	unzip master.zip
fi

echo "--> Install NGINX and RTMP module..."
cd nginx-1.11.2
bash ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install

echo "--> Cleanup..."
cd ..
rm nginx-1.11.2.tar.gz
rm master.zip

echo "--> Setting environment..." 
sudo sed  -i "s/#user nobody/user  $USER/"  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "" 						>> 	"/usr/local/nginx/conf/nginx.conf"
sudo echo -e "rtmp {" 					>>  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\tserver {"				>> 	"/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\tlisten 1935;" 		>> 	"/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\tchunk_size 128;" 		>> 	"/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\tapplication live {" 	>> 	"/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\t\tlive on;" 			>>  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\t\trecord off;" 		>>  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\t\texec_push /usr/bin/omxplayer --live rtmp://localhost:1935/live/stream;" >> "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t\t}" 					>>  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "\t}" 						>>  "/usr/local/nginx/conf/nginx.conf"
sudo echo -e "}" 						>>  "/usr/local/nginx/conf/nginx.conf"

read -p "--> Want to start Nginx with system? (y/n)" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    sudo bash -c "echo 'sudo /usr/local/nginx/sbin/nginx' > /etc/init.d/nginx"
	sudo chmod 775 /etc/init.d/nginx 
	sudo /usr/sbin/update-rc.d -f nginx defaults
fi

read -p "--> Want to start server? (y/n)" -n 1 -r
echo
if [[ ! $REPLY2 =~ ^[Yy]$ ]]
then
	sudo /usr/local/nginx/sbin/nginx
fi

echo "--> Done!"
echo "--> Other instruction, FAQ or commond error on github.com/xLinkOut/ScreenCast-RPi"

exit 0



