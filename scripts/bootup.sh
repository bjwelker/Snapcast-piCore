CONFIGCFG=/usr/local/etc/config.cfg
CONFIGTXT=/mnt/mmcblk0p1/config.txt
CMDLINETXT=/mnt/mmcblk0p1/cmdline.txt
ASOUNDCONF=/etc/asound.conf

#=========================================================================================
# ANSI colours
#-----------------------------------------------------------------------------------------
CRE="$(echo -e '\r\033[K')"
RED="$(echo -e '\033[1;31m')"
GREEN="$(echo -e '\033[1;32m')"
YELLOW="$(echo -e '\033[1;33m')"
BLUE="$(echo -e '\033[1;34m')"
MAGENTA="$(echo -e '\033[1;35m')"

CYAN="$(echo -e '\033[1;36m')"
WHITE="$(echo -e '\033[1;37m')"
NORMAL="$(echo -e '\033[0;39m')"


# Loading configuration file config.cfg
echo -n "${BLUE}Loading configuration file... ${NORMAL}"
. $CONFIGCFG
echo "${GREEN}Done.${NORMAL}"

/sbin/modprobe snd_bcm2835

echo -n "${YELLOW}Waiting for soundcards to populate."
CNT=1
until aplay -l | grep -q PLAYBACK 2>&1
do
        if [ $((CNT++)) -gt 20 ]; then
        echo "${RED} Failed ($CNT).${NORMAL}"
                break
        else
                echo -n "."
                sleep 1
        fi
done
echo "${GREEN} Done ($CNT).${NORMAL}"
# If Custom ALSA settings are used, then restore the settings
echo -n "${BLUE}Starting ALSA configuration... ${NORMAL}"
if [ $ALSAlevelout = Custom ]; then
        alsactl restore
fi

# Check for onboard sound card is card=0 and analog is chosen, so amixer is only used here
aplay -l | grep 'card 0: ALSA'  >/dev/null 2>&1
if [ $? == 0 ] && [ $AUDIO = Analog ]; then
        # Set the analog output via audio jack
        sudo amixer cset numid=3 1 >/dev/null 2>&1
        if [ $ALSAlevelout = Default ]; then
                sudo amixer set PCM 400 unmute >/dev/null 2>&1
        fi
fi

# Check for onboard sound card is card=0, and HDMI is chosen so HDMI amixer settings is enabled
aplay -l | grep 'card 0: ALSA'  >/dev/null 2>&1
if [ $? == 0 ] && [ $AUDIO = HDMI ]; then
        if [ $ALSAlevelout = Default ]; then
                sudo amixer set PCM 400 unmute >/dev/null 2>&1
        fi
        # Set the analog output via HDMI out
        sudo amixer cset numid=3 2 >/dev/null 2>&1
fi
echo "${GREEN}Done.${NORMAL}"

# Unmute IQaudIO amplifier via GPIO pin 22
if [ $AUDIO = I2SpIQAMP ]; then
        echo -n "${BLUE}Unmute IQaudIO AMP... ${NORMAL}"
        sudo sh -c "echo 22 > /sys/class/gpio/export"
        sudo sh -c "echo out >/sys/class/gpio/gpio22/direction"
        sudo sh -c "echo 1 >/sys/class/gpio/gpio22/value"
        echo "${GREEN}Done.${NORMAL}"
fi
# Start the essential stuff for snapcast
echo -n "${YELLOW}Waiting for network."
CNT=1
until ifconfig | grep -q Bcast
do
        if [ $((CNT++)) -gt 20 ]; then
                break
        else
                echo -n "."
                sleep 1
        fi
done
echo "${GREEN} Done ($CNT).${NORMAL}"

/usr/local/etc/init.d/httpd start >/dev/null 2>&1
/usr/local/etc/init.d/avahi start >/dev/null 2>&1
sleep 3
/usr/local/etc/init.d/snapclient start