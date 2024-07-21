blue=$(tput setaf 6)
color=$(tput setaf 3)
normal=$(tput sgr0)
echo "${blue}  var_demo.sh:            ${normal}export DEMO_VAR=\"WOW A DEMO\"${normal}"
export DEMO_VAR="WOW A DEMO"
s=$(set | grep DEMO_VAR)
e=$(env | grep DEMO_VAR)
echo "${blue}  var_demo.sh:            ${normal}set | grep DEMO_VAR ${color} ${s} ${normal}"
echo "${blue}  var_demo.sh:            ${normal}env | grep DEMO_VAR ${color} ${e} ${normal}"