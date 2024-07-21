color1=$(tput setaf 6)
normal=$(tput sgr0)
color3=$(tput setaf 8)
echo "${color3}source_var_demo.sh:       ${color1}sh check_var.sh${normal}"
sh check_var.sh
echo "${color3}source_var_demo.sh:       ${color1}. var_demo.sh # equivalent to $ source var_demo${normal}"
. var_demo.sh # equivalent to $ source var_demo
echo "${color3}source_var_demo.sh:       ${color1}sh check_var.sh # source sript already returned${normal}"
sh check_var.sh # source sript already returned