#! /bin/zsh -
### Modified heavily from https://gist.github.com/kjbrum/77b7af04191267b053e9 by Kyle Brumm
export AWS_DEFAULT_REGION=[insert-region]
# .zshrc file
if [ -f ~/.bash_profile ]; then 
    source ~/.bash_profile;
fi

# Home Directory string for pretty print
RSTRING="~"
# current/default prompt style
export PROMPTSTYLE=5
# contains a space for prompt formating when in a git repo 
export GITSPACE=""
# Default voice for overridden say commands
export VOICE="Samantha"



# this function typically sets environment variables for auth, but this is a demo
assume () {
    echo "assuming account {$1}"
    sleep 0.5
    echo "you now have root access... jk"
}

# checks if you are "working"
test () {
    testcase=$(jot -r 1 0 5)
    case "$testcase" in
        0) echo "Working."
            ;;
        1) echo "Broken!"
            ;;
        2) echo "warp engines are at 50%"
            ;;
        3) echo "This is a test of the emergency broadcast system! If this had been a real emergency you would have heard an audible alert followed by a blue screen."
            ;;
        4) echo "FAIL"
            ;;
        5) echo "PASS"
            ;;
    esac
}

# push unpushed branch with commits
doit () {
    eval "$( git push 2>&1 1>/dev/null | grep "git push" | xargs )"
}

# Get Git repo of current Repository
git_repo () {
    if git rev-parse --git-dir >/dev/null 2>&1
        then echo $(basename $(git remote get-url origin) .git)
    else
        echo ""
    fi
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
        then echo "" # nothing
    else
        if [[ "$STATUS" != *'working tree clean'* ]]
            then echo -e '%F{red}' # red if need to commit
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
                then echo -e '%F{yellow}' # yellow if need to push
            else
                echo -e '%F{green}' # else green
            fi
        fi
    fi
}

# get the name of the current branch
git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# User uses to change prompt style. Use index as an argument or rotate through. Indexes are in promptmsg 
prompt () {
    local errmsg="Error with input args. cmd takes upto one number as an argument: try $ prompt 1     or $ prompt" 
    if [[ $# -lt 1 ]]
        then PROMPTSTYLE=$(( ( $PROMPTSTYLE + 1 ) % 6 ))
    elif [ $# -eq 1 ]
        then 
            if [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null
                then PROMPTSTYLE=$1
            else
                echo $errmsg
            fi
    else
        echo $errmsg
    fi
}

# defines the string for the prompt message displayed on the command line.
promptmsg () {
    gitspace=""
    local dirstring=${$(pwd)/$HOME/$RSTRING}
    local repostring=$dirstring
    if git rev-parse --git-dir >/dev/null 2>&1
        then 
            gitspace=" "
            repo=$(git_repo)
            colorrepo='%F{cyan}'$repo'%f'
            repostring=${dirstring/$repo/$colorrepo}
    fi
    case "$PROMPTSTYLE" in
        0) echo '%F{magenta}'$USER'%f '$repostring' '$(git_color)$(git_branch)$gitspace'%f$ '
            ;;
        1) echo $(git_repo)$gitspace$(git_color)$(git_branch)$gitspace'%f$ '
            ;;
        2) echo '%F{magenta}'$USER' %f$ '
            ;;
        3) echo '%f$ '
            ;;
        4) echo '%f'$repostring' %f$ '
            ;;
        5) echo '%f'$repostring' '$(git_color)$(git_branch)$gitspace'%f$ '
            ;;
        *) echo '%f$ '
            ;;
    esac
}

# How you actually set the message
PS1='$(promptmsg)'
setopt promptsubst

# example of streamline dev to stop a service and clean up
clean-serv () {
    Docker-compose down -v
    sleep 3
    make clean
    sleep 2
}

# example of streamlined dev to start a service that needs .env with aws creds
start-serv () {
    assume necessary-auth
    echo 'Assumed necessary-auth!'
    rm .env
    sleep 1
    touch .env
    sleep 2
    echo "AUTH_ COMMANDS are run not echoed" | grep ^AUTH_ >> .env
    sleep 2
    awx make thing
}

# combine two functions becasue the extra chars and second enter button is tooo much.
rserv () {
    fbdp
    sbdp
}

# stop docker containers
whaledone () {
    docker ps | tail -n +2 | awk '{print $1}' | xargs -n1 docker kill
}

# remove docker images (hard reset for dev)
whalegone () {
    docker image ls | tail -n +2 | awk '{print $3}' | xargs -n1 docker rmi -f
}

# The most important function for you when modifying your profile (~/.zshrc)
function term-refresh {
    source ~/.zshrc
    echo "That was refreshing!"
}


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

function usevoice {
    local voices=($(say -v "?" | awk '{print $1}'))
    select VOICE in $voices; do 
        echo $VOICE
        break
    done
}

function randomvoice {
    local voices=($(say -v "?" | grep "en_" | awk '{print $1}'))
    size=${#voices[@]}
    index=$(($RANDOM % $size + 1))
    VOICE=${voices[$index]}
    echo $VOICE
    # say -v $VOICE "Hi, my name is $VOICE"
}

# weather forcast -d for detailed
function weather {
    # Weather API https://www.weather.gov/documentation/services-web-api
    # SPS Tower latitude 44.9742612164605, longitude -93.26755068963584
    # https://api.weather.gov/points/44.974261,-93.267550
    # curl https://api.weather.gov/points/44.974261,-93.267550 | jq .properties.forecast
    # https://api.weather.gov/gridpoints/MPX/107,71/forecast
    fcast=`curl https://api.weather.gov/gridpoints/MPX/107,71/forecast -s`

    fcast_one_daytime=`echo $fcast | jq '.properties.periods' | jq '.[0] | .isDaytime'`
    fcast_one_temp=`echo $fcast | jq '.properties.periods' | jq '.[0] | .temperature'`
    fcast_one_detailedForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .detailedForecast'`
    fcast_one_shortForecast=`echo $fcast | jq '.properties.periods' | jq '.[0] | .shortForecast'`

    fcast_two_daytime=`echo $fcast | jq '.properties.periods' | jq '.[1] | .isDaytime'`
    fcast_two_temp=`echo $fcast | jq '.properties.periods' | jq '.[1] | .temperature'`
    fcast_two_detailedForecast=`echo $fcast | jq '.properties.periods' | jq '.[1] | .detailedForecast'`
    fcast_two_shortForecast=`echo $fcast | jq '.properties.periods' | jq '.[1] | .shortForecast'`

    if [[ $fcast_one_daytime == "true" ]]
    then
        if [[ $* == *-d*  ]]
        then
            echo "Today: $fcast_one_detailedForecast"
            echo "Tonight: $fcast_two_detailedForecast"
        else
            echo "Today: $fcast_one_shortForecast, High: $fcast_one_temp"
            echo "Tonight: $fcast_two_shortForecast, Low: $fcast_two_temp"
        fi
    else
        if [[ $* == *-d*  ]]
        then
            echo "Tonight: $fcast_one_detailedForecast"
            echo "Tomorrow: $fcast_two_detailedForecast"
        else
            echo "Tonight: $fcast_one_shortForecast, Low: $fcast_one_temp"
            echo "Tomorrow: $fcast_two_shortForecast, High: $fcast_two_temp"
        fi
    fi
}

function wbug {
    local_weather_path="~"
    eval "sh $local_weather_path/local_weather.sh -d"
}

function clear_check {
    ClearCheckShellScriptPath="[repo_path]/examples"
    eval "sh $ClearCheckShellScriptPath/clear_check.sh $*"
}