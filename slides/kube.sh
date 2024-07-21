#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./functions.sh

clear
title Kubb

ascii "  ..................................... "
ascii "  #                 |                 # "
ascii "                    |               /   "
ascii "  #                 |                 # "
ascii "|                   |                    _"
ascii "  #                 K                   "
ascii "|                   |       /=           "
ascii "  #                 |                 # "
ascii "|                   |                   "
ascii "  #                 |                 # "
ascii "  ..................................... "
heading "Kubb"
ln
wait_for_presenter -fb
heading "...sry..."
wait_for_presenter -fb
ln
title Kube
heading "aws-vault and kubectx k9s magic!"
bullet "On my Work computer, I scripted a lot of kube stuff"
bullet "I don't use any clusters outside of work that I can demo"
ln
wait_for_presenter -fb