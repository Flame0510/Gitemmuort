#!/bin/ksh

echo "
$(tput setaf 5)   _____ _____ _______ $(tput setaf 6)______ __  __ __  __ _    _  ____  _____ _______
$(tput setaf 5)  / ____|_   _|__   __$(tput setaf 6)|  ____|  \/  |  \/  | |  | |/ __ \|  __ \__   __|
$(tput setaf 5) | |  __  | |    | |  $(tput setaf 6)| |__  | \  / | \  / | |  | | |  | | |__) | | |
$(tput setaf 5) | | |_ | | |    | |  $(tput setaf 6)|  __| | |\/| | |\/| | |  | | |  | |  _  /  | |
$(tput setaf 5) | |__| |_| |_   | |  $(tput setaf 6)| |____| |  | | |  | | |__| | |__| | | \ \  | |
$(tput setaf 5)  \_____|_____|  |_|  $(tput setaf 6)|______|_|  |_|_|  |_|\____/ \____/|_|  \_\ |_| $(tput setaf 5) V 1.0
"
echo "$(tput setaf 7)"

echo "Percorso attuale: $(pwd)"

git_help() {
    echo "
$(tput setaf 7)  ________________________________________________
$(tput setaf 7) |                                                |
$(tput setaf 7) | $(tput setaf 5)COMMANDS: $(tput setaf 7)                                     |
$(tput setaf 7) |________________________________________________|
$(tput setaf 7) |                                                |
$(tput setaf 7) | git piliamm $(tput setaf 5) > $(tput setaf 6) git pull $(tput setaf 7)                      |
$(tput setaf 7) | git ammutta $(tput setaf 5) > $(tput setaf 6) git push $(tput setaf 7)                      |
$(tput setaf 7) | git ammutta forte $(tput setaf 5) > $(tput setaf 6) git push -f $(tput setaf 7)             |
$(tput setaf 7) | git sarba $(tput setaf 5) > $(tput setaf 6) git stash $(tput setaf 7)                       |
$(tput setaf 7) | git sarba e metti $(tput setaf 5) > $(tput setaf 6) git stash apply $(tput setaf 7)         |
$(tput setaf 7) | git controlla $(tput setaf 5) > $(tput setaf 6) git log $(tput setaf 7)                     |
$(tput setaf 7) | git commetti $(tput setaf 5) > $(tput setaf 6) git commit -m $(tput setaf 7)                |
$(tput setaf 7) | git resetta e sarba $(tput setaf 5) > $(tput setaf 6) git reset --soft $(tput setaf 7)      |
$(tput setaf 7) | git resetta tutt cos $(tput setaf 5) > $(tput setaf 6) git reset --hard $(tput setaf 7)     |
$(tput setaf 7) |________________________________________________|
    "
}

git_commmit() {
    echo "Messaggio del commit:"
    read -e commit_message
    
    git add .
    git commit -m "$commit_message"
    git log
}

git_reset_soft() {
    echo "Di quanti commit vuoi tornare indietro? (RESET SOFT)"
    read -e commit_number
    
    git reset --soft HEAD~$commit_number
    
    echo
    echo "$(tput setaf 6) Reset SOFT EFFETTUATO"
    echo
    git log
}

git_reset_hard() {
    echo "Di quanti commit vuoi tornare indietro? (RESET HARD)"
    read -e commit_number
    
    git reset --hard HEAD~$commit_number
    
    echo
    echo "$(tput setaf 6) Reset HARD EFFETTUATO"
    echo
    git log
}

echo
echo
echo "Inserisci un comando (digita $(tput setaf 6)'help'$(tput setaf 7) per la lista dei comandi)"

while :
do
    read -rep "$(tput setaf 5)$(whoami)$(tput setaf 7)_$(tput setaf 6)gitemmuort$(tput setaf 7) % " command
    
    case $command in
        
        "git piliamm")
            git pull
        ;;
        
        "git ammutta")
            git push
        ;;
        
        "git ammutta forte")
            git push -f
        ;;
        
        "git sarba")
            git stash
        ;;
        
        "git sarba e metti")
            git stash apply
        ;;
        
        "git controlla")
            git log
        ;;
        
        "git commetti")
            git_commmit
        ;;
        
        "git resetta e sarba")
            git_reset_soft
        ;;
        
        "git resetta tutt cos")
            git_reset_hard
        ;;
        
        "help")
            git_help
        ;;
        
        *)
            $command
        ;;
    esac
done