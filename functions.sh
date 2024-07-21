#! /bin/zsh -
green=$(tput setaf 2)
yellow=$(tput setaf 3)
magenta=$(tput setaf 5)
blue=$(tput setaf 6)
normal=$(tput sgr0)

export EVENT_NAME=$(cat config.json | jq -r '.event_name')
export EVENT_WEBSITE=$(cat config.json | jq -r '.event_website')

wait_for_presenter () {
    # -i enables increment, -fb enables force back by killing slide
    #printf "Press any key to continue, or b to go back"
    read -n1 -s
    if [[ $REPLY =~ ^b ]]
        then
            # echo "back"
            if [[ $INDEX -gt 0 ]]
            then
                # echo "going back"    
                export INDEX=$(($INDEX-1))
                echo "ack"
                

                if [[ $* == *-fb* ]]
                then
                    exit 3
                    # return 3 to symbolize back functionality
                fi
            fi
    else if [[ $REPLY =~ ^f ]] || [[ $* == *-i* ]]
        then
            # only increment slide if at the end of a slide with the increment flag or using the f key
            export INDEX=$(($INDEX+1))
            if [[ $* == *-fb* ]]
                then
                    exit 4
                    # return 4 to symbolize skip rest of slide functionality
                fi
        fi
    fi
}

doit () {
    eval "$( git push 2>&1 1>/dev/null | grep "git push" | xargs )"
}

title () {
    tput setaf 7
    figlet $@
    tput sgr0
}

heading () {
    printf "\n\n${green}$@${normal}\n"
}

txt () {
    printf "$@\n"
}

ascii () {
    printf "${yellow}$@${normal}\n"
}

that_trees () {
    # easier to put U+1F332 in a file and cat it than get bash to convert it
    tree=$(cat tree.txt)
    printf "\n                                ${normal}< ${tree} ${tree} >${normal}\n"
}

ln () {
    printf "\n"
}

bullet () {
    printf " - $@\n"
}

event () {
    return $EVENT_NAME
}

# echo "Source: $(date +"%T")"

# wait_for_presenter

function joke {
    jokes=(
        "There are 10 kinds of people in this world, those that understand binary and those that do not"
        "You should use darkmode, light attracts bugs"
        "There is a rumor about a gigantic boolean, huge if true"
        "!False, it is funny because it is True."
    )
    size=${#jokes[@]}
    jokeindex=$(jot -r 1 1 $size)
    returnjoke=${jokes[$jokeindex]}

    echo $returnjoke
}

function sjoke {
    # randomvoice
    j=$(joke)
    # say -v $VOICE "I Want to tell a joke."
    # sleep 0.5
    echo $j
    say -v $VOICE $j
}