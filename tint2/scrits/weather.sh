#! /bin/bash

CITY=3462377
API_KEY=d77255803532af0e00d3b524118eb67b
WEATHER=/tmp/weather.json

if ! command -v jq >> /dev/null; then
    echo "Need jq"
    exit 1
fi

wget -q -O $WEATHER "http://api.openweathermap.org/data/2.5/weather?id=${CITY}&units=metric&APPID=${API_KEY}"

wait

condition="$(cat $WEATHER | jq '.weather[].main')"

temperature="$(cat $WEATHER | jq '.main.temp' )"

humidity="$(cat $WEATHER | jq '.main.humidity' )"

wind="$(cat $WEATHER | jq '.wind.speed' )"


if grep -qi 'Rain' <<< $condition; then
    icon="⛆"
elif grep -qi 'Storm' <<< $condition; then
    icon="⛈"
elif grep -qi 'Cloud' <<< $condition; then
    icon="⛅"
elif grep -qi 'Clear' <<< $condition; then
    icon="☼"
elif grep -qi 'Snow' <<< $condition; then
    icon="⛄"
else
    icon=$condition
fi

firstline="${icon} ${temperature}°C "

echo "${firstline:0:12}"
