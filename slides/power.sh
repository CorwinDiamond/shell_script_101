#!/bin/bash
export CURRENT_SLIDE=$$
source ./demo-magic.sh

# pwd
dir=$(pwd)
wait_for_presenter -fb
clear
pwsh $dir/slides/powercmds.ps1
wait_for_presenter -fb

# https://www.educative.io/blog/bash-shell-command-cheat-sheet
