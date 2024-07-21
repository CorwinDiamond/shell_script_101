color1=$(tput setaf 6)
color3=$(tput setaf 8)
normal=$(tput sgr0)
echo "${color3}shell_var_scope_demo.sh:  ${color1}export DEMO_VAR=\"Cool\"${normal}"
export DEMO_VAR="Cool"
echo "${color3}shell_var_scope_demo.sh:  ${color1}sh check_var.sh${normal}"
sh check_var.sh
echo "${color3}shell_var_scope_demo.sh:  ${color1}sh var_demo.sh${normal}"
sh var_demo.sh
echo "${color3}shell_var_scope_demo.sh:  ${color1}sh check_var.sh # shell script already exited${normal}"
sh check_var.sh # shell script already exited
