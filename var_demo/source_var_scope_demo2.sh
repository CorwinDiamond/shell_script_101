color1=$(tput setaf 6)
normal=$(tput sgr0)
color3=$(tput setaf 8)
echo "${color3}source_var_scope_demo.sh: ${color1}export DEMO_VAR=\"Cool\"${normal}"
export DEMO_VAR="Cool"
echo "${color3}source_var_scope_demo.sh: ${color1}sh check_var.sh${normal}"
sh check_var.sh
echo "${color3}source_var_scope_demo.sh: ${color1}. background_var_demo.sh & ${normal}"
. background_var_demo.sh &
echo "${color3}source_var_scope_demo.sh: ${color1}sh check_var.sh # source sript already returned${normal}"
sh check_var.sh # source sript already returned
echo "${color3}source_var_scope_demo.sh: ${color1}. background_flag_demo.sh & ${normal}"