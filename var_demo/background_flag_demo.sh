# 0 2
file_color=$(tput setaf $1)
red=$(tput setaf 1)
temp_file_name="background_flag_demo_$1"
file_name="background_flag_demo_$1"
normal=$(tput setaf $2)
space=""
pause="true"

if [[ $* == *-np* ]]
then
    echo "no pause!!!"
    pause="false"
fi

echo "pause $pause"

if [[ "$pause" == "true" ]]; then sleep 1; fi
# 1 3
list_demo
set_var "DEMO_FLAG_VAR" "WOW_${file_name}_FLAG"
list_demo

if [[ "$pause" == "true" ]]; then sleep 4; fi
# 5 7
list_demo
e=$(env | grep DEMO_FLAG_VAR | grep "$filename")
echo "${file_color}$file_name:$space e=$e"
if [[ $e == *"$file_name"* ]]
then
    echo "${file_color}$file_name:$space DEMO_FLAG_VAR ${normal}=~ $file_name"
else
    echo "${file_color}$file_name:$space DEMO_FLAG_VAR ${normal}!=~ $file_name"
fi
if [[ "$pause" == "true" ]]; then sleep 4; fi
# 9 11

list_demo
check_filename $file_name $temp_file_name "$1" "$2"
set_var "DEMO_RESET_VAR" "Done $file_name"