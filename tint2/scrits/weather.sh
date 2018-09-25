#! /bin/bash

CITY=3462377
API_KEY=d77255803532af0e00d3b524118eb67b
WEATHER=/tmp/weather.json
ICON=/tmp/weather.png

is_day()
{
    hora="$(date +%H)"

    if [[ $hora -ge 06 ]] && [[ $hora -le 18 ]]; then
        true
    else
        false
    fi
}

icon_name()
{
    if [[ "$1" -ge 200 ]] && [[ "$1" -le 299 ]]; then
        icon="11"
    elif [[ "$1" -ge 300 ]] && [[ "$1" -le 399 ]]; then
        icon="09"
    elif [[ "$1" -ge 500 ]] && [[ "$1" -le 599 ]]; then
        icon="10"
    elif [[ "$1" -ge 600 ]] && [[ "$1" -le 699 ]]; then
        icon="13"
    elif [[ "$1" -ge 700 ]] && [[ "$1" -le 799 ]]; then
        icon="50"
    elif [[ "$1" -eq 800 ]]; then
        icon="01"
    elif [[ "$1" -eq 801 ]]; then
        icon="02"
    elif [[ "$1" -eq 802 ]]; then
        icon="03"
    elif [[ "$1" -eq 803 ]] || [[ "$1" -eq 804 ]]; then
        icon="04"
    fi

    if is_day; then
        hora="d"
    else 
        hora="n"
    fi

    icon_file="$icon$hora.png"
    echo $icon_file 
}

if ! command -v jq >> /dev/null; then
    echo "Need jq"
    exit 1
fi

wget -q -O $WEATHER "http://api.openweathermap.org/data/2.5/weather?id=${CITY}&units=metric&APPID=${API_KEY}"
wait

condition="$(cat $WEATHER | jq '.weather[].main')"

id="$(cat $WEATHER | jq '.weather[].id')"

temperature="$(cat $WEATHER | jq '.main.temp' )"

humidity="$(cat $WEATHER | jq '.main.humidity' )"

wind="$(cat $WEATHER | jq '.wind.speed' )"

wget -q -O $ICON "http://openweathermap.org/img/w/$(icon_name $id)"
wait 

firstline="${temperature}°C "

echo "$ICON"
echo "${firstline:0:12}"
