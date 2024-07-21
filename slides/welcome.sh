#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./functions.sh

clear
that_trees
title $EVENT_NAME
wait_for_presenter
# brew install figlet
title Welcome to
say Welcome to
#sleep 0.5
title shell_script_101
say shell script 1 O 1!
wait_for_presenter
#sleep 0.5
heading "Agenda"
bullet "What the shell?"
bullet "Variables"
bullet "Common Commands"
bullet "Intro 2 Powershell"
bullet "Profile"
bullet "Kube"
bullet "Streamline Dev"
bullet "Fun and Jokes"
bullet "Prizes!"

wait_for_presenter
heading "https://github.com/CorwinDiamond/shell_script_101"
ln
Lines=$(cat ./ascii/git_hub_qr.txt)
echo "$Lines"
