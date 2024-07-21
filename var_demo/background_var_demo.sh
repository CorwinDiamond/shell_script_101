file_color=$(tput setaf 6)
color=$(tput setaf 3)
normal=$(tput sgr0)
space=""

file_name="background_var_demo.sh"
bkg_temp_file_name="background_var_demo.sh"

check_filename () {
    if [[ "$1" == "$2" ]]
    then
        echo "${file_color}$1:$space Did not loose filename $3 $4"
    else
        echo "${file_color}$2:$space ${red}lost filename $3 $4"
    fi
}

list_demo () {
    echo "${file_color}$file_name:$space ${normal}list demo set"
    set | grep DEMO
    echo "${file_color}$file_name:$space ${normal}list demo env"
    env | grep DEMO
}

set_var () {
    export $1=$2
    echo "${file_color}$file_name:$space ${normal}setting $1 to $2"
}

echo "${file_color}background_var_demo.sh: ${normal}. background_flag_demo.sh 2 7 & ${normal}"
. background_flag_demo.sh 2 7 &

set_var DEMO_VAR "WOW A DEMO"
list_demo

sleep 2
check_filename $file_name $bkg_temp_file_name "og" "og"
#2

echo "${file_color}background_var_demo.sh: ${normal}. background_flag_demo.sh 3 5 & ${normal}"
. background_flag_demo.sh 3 5 &

sleep 2
check_filename $file_name $bkg_temp_file_name "og" "og"
#4
set_var DEMO_VAR "WOW A BACKGROUND UPDATE"
list_demo

sleep 4
check_filename $file_name $bkg_temp_file_name "og" "og"
#8
set_var DEMO_RESET_VAR "Done"
list_demo

sleep 6
check_filename $file_name $bkg_temp_file_name "og" "og"
#12
list_demo

echo "${file_color}background_var_demo.sh: ${normal}. background_flag_demo.sh 4 8 ${normal}"
. background_flag_demo.sh 4 8 -np

sleep 1
check_filename $file_name $bkg_temp_file_name "og" "og"