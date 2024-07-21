#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./functions.sh

clear
title Profile

ascii "     /////    "
ascii "    / O O     "
ascii "   C   > )    "
ascii "    | --|     "
ascii "   #######    "
ascii " ##########   " 
heading "HAPPY CAMPER"
ln
ln
heading "Shell startup"
bullet "Type defined by shell caller"
bullet "Profile file - default config"
bullet "sanitized version in presentation source code on github."
ln
wait_for_presenter -fb
heading "Ok but what does it do?"
bullet "Highlight current repo"
bullet "Print current branch"
bullet "Print working directory"
ln
wait_for_presenter -fb
heading Demo