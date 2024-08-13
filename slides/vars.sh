#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./demo-magic.sh

clear
title Variables
txt "Like most scripting/programing languages, there are variables"
ln
heading "Context"
txt "The scope of a variable is determianed during initialization or the first use."
txt "Environmental variables can be read if they were initialized in the shell, or sourced."
txt "Sharing environmental variables between shells... Do we really want that..."
ln
wait_for_presenter -fb
heading "Source vs Execution"
txt "Source                         |   Execution"
txt "$ source script.sh args        |   $ bash script.sh args"
txt "$ . script.sh args             |   $ sh script.sh args"
txt "                               |   $ ./script.sh args   # chmod"
txt "Returns                        |   Exits"
txt 'env "updated"                  |   env "updates" are lost on exit'
ln
txt "Let's try it"
cd ./var_demo
ln

wait_for_presenter -fb
heading "Execution: Shell script exits without persisting variables"
echo "sh shell_var_demo.sh"
sh shell_var_demo.sh
ln

wait_for_presenter -fb
heading "Source: script exits with variables persisted"
echo "sh source_var_demo.sh"
sh source_var_demo.sh
ln

wait_for_presenter -fb
heading "Source: script overwrites variables"
echo "sh source_var_scope_demo.sh"
sh source_var_scope_demo.sh
ln

wait_for_presenter -fb
heading "Exection: script overwrites variable but change is not persisted"
echo "sh shell_var_scope_demo.sh"
sh shell_var_scope_demo.sh
ln

wait_for_presenter -fb
heading "Background Processes &"
txt "Running a script in the background causes even more complex behaviors I am not ready to explain."
wait_for_presenter -fb
txt "Who wants ./shell_script_102 ?"
wait_for_presenter -fb
txt "Examples will be availible in the presentation repo..."
# wait_for_presenter -fb
# heading "Variable Overwriting with source scripts waiting on env flags"
# echo "sh source_var_scope_demo2.sh"
# sh source_var_scope_demo2.sh
# ln
# wait_for_presenter -fb
ln
ln
heading "This is a tough slide to remember; I have relearn this concept every year."