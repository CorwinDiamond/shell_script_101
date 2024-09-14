#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./demo-magic.sh
source ./examples/sample_profile

clear
# brew install figlet
title Jokes
ln
ascii "      ____   "
ascii "     | HA |  "
ascii "     | ___|  "
ascii "   O |/      "
ascii " --+--       "
ascii "   |         "
ascii "  / \         "
ascii "  | |         "
ln
say -v "Daniel" "Who wants to hear a computer tell a joke?"
wait_for_presenter -fb
ln
heading "OK I will show you how it is done on this mac..."
ln
txt 'function joke {'
txt '    jokes=('
txt '        "There are 10 kinds of people in this world, those that understand binary and those that do not"'
txt '        "You should use darkmode, light attracts bugs"'
txt '        "There is a rumor about a gigantic boolean, huge if true"'
txt '    )'
txt '    size=${#jokes[@]}'
txt '    jokeindex=$(jot -r 1 1 $size)'
txt '    returnjoke=${jokes[$jokeindex]}'
ln
txt '    echo $returnjoke'
txt '}'
ln
txt 'function sjoke {'
txt '    j=$(joke)'
txt '    echo $j'
txt '    say $j'
txt '}'
ln
wait_for_presenter
pene "sjoke"
sjoke