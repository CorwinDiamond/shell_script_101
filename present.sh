#! /bin/zsh -
source functions.sh
slides=($(cat order.txt))
# slides=(power.sh)
echo $slides_from_file

export LENGTH="${#slides[@]}"
export INDEX=0
export SLIDE_RETURN_VALUE=0

if [[ $# -ge 1 ]]
then
    INDEX=$1
fi 

do_present () {
    export KILLED_SLIDE=false
    while [[ $INDEX -lt $LENGTH ]]
    do
        SLIDE_RETURN_VALUE=0
        bash "slides/${slides[$INDEX]}" || SLIDE_RETURN_VALUE=$?; true
        if [[ $SLIDE_RETURN_VALUE -eq 3 ]]
        then 
            export KILLED_SLIDE=false
            if [[ $INDEX -gt 0 ]]
            then
                export INDEX=$(($INDEX-1))
            fi
        elif [[ $SLIDE_RETURN_VALUE -eq 4 ]]
        then
            export KILLED_SLIDE=false
            export INDEX=$(($INDEX+1))
        else
            wait_for_presenter -i
        fi
    done
}

do_present

echo "$slides_from_file"