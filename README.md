You only need resize_sd.sh and install_snapclient.sh

Download both install scripts to a fresh piCore Installation
```
$ wget https://github.com/bjwelker/Snapcast-piCore/raw/master/install_snapclient.sh
$ wget https://github.com/bjwelker/Snapcast-piCore/raw/master/resize_sd.sh
```
Make the script executable
```
$ chmod +x *.sh
```
Run the SD resize so it´s space enough
``` 
$ ./resize_sd.sh
``` 
after reboot run
``` 
$ sudo resize2fs /dev/mmcblk0p2
```
Second run
``` 
$ ./install_snapclient.sh
```
After reboot snapclient should play :)
To switch betwean HDMI and analog output use

HDMI:
```
$ amixer cset numid=3 2
```
Analog:
```
$ amixer cset numid=3 1
```
or just connect to the Webinterface on http://SnapCast-Client-IP