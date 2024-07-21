#! /opt/homebrew/bin/pwsh -
$green=$(tput setaf 2)
$yellow=$(tput setaf 3)
$magenta=$(tput setaf 5)
$blue=$(tput setaf 6)
$normal=$(tput sgr0)

$EVENT_NAME = Get-Content config.json | ConvertFrom-Json | Select -ExpandProperty event_name

function wait_for_presenter{
    $response = Read-Host ' '

    # Not going to implement more functionality for wait_for_presenter
    # I can next each slide in bash and have the sameish functionality
}

function title {
    param ($TitleText = 'PowerShell')
    figlet $TitleText
}

function heading {
    param ($HeadingText = 'PowerShell')
    write-host "`r`n`r`n${green}${HeadingText}${normal}`r`n"
}

function txt {
    param ($TextyText = 'Lorem Ipsum...')
    write-host "${TextyText}`r"
}

function ascii {
    param ($AsciiText)
    write-host "${yellow}${AsciiText}${normal}`r"
}

function ln {
    write-host "`r`n"
}

function bullet {
    param ($BulletText)
    write-host " - ${BulletText}`r"
}

# echo "Source: $(date +"%T")"

# wait_for_presenter