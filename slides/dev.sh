#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./demo-magic.sh
clear
# brew install figlet
title Dev
ln
ascii "make run"
ascii "....Tooo many errors: Have you tried Stack Overflow?"
ln
heading "Make"
bullet "makefiles are equivalent to syntactic sugar shell scripts"
bullet "package long processes and loops into shell scripts"
heading "CI"
bullet "CI can run shell scripts"
bullet "Sets of functions and cleanup can be combined into shell functions"
bullet "Populating a \"local\" db with fake data is easy with a script"
ln
ln
heading "Clear Check"
txt "My current team has a shell script to go through all of our k8s clusters and opens all of our dashboards."
txt "Engineers are able to review the information faster as part of the clear check proceedure for Cyber Week."
ln
ln
heading "Demo clear_check.sh"
wait_for_presenter
pe "bash ./examples/clear_check.sh -demo"    