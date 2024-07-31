#! /bin/zsh -
export CURRENT_SLIDE=$$
source ./demo-magic.sh

clear
title What the shell?
ln
ascii "              __ __            "
ascii "        _  ,''  |  '',  _      "
ascii "     _{   \`\\    |    /'   }_   "
ascii "    (  \`\\   \\   |   /   /'  )  "
ascii "     \`\\  \`\\  \\  |  /  /'  /'   "
ascii "        \`\ \`\\ \\ | / /' /'      "
ascii "          \`\\\`\\\\\ | //'/'        "
ascii "          ,-\`\\\\\\\\\|///'-.        "
ascii "          \`---\\\\\\\\|//---'        "
ln
txt "A shell is a program that facilitates a user interface."
txt "Steve Bourne created the ${green}B${normal}ourne ${green}A${normal}gain ${green}SH${normal}ell (BASH)." # which I use as synonamis with shell scripting.
ln
# txt "Shell scripts can be used for:"
# bullet "Augmenting and adding CLI commands"
# bullet "Syntactic sugar of frequently called complex CLI commands"
# bullet "Algorithm of CLI commands"
# bullet "Running executables as CLI commands"
# bullet "Creating a unique and customized environment"
ln
txt "Common Shells" # according to https://www.tecmint.com/different-types-of-linux-shells/"
bullet "BASH" #         Bourne Again Shell - Steve Bourne"
bullet "Tcsh/Csh" #     C shell"
bullet "Ksh" #          Korn shell - David G. Korn"
bullet "Zsh" #          Z shell - Mac Default"
bullet "Fish" #         Friendly interactive shell"
bullet "Powershell"
ln
txt "All shells are similar but different."
txt "Powershell is more different but similar."
txt "Most have the same commands but different implementations."
txt "Command arg syntax between versions has sent me to Stack Overflow many times."
ln

wait_for_presenter -fb
heading "Example Script"
txt "${green}doit${normal} () {"
txt '    eval "$( git push 2>&1 1>/dev/null | grep "git push" | xargs )"'
txt "}"
read -p "enter branch "
echo $REPLY
if [[ ! $REPLY =~ "skip" ]]
then
    # TODO sed Event name string to remove spaces
    NO_SPACE_EVENT_NAME=$(echo $EVENT_NAME | sed -e 's/ /-/g')
    echo "prove no spaces $NO_SPACE_EVENT_NAME"
    string="git checkout -b $REPLY"
    pe "$string"
    # TODO CONFIG text file path
    pe "echo \"Updated \$(date \"+%Y-%m-%d at %T\")\" >> $NO_SPACE_EVENT_NAME.txt"
    pe "cat $NO_SPACE_EVENT_NAME.txt"
    pe "git add $NO_SPACE_EVENT_NAME.txt"
    pe "git commit -m \"Doc($NO_SPACE_EVENT_NAME.txt): Meaningful $EVENT_NAME Update!\""
    pe 'git push'
    pe 'doit'
fi
heading "Break down"
txt "${green}doit${normal} () {"
txt '    eval "$( git push 2>&1 1>/dev/null | grep "git push" | xargs )"'
txt "}"