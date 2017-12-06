#!/bin/bash

function waitProcess {
    while test -d "/proc/$1"; do
	    sleep 1
    done
}

APP1="TelegramMQTTBot"
APP2="Http2Mqtt"
PID1="/tmp/${APP1}.pid"
PID2="/tmp/${APP2}.pid"

if test -e "$PID1"; then
    echo "Killing $APP1..."
    kill $(cat "$PID1");
    waitProcess $(cat "$PID1")
    rm "$PID1"
fi
if test -e "$PID2"; then
    echo "Killing $APP2..."
    kill $(cat "$PID2");
    waitProcess $(cat "$PID2")
    rm "$PID2"
fi

