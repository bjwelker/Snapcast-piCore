#!/bin/sh
NAME="httpd"
DESC="Web server"
DAEMON=/usr/local/sbin/busybox-httpd
OPTIONS="-h /home/tc/www"

case "$1" in
    start)
        echo "Starting $DESC: $NAME..."
        start-stop-daemon --start --quiet -b --exec $DAEMON -- $OPTIONS
        ;;
    stop)
        echo "Stopping $DESC: $NAME..."
        start-stop-daemon --stop --quiet --exec $DAEMON
        ;;
    restart)
        echo "Restarting $DESC..."
        start-stop-daemon --stop --quiet --exec $DAEMON
        sleep 3
        start-stop-daemon --start --quiet -b --exec $DAEMON -- $OPTIONS
        ;;
    force)
        echo "Trying to force a restart of $NAME..."
        ps -ef | grep httpd | grep -v grep | awk '{ print $1 }' | xargs kill -9
        sleep 5
        start-stop-daemon --start --quiet -b --exec $DAEMON -- $OPTIONS
        ;;
    status)
        ps -ef | grep $DAEMON | grep -v grep | awk '{ print $0 }'
        ;;
    *)
        echo ""
        echo -e "Usage: /usr/local/etc/init.d/`basename $0` [start|stop|restart|force|status]"
        echo ""
        exit 1
        ;;
esac

exit 0