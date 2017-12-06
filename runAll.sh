#!/bin/bash

function waitProcess {
    while test -d "/proc/$1"; do
	    sleep 1
    done
}

APP_HOME=$(pwd)

APP1="TelegramMQTTBot"
APP2="Http2Mqtt"
PID1="/tmp/${APP1}.pid"
PID2="/tmp/${APP2}.pid"

if test -e "$PID1"; then
    echo "Killing $APP1..."
    kill $(cat "$PID1") ;
    waitProcess $(cat "$PID1")
    rm "$PID1"
fi
if test -e "$PID2"; then
    echo "Killing $APP2..."
    kill $(cat "$PID2");
    waitProcess $(cat "$PID2")
    rm "$PID2"
fi

echo "Starting..."
cd "$APP1/src"
python3 __main__.py resources/settings.json &> "$APP_HOME/telegramMQTTBotLog.txt" &
echo $! > "/tmp/${APP1}.pid"
cd "../../$APP2"
python3 Http2Mqtt.py resources/settings.json &> "$APP_HOME/http2mqttlog.txt" &
echo $! > "/tmp/${APP2}.pid"
echo "Done!"

