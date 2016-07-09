# ScreenCast-RPi

Stream your desktop to Raspberry Pi!

ScreenCast-RPi use Nginx web server and RTMP module to recive
stream from any computer. You can use OBS, cross-platform
software available for Windows, Mac OSX and Linux.

#Some screenshots/photos soon...

#Tips:
	1. To stop server use -> "sudo /usr/local/nginx/sbin/nginx -s stop"
	
#Errors:
	1. If you get error 98 (Failed to bind, nginx already in use):
		"sudo fuser -k 80/tcp; sudo /usr/local/nginx/sbin/nginx -s stop; sudo /usr/local/nginx/sbin/nginx".
		