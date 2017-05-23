# ScreenCast-RPi

Stream your desktop to your Raspberry Pi!

## How it works:
**ScreenCast-RPi** use _Nginx_ web server and _RTMP_ module to receive
audio-video stream from any computer. To achieve this, you have to use a software like **OBS - Open Broadcaster Software** , that can capture your desktop and send it over network. OBS is free and cross-platform, available for Windows, Mac OS and Linux.

## How to install:
Simply, launch the setup file and follow the instructions:
```bash
(sudo) bash Setup.sh
```

## Screenshot:
<p align="center">
  <img src="https://s13.postimg.org/y5th5l4af/maxresdefault.jpg"><br>
</p>
</br>
<p align="center">
  <img src="https://s10.postimg.org/4pg8kgwmh/Cattura.png"><br>
</p>

##Tips:
* To **stop** the server:
```bash
(sudo) /usr/local/nginx/sbin/nginx -s stop
```	
##Errors:
* If you get error *98:* _Failed to bind, nginx already in use_, use this:
```bash
(sudo) fuser -k 80/tcp
(sudo) /usr/local/nginx/sbin/nginx -s stop
(sudo) /usr/local/nginx/sbin/nginx"
```
### About:
If you want to donate for support my (future) works, use this: https://www.paypal.me/LCirillo  
I'll appreciate. Also, names of those who donated will be written in an **'Awesome list'** (if you agree).
<p align="center">
  <img src="http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/star-icon.png" width="20">
  Don't forget to leave a Star if this helped you! </b>
  <img src="http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/star-icon.png" width="20">
</p>

If you have any questions, just contact me! Enjoy 🎉