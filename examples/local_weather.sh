# use -d for detailed forcast.


# This script finds the users public ip address.
# Then uses a geolocation service to guess the latitude and longitude of the user.
# Then uses the cordinates to get the forcast from weather.gov
# Some jq magic and conditionals format the output for the next two periods of forcast.

# Weather API https://www.weather.gov/documentation/services-web-api
PUBLIC_IP=$(curl https://ipinfo.io/ip -s)
# echo $PUBLIC_IP
# curl for location cords, jq just the loc property of the json output, remove quotes with tr, remove trailing zeros from coords with sed
LOCATION_CORDS=$(curl "https://ipinfo.io/$PUBLIC_IP" -s | jq .loc | tr -d '"' | sed -e 's/\.*0*$//' -e's/\.*0*,/\,/'  )
# echo $LOCATION_CORDS
# curl "https://api.weather.gov/points/$LOCATION_CORDS"

FORECAST_URL=$(curl "https://api.weather.gov/points/$LOCATION_CORDS" -s | jq .properties.forecast | tr -d '"')
# echo $FORECAST_URL

fcast=`curl $FORECAST_URL -s`

fcast_one_daytime=`echo $fcast | jq '.properties.periods' | jq '.[0] | .isDaytime'`
fcast_one_temp=`echo $fcast | jq '.properties.periods' | jq '.[0] | .temperature'`
fcast_one_detailedForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .detailedForecast'`
fcast_one_shortForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .shortForecast'`

# fcast_two_daytime=`echo $fcast | jq '.properties.periods' | jq '.[1] | .isDaytime'`
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
