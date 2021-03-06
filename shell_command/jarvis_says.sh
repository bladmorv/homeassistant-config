#!/bin/bash
mkdir -pv /tmp/sounds/
if [ ! -f "/tmp/sounds/$1.wav" ]; then
  aws --profile jarvis polly synthesize-speech --output-format mp3 --voice-id Geraint --text "$1" "/tmp/sounds/$1.mp3"
  mpg123 -w "/tmp/sounds/$1.wav" "/tmp/sounds/$1.mp3"
fi
mosquitto_pub -h 192.168.1.19 -t 'hermes/audioServer/default/playBytes/0049a91e-8449-4398-9752-07c0e1858234' -f "/tmp/sounds/$1.wav"
