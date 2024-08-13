#!/bin/bash
export CURRENT_SLIDE=$$
source ./demo-magic.sh

green=$(tput setaf 2)
normal=$(tput sgr0)

clear
title Common Commands
ln
ascii "   #       "
ascii " #####     #####   ###   #   #   ###  "
ascii " # #       #      #   #  #   #  #   # "
ascii " #####     #####  #      #####  #   # "
ascii "   # #     #      #   #  #   #  #   # "
ascii " #####     #####   ###   #   #   ###  "
ascii "   #             "
ln

function man_txt {
    heading Man
    bullet "Manual"
    bullet "Used to format and display the on-line manual pages"
}

function man_example {
    txt "Corwin, remember to only use q to exit man..."
    pe 'man echo'
}

function grep_txt {
    heading Grep
    bullet "${green}G${normal}lobal ${green}R${normal}egular ${green}E${normal}xpression ${green}P${normal}rint"
    bullet "Used to find matches in files, or output from commands"
}

function grep_example {
    pe 'grep shell slides/welcome.sh'
}

function cat_txt {
    heading Cat
    bullet "Con${green}CAT${normal}inate"
    bullet "Used to view the contents of one or more files"
}

function cat_example {
    pe 'cat * */* | grep shell'
}

function sed_txt {
    heading sed
    bullet "${green}S${normal}tream ${green}ED${normal}itor"
    bullet "Format, filter, map and process input or output"
    bullet "I don't understand this one, but it has been really useful" 
}

function sed_example {
    pe "echo \"Hi $EVENT_NAME. Do you like the graphics?\" | sed -e \"s/hi/\${green}hello world\${normal}/\""
    #pe 'echo "Hi $ENAME. Do you like the graphics?" | sed -e "s/hi/${green}hello world${normal}/"'
}

function xargs_txt {
    heading xargs
    bullet "Useful for executing piped input that required manipulations from sed"
    bullet "Can be used to perform an action on each term in stdout"
}

function xargs_example {
    # prep to make sure there are no files before showing there are no files
    ls | grep xargs_demo | xargs rm -r -f
    pe 'ls | grep xargs_demo'
    pe 'echo "xargs_demo_one xargs_demo_two xargs_demo_three" | xargs mkdir'
    pe 'ls | grep xargs_demo'
    pe 'ls | grep xargs_demo | xargs rm -r -f'
    pe 'ls | grep xargs_demo'
}

function eval_txt {
    heading "eval"
    bullet "${green}EVAL${normal}uate/execute a string"
    bullet "Useful when reserved words are args"
    bullet "Also useful when using variables as args in a shell script"
    bullet "Great way to get to know your security team!"
}

function eval_example {
    # This example section has a lot of escape and special chars that don't print and execute the same way, so this section is slightly faked
    # running these commands in a termial or running examples/eval_demo.sh works.
    # demo-magic p and pe causes issues with local variables
    foo="bar"
    cmd="echo \$foo | sed -e 's/a/4/g' -e 's/e/3/g'"
    p 'foo="bar"'
    p "cmd=\"echo \\\$foo | sed -e 's/a/4/g' -e 's/e/3/g'\""
    p 'echo $cmd'
    txt "echo \$foo | sed -e 's/a/4/g' -e 's/e/3/g'"
    p 'eval $cmd'
    foo="bar"
    cmd="echo \$foo | sed -e 's/a/4/g' -e 's/e/3/g'"
    eval $cmd
    #printable="foo=/"Hello $ENAME/!/""
    # p $printable
    p "foo=\"Hello $EVENT_NAME\""
    p 'eval $cmd'
    foo="Hello $EVENT_NAME"
    cmd="echo \$foo | sed -e 's/a/4/g' -e 's/e/3/g'"
    eval $cmd
    wait_for_presenter
    ln
    txt "What if..."
    txt "foo=\"hello 2>&1 1>/dev/null; cd; rm -r -f;\""
}

function read_txt {
    heading "read"
    bullet "Read in a stream, often for user input"
    bullet "Allows scripts to be interactive"
    bullet "How I wait to advance slides in this presentation"
    bullet "Prompt is differnt for bash and zsh"
}

function read_example {
    # This example 
    p 'read -p "Enter Reply: "'
    read -p "Enter Reply: "
    # Note: demo-magic p and pe overwrites some non-keyword variables that don't have explicit local declarations
    rply=$REPLY
    p 'echo $REPLY'
    echo $rply
}

function jq_txt {
    heading "jq"
    bullet "${green}J${normal}SON ${green}Q${normal}uery"
    bullet "Used for parsing and extracting keys from known json schemas"
    bullet "grep is useful for unkown schemas"
    bullet "Great for creating a CLI weather bug"
}

function jq_example {
    heading "Weather at $EVENT_NAME"
    pe "PUBLIC_IP=\$(curl https://ipinfo.io/ip -s)"
    # PUBLIC_IP=$(curl https://ipinfo.io/ip -s)
    pe "LOCATION_CORDS=\$(curl 'https://ipinfo.io/\$PUBLIC_IP' -s | jq .loc | tr -d '\"' | sed -e 's/\.*0*$//' -e's/\.*0*,/\,/'  )"
    # LOCATION_CORDS=$(curl "https://ipinfo.io/$PUBLIC_IP" -s | jq .loc | tr -d '"' | sed -e 's/\.*0*$//' -e's/\.*0*,/\,/'  )
    pe "FORECAST_URL=\$(curl 'https://api.weather.gov/points/\$LOCATION_CORDS' -s | jq .properties.forecast | tr -d '\"')"
    # FORECAST_URL=$(curl "https://api.weather.gov/points/$LOCATION_CORDS" -s | jq .properties.forecast | tr -d '"')

    p "curl \$FORECAST_URL -s | jq '.properties.periods' | jq '.[0] | .detailedForecast'"
    # I have been having enough issues with all of the calls, that I fake the live demo.
    cat examples/weather.txt
}

function demo_command () {
    local -r cmd_txt="${1}_txt"
    local -r cmd_example="${1}_example"
    $cmd_txt
    wait_for_presenter -fb
    tput smcup
    $cmd_txt
    ln
    txt "Examples:"
    $cmd_example
    wait_for_presenter -fb
    tput rmcup
}

commands=("man" "grep" "cat" "sed" "xargs" "eval" "read" "jq")

wait_for_presenter -fb
for cmd in "${commands[@]}"
do
    demo_command $cmd
done

ln
heading "And many more commands... psuedo and sudo..."

# https://www.educative.io/blog/bash-shell-command-cheat-sheet
