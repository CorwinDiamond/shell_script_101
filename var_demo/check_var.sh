color=$(tput setaf 3)
color2=$(tput setaf 12)
normal=$(tput sgr0)
s=$(set | grep DEMO_VAR)
e=$(env | grep DEMO_VAR)
echo "${color2}  check_var.sh:           ${normal}set | grep DEMO_VAR ${color} ${s} ${normal}"
echo "${color2}  check_var.sh:           ${normal}env | grep DEMO_VAR ${color} ${e} ${normal}"