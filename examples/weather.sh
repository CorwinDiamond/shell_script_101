# Weather API https://www.weather.gov/documentation/services-web-api
# SPS Tower latitude 44.9742612164605, longitude -93.26755068963584
# https://api.weather.gov/points/44.974261,-93.267550
# curl https://api.weather.gov/points/44.974261,-93.267550 | jq .properties.forecast
# https://api.weather.gov/gridpoints/MPX/107,71/forecast
fcast=`curl https://api.weather.gov/gridpoints/MPX/107,71/forecast -s`

fcast_one_daytime=`echo $fcast | jq '.properties.periods' | jq '.[0] | .isDaytime'`
fcast_one_temp=`echo $fcast | jq '.properties.periods' | jq '.[0] | .temperature'`
fcast_one_detailedForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .detailedForecast'`
fcast_one_shortForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .shortForecast'`

fcast_two_daytime=`echo $fcast | jq '.properties.periods' | jq '.[1] | .isDaytime'`
fcast_two_temp=`echo $fcast | jq '.properties.periods' | jq '.[1] | .temperature'`
fcast_two_detailedForecast=`echo $fcast | jq '.properties.periods' | jq '.[1] | .detailedForecast'`
fcast_two_shortForecast=`echo $fcast | jq '.properties.periods' | jq '.[1] | .shortForecast'`

if [[ $fcast_one_daytime == "true" ]]
then
    if [[ $* == *-d*  ]]
    then
        echo "Today: $fcast_one_detailedForecast"
        echo "Tonight: $fcast_two_detailedForecast"
    else
        echo "Today: $fcast_one_shortForecast, High: $fcast_one_temp"
        echo "Tonight: $fcast_two_shortForecast, Low: $fcast_two_temp"
    fi
else
    if [[ $* == *-d*  ]]
    then
        echo "Tonight: $fcast_one_detailedForecast"
        echo "Tomorrow: $fcast_two_detailedForecast"
    else
        echo "Tonight: $fcast_one_shortForecast, Low: $fcast_one_temp"
        echo "Tomorrow: $fcast_two_shortForecast, High: $fcast_two_temp"
    fi
fi
