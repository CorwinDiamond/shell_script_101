#! /opt/homebrew/bin/pwsh -

# source
. ./power_functions.ps1

title PowerShell
ln
ascii "   #       "
ascii " #####     #####  # # #   ####  #   # "
ascii " # #       #   #  # # #  #      #   # "
ascii " #####     #####  # # #  #####  ##### "
ascii "   # #     #      # # #      #  #   # "
ascii " #####     #       # #   ####   #   # "
ascii "   #                                    "
ln

txt "Because some people use Windows..."
bullet "Output tables and objects natively"
bullet "Easier manipulation of piped data"
bullet "Many BASH commands are aliased, but not documented"
bullet "Yes this slide is written in Powershell instead of BASH"
wait_for_presenter

heading "Verb and Noun"
bullet "Commands are usually a verb and a noun"
bullet "Output is in objects"

wait_for_presenter

function get-command-txt {
    heading "Get-Command"
    bullet "List possible commands"
    bullet "I use Google"
    bullet "This tells you what comands are actually installed"
    bullet "Way too many commands to demo"

    heading "Get-Commnad Filtering"
    bullet "Get commands by verb or noun"
}

function get-command-example {
    txt "PS> Get-Command -Verb Get -Noun U*"
    wait_for_presenter
    Get-Command -Verb Get -Noun U*
}

function select-object-txt {
    heading "Select-Object"
    bullet "Rather than jq everything"
    bullet "Filter results and properties"
}

function select-object-example {
    txt "PS> Get-Command | Select-Object -First 5 -Property Name, Source"
    wait_for_presenter
    Get-Command | Select-Object -First 5 -Property Name, Source
}

function where-object-txt {
    heading "Where-Object"
    bullet "Filter like"
}

function where-object-example {
    txt 'PS> Get-Process | Where-Object {$_.ProcessName -like "p*"} | Select-Object -First 5 -Property Name, Source'
    wait_for_presenter
    Get-Process | Where-Object {$_.ProcessName -like "p*"} | Select-Object -First 5 -Property Name, Source
}
# https://devblogs.microsoft.com/scripting/table-of-basic-powershell-commands/
# https://www.pdq.com/powershell/
# https://learn.microsoft.com/en-us/powershell/scripting/discover-powershell?view=powershell-7.4

function write-txt {
    heading "Write-Error, Write-Debug, Write-Host"
    bullet "Write stuff"
    bullet "Echo equivalent with explicit stream"
}

function write-example {
    txt "PS> Write-Host HI"
    wait_for_presenter
    Write-Host HI
    ln
    txt 'PS> Write-Error "OH NO!"'
    wait_for_presenter
    Write-Error "OH NO!"
}

function get-content-txt {
    heading "Get-Content"
    bullet "Useful for looking at file contents"
}

function get-content-example {
    txt "PS> Get-Content README.md | Select-String -Pattern shell"
    wait_for_presenter
    Get-Content README.md | Select-String -Pattern shell
}

function file-txt {
    heading "Out-File"
    bullet "Equivelent of > or Tee"
    heading "Tee-Object"
    bullet "File or variable"
}

function file-example {
    $Files = @(Get-ChildItem -Filter out_file_example.txt )
    if ($Files.length -gt 0) {
        Remove-Item out_file_example.txt
    }
    txt "PS> Get-ChildItem -Filter out_file_example.txt "
    Get-ChildItem -Filter out_file_example.txt
    wait_for_presenter
    txt 'PS> $Nice_Message = "Hello, This is a test" | Out-File out_file_example.txt '
    $Nice_Message = "Hello, This is a test" | Out-File out_file_example.txt  
    wait_for_presenter
    txt "PS> Get-ChildItem -Filter out_file_example.txt "
    Get-ChildItem -Filter out_file_example
    wait_for_presenter
    txt "PS> Get-Content out_file_example.txt"
    Get-Content out_file_example.txt
    wait_for_presenter
    txt 'PS> $Good_Message = "Powershell seems fun..." | Add-Content out_file_example.txt '
    $Good_Message = "Powershell seems fun..." | Add-Content out_file_example.txt
    wait_for_presenter
    txt "PS> Get-Content out_file_example.txt"
    Get-Content out_file_example.txt
    wait_for_presenter
    txt "PS> $Files = @(Get-ChildItem -Filter out_file_example.txt )"
    txt "if ($Files.length -gt 0) {"
    txt "    Remove-Item out_file_example.txt"
    txt "}"
    $Files = @(Get-ChildItem -Filter out_file_example.txt )
    if ($Files.length -gt 0) {
        Remove-Item out_file_example.txt
    }
    wait_for_presenter
    txt "PS> Get-ChildItem -Filter out_file_example.txt "
    Get-ChildItem -Filter out_file_example.txt
}

function invoke-webrequest-txt {
    heading "Invoke-WebRequest"
    bullet "Instead of curl"
}

function invoke-webrequest-example {

    txt 'PS> $PUBLIC_IP = Invoke-WebRequest -Uri https://ipinfo.io/ip'
    txt 'PS> $Response = Invoke-WebRequest -Uri "https://ipinfo.io/${PUBLIC_IP}" | ConvertFrom-Json'
    txt 'PS> $local_coords = $Response.loc'
    txt 'PS> $Response = Invoke-WebRequest -Uri "https://api.weather.gov/points/${local_coords}"| ConvertFrom-Json'
    txt 'PS> $Complete_Forecast = Invoke-WebRequest -Uri $Response.properties.forecast | ConvertFrom-Json'
    txt 'PS> $Forecast = $Complete_Forecast.properties.periods[0]'
    txt 'PS> Write-Host $(If ($Forecast.isDaytime) {"TODAY:"} Else {"TONIGHT:"}) $Forecast.detailedForecast'

    wait_for_presenter

    # $PUBLIC_IP = Invoke-WebRequest -Uri https://ipinfo.io/ip
    # $Response = Invoke-WebRequest -Uri "https://ipinfo.io/${PUBLIC_IP}" | ConvertFrom-Json
    # $local_coords = $Response.loc
    # $Response = Invoke-WebRequest -Uri "https://api.weather.gov/points/${local_coords}"| ConvertFrom-Json
    # $Complete_Forecast = Invoke-WebRequest -Uri $Response.properties.forecast | ConvertFrom-Json
    # $Forecast = $Complete_Forecast.properties.periods[0]
    # I have been having enough issues with all of the calls, that I fake the live demo.
    # Write-Host $(If ($Forecast.isDaytime) {"TODAY:"} Else {"TONIGHT:"}) $Forecast
    $Forecast = Get-Content examples/weather.txt
    Write-Host "TODAY:" $Forecast
}

$commands= "get-command","select-object","where-object","write","get-content","file","invoke-webrequest"
#get-command-fun


foreach ($command in $commands) {
    # txt $command
    &"${command}-txt"
    wait_for_presenter
    tput smcup
    &"${command}-txt"
    ln
    txt "Examples:"
    &"${command}-example"
    wait_for_presenter
    tput rmcup
}

ln
title "BACK TO BASH"
