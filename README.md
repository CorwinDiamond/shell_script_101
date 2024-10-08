# shell_script_101
Welcome to my presentation on shell scripts!

## Presentations
### Upcoming Presentations
TBD - None at this time, stay tuned for updates.

### Past Presentations
1. [THAT Conference Wisconsin - August 1st, 2024](https://thatconference.com/activities/sHZuD0q3tFK5B4tffKzV)
1. [DevOpsDays Minneapolis - August 7th, 2024](https://devopsdays.org/events/2024-minneapolis/program/corwin-diamond) - [Youtube Recording](https://www.youtube.com/watch?v=MSxUM2dHrOc)

## Dependencies
*Figlet*: to install figlet, run `$ brew install figlet`

*pv*: to install pv, run `$ bash demo-magic.sh check_pv` or `$ brew install pv`

*jq*: to install jq, run `$ brew install jq`

*powershell* to install powershell, run `$ brew install powershell/tap/powershell`

## Running local.
Update `config.json`
`$ bash present.sh`

Navigation and tricks:
 - `b` can be used to go back
 - `f` can be used to skip the rest of a slide.
 - `^c` can be used to end the presentation. 
 - `skip` for branch will skip the doit example 

## Shorthand
The `functions.sh` file explains much of the shorthand necessary to understand how the slides work. Some of the demo magic is in a file named `demo-magic.sh`. The file `present.sh` drives the presentation in the order perscribed by `order.txt`.

Similar functions are in `power_functions.ps1`

## Sample Profile
`sample_profile.zshrc` has many `[insert-value]` and `[redacted-value]` sections that need to be replaced for it to work. This profile was written to work on a Mac. Your profile will be at `~/.zshrc`

In order to run, many of the functions require auth, context, and environment variables to be set up.

## QR
```
brew install qrencode
qrencode -t ANSI -o - "https://github.com/CorwinDiamond/shell_script_101"
```

## Other Resources
 - https://www.shellscript.sh/index.html
 - https://github.com/paxtonhare/demo-magic
 - Code for generating headshot.txt was inspired by [converting-image-ascii-image-python](https://geeksforgeeks.org/converting-image-ascii-image-python)

## Connect
Linkedin: https://www.linkedin.com/in/corwind/
