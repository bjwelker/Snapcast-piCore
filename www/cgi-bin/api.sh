#!/bin/sh
CONFIGCFG=/usr/local/etc/config.cfg
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
                                sudo sed -i "s/\(AUDIO=\).*/\1\"HDMI\"/" $CONFIGCFG
                                ;;
                        "analog" )
                                echo "switching to 3.5 jack"
                                amixer cset numid=3 1 >> /dev/null
                                sudo sed -i "s/\(AUDIO=\).*/\1\"Analog\"/" $CONFIGCFG
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
                                # This will set the hostname next time.
                                sudo sed -i "s/\( host=\)[a-zA-Z0-9\-]*//g" $CMDLINETXT
                                sudo sed -i "1 s/$/ host=$HOST/" $CMDLINETXT
                                ;;
                esac
                ;;
esac