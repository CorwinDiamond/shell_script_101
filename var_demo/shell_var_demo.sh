color1=$(tput setaf 6)
normal=$(tput sgr0)
color2=$(tput setaf 12)
color3=$(tput setaf 8)
echo "${color3}shell_var_demo.sh:        ${color2}sh check_var.sh${normal}"
sh check_var.sh
echo "${color3}shell_var_demo.sh:        ${color1}sh var_demo.sh${normal}"
sh var_demo.sh
echo "${color3}shell_var_demo.sh:        ${color2}sh check_var.sh # shell script already exited${normal}"
sh check_var.sh # shell script already exited