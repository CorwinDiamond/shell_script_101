#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./functions.sh

clear
# brew install figlet
title Corwin Diamond
#sleep 0.5
printf "${yellow}"
Lines=$(cat ./ascii/better_headshot.txt)
echo "$Lines"
printf "${normal}"

heading "About me"
bullet "3 years at SPS Commerce"
bullet "2.5 years at Target"
bullet "Starting MSSE at UMN this fall"
bullet "5 years driving and dispatching school buses"
bullet "10 years instructing and guiding rock climbing"
bullet "10+ years camp staff"
bullet "3+ years of my life in a tent"
bullet "Climbed El Capitan twice"
wait_for_presenter -fb
ln
heading "Why shell"
bullet "I don't like to type everything everytime"
bullet "I don't remember commands that well"
bullet "Why type the same commands over and over"
bullet "Add logic to commands"
bullet "Feel like a hacker!!!"
ln
ln
