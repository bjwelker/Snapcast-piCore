#!/bin/sh

saveIFS=$IFS
IFS='&'
eval $QUERY_STRING
IFS=$saveIFS
echo "Content-type: text/html"
echo ""
case $q in
        "sound" )
                case $output in
                        "hdmi" )
                                echo "switching to HDMI"
                                amixer cset numid=3 2 >> /dev/null
                                ;;
                        "analog" )
                                echo "switching to 3.5 jack"
                                amixer cset numid=3 1 >> /dev/null
                                ;;
                esac
                ;;
        "system" )
                case $syscmd in
                        "snaprestart" )
                                echo "restarting SnapCast Client"
                                sudo /usr/local/etc/init.d/snapclient restart
                                ;;
                        "restart" )
                                echo "System restarting"
                                sudo reboot
                                ;;
                        "hostname" )
                                echo "setting Hostname to "
                                ;;
                esac
                ;;
esac