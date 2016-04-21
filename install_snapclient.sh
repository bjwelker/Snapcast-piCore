#!/bin/sh
REPOSITORY_AVAHI="http://ralph_irving.users.sourceforge.net/pico"
REPOSITORY_SNAPCAST="https://github.com/bjwelker/Snapcast-piCore/raw/master"
WGET="sudo /bin/busybox wget"
W="/bin/busybox wget"
sudo rm -f /opt/tcemirror
sudo echo "http://distro.ibiblio.org/tinycorelinux/" > /opt/tcemirror
sudo echo "http://ftp.nluug.nl/os/Linux/distr/tinycorelinux/" >> /opt/tcemirror
echo '[ INFO ] Installing Webinterface'
tce-load -wi busybox-httpd
mkdir /home/tc/www
mkdir /home/tc/www/cgi-bin
$W ${REPOSITORY_SNAPCAST}/www/index.html -O /home/tc/www/index.html
$W ${REPOSITORY_SNAPCAST}/www/cgi-bin/api.sh -O /home/tc/www/cgi-bin/api.sh
$WGET ${REPOSITORY_SNAPCAST}/httpd.sh -O /usr/local/etc/init.d/httpd
$W ${REPOSITORY_SNAPCAST}/www/cgi-bin/api.sh -O /home/tc/www/cgi-bin/api.sh
$WGET ${REPOSITORY_SNAPCAST}/scripts/config.cfg -O /usr/local/etc/config.cfg
$WGET ${REPOSITORY_SNAPCAST}/scripts/bootup.sh -O /usr/local/sbin/bootup.sh
sudo chmod +x /usr/local/sbin/bootup.sh
sudo echo "usr/local/sbin/bootup.sh" >> /opt/.filetool.lst
sudo echo "usr/local/etc/config.cfg" >> /opt/.filetool.lst
sudo echo "/usr/local/sbin/bootup.sh" >> /opt/bootlocal.sh
chmod +x /home/tc/www/cgi-bin/api.sh
sudo chmod +x /usr/local/etc/init.d/httpd
sudo echo "usr/local/etc/init.d/httpd" >> /opt/.filetool.lst
sudo echo "/usr/local/etc/init.d/httpd start >/dev/null 2>&1" >> /opt/bootlocal.sh
echo '[ OK ] Installing Webinterface done.'
echo '[ INFO ] Installing ALSA'
tce-load -wi alsa-config
echo '[ OK ] Installing ALSA done.'
sudo mount /mnt/mmcblk0p1/
sudo rm -f /mnt/mmcblk0p1/cmdline.txt
sudo touch /mnt/mmcblk0p1/cmdline.txt
sudo echo "tz=CET-1CEST,M3.5.0,M10.5.0/3 dwc_otg.fiq_fsm_mask=0x7 waitusb=5 dwc_otg.lpm_enable=0 console=ttyAMA0,115200 console=tty1 root=/dev/ram0 elevator=deadline rootwait quiet nortc loglevel=3 noembed smsc95xx.turbo_mode=N noswap nozswap consoleblank=0  host=SnapCast-One" >> /mnt/mmcblk0p1/cmdline.txt
sudo rm -f /tmp/avahi/*
sudo mkdir /tmp/avahi
echo '[ INFO ] Downloading Avahi from Ralphy'\''s repository...'
echo '[ INFO ] Download will take a few minutes. Please wait...'

$WGET -s ${REPOSITORY_AVAHI}/avahi.tcz
        if [ $? = 0 ]; then
                RESULT=0
                echo -n '[ INFO ] Downloading Avahi'
                $WGET ${REPOSITORY_AVAHI}/avahi.tcz -O /tmp/avahi/avahi.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/avahi.tcz.dep -O /tmp/avahi/avahi.tcz.dep
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/avahi.tcz.md5.txt -O /tmp/avahi/avahi.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/dbus.tcz -O /tmp/avahi/dbus.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/dbus.tcz.md5.txt -O /tmp/avahi/dbus.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/expat2.tcz -O /tmp/avahi/expat2.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/expat2.tcz.md5.txt -O /tmp/avahi/expat2.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libattr.tcz -O /tmp/avahi/libattr.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libattr.tcz.md5.txt -O /tmp/avahi/libattr.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libavahi.tcz -O /tmp/avahi/libavahi.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libavahi.tcz.dep -O /tmp/avahi/libavahi.tcz.dep
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libavahi.tcz.md5.txt -O /tmp/avahi/libavahi.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libcap.tcz -O /tmp/avahi/libcap.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libcap.tcz.md5.txt -O /tmp/avahi/libcap.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libcofi.tcz -O /tmp/avahi/libcofi.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libcofi.tcz.md5.txt -O /tmp/avahi/libcofi.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libdaemon.tcz -O /tmp/avahi/libdaemon.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/libdaemon.tcz.md5.txt -O /tmp/avahi/libdaemon.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/nss-mdns.tcz -O /tmp/avahi/nss-mdns.tcz
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                $WGET ${REPOSITORY_AVAHI}/nss-mdns.tcz.md5.txt -O /tmp/avahi/nss-mdns.tcz.md5.txt
                [ $? = 0 ] && echo -n . || (echo $?; RESULT=1)
                if [ $RESULT = 0 ]; then
                        echo '[ OK ] Download Avahi successful.'
                        echo '[ OK ] Downloading Snapcast'
                        $WGET ${REPOSITORY_SNAPCAST}/snapclient.tcz -O /tmp/avahi/snapclient.tcz
                        echo '[ OK ] Download Snapcast successful.'
                        sudo chown -R tc:staff /tmp/avahi/*
                        sudo chmod -R 644 /tmp/avahi/*
                        sudo cp -rp /tmp/avahi/* /mnt/mmcblk0p2/tce/optional
                        sudo echo "avahi.tcz" >> /mnt/mmcblk0p2/tce/onboot.lst
                        #bootlocal AVAHI start
                        echo '[ OK ] Done install Avahi.'
                        sudo echo "snapclient.tcz" >> /mnt/mmcblk0p2/tce/onboot.lst
                        sudo echo "usr/local/etc/init.d/snapclient" >> /opt/.filetool.lst
                        sudo echo "usr/local/etc/snapclient.conf" >> /opt/.filetool.lst
                        tce-load -wi libvorbis
                        tce-load -wi libogg
                        tce-load -wi flac
                        sudo filetool.sh -b
                        echo '[ OK ] Done install Snapcast.'
                        echo '[ OK ] Please reboot your System.'
                else
                        echo '[ ERROR ] Avahi download unsuccessful, try again!'
                fi
        else
                echo '[ ERROR ] Avahi not available in repository, try again later!'
        fi