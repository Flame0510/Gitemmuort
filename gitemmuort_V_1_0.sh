#!/bin/ksh

start() {
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
    echo
}

git_help() {
    echo "
$(tput setaf 7)  ________________________________________________
$(tput setaf 7) |                                                |
$(tput setaf 7) | $(tput setaf 5)COMMANDS: $(tput setaf 7)                                     |
$(tput setaf 7) |________________________________________________|
$(tput setaf 7) |                                                |
$(tput setaf 7) | piliamm | p $(tput setaf 5) > $(tput setaf 6) git pull $(tput setaf 7)                      |
$(tput setaf 7) | ammutta | pu $(tput setaf 5) > $(tput setaf 6) git push $(tput setaf 7)                     |
$(tput setaf 7) | ammutta forte | puf $(tput setaf 5) > $(tput setaf 6) git push -f $(tput setaf 7)           |
$(tput setaf 7) | sarba | s $(tput setaf 5) > $(tput setaf 6) git stash $(tput setaf 7)                       |
$(tput setaf 7) | sarba e metti | sa$(tput setaf 5) > $(tput setaf 6) git stash apply $(tput setaf 7)         |
$(tput setaf 7) | controlla | l $(tput setaf 5) > $(tput setaf 6) git log $(tput setaf 7)                     |
$(tput setaf 7) | commetti | c $(tput setaf 5) > $(tput setaf 6) git commit -m $(tput setaf 7)                |
$(tput setaf 7) | resetta e sarba | rs $(tput setaf 5) > $(tput setaf 6) git reset --soft $(tput setaf 7)     |
$(tput setaf 7) | resetta tutt cos | rh $(tput setaf 5) > $(tput setaf 6) git reset --hard $(tput setaf 7)    |
$(tput setaf 7) | sq $(tput setaf 5) > $(tput setaf 6) squash $(tput setaf 7)                                 |
$(tput setaf 7) | restart | r $(tput setaf 5) > $(tput setaf 6) riavvia gitemmuort $(tput setaf 7)            |
$(tput setaf 7) |________________________________________________|
    "
}

git_commmit() {
    echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
    read -e commit_message
    
    if [ "$commit_message" ]
    then
        git add .
        git commit -m "$commit_message"
        git log -3
        echo
    else
        echo "Fatto"
    fi
}

git_reset_soft() {
    echo "Di quanti commit vuoi tornare indietro? (RESET SOFT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" > 0 ]]
    then
        git reset --soft HEAD~$commit_number
        
        echo
        echo "$(tput setaf 6) Reset SOFT EFFETTUATO"
        echo
        git log -3
        echo
    else
        echo "Fatto"
    fi
    
    
}

git_reset_hard() {
    echo "Di quanti commit vuoi tornare indietro? (RESET HARD) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" > 0 ]]
    then
        git reset --hard HEAD~$commit_number
        
        echo
        echo "$(tput setaf 6) Reset HARD EFFETTUATO"
        echo
        git log -3
        echo
    else
        echo "Fatto"
    fi
}

git_squash() {
    echo "Di quanti commit vuoi tornare indietro? (RESET HARD) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    last_commit_message=$(git log -1 --pretty=%B)
    
    if [[ "$commit_number" > 0 ]]
    then
        echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
        read -e commit_message
        
        if [ "$commit_message" ]
        then
            git reset --soft HEAD~$commit_number
            git add .
            git commit -m "$commit_message"
            git log -3
            echo
        else
            echo "Fatto"
        fi
        
        echo "$(tput setaf 6) Squash effettuato"
    else
        echo "Fatto"
    fi
}

start

echo
echo
echo "Inserisci un comando (digita $(tput setaf 6)'help'$(tput setaf 7) oppure $(tput setaf 6)'h'$(tput setaf 7) per la lista dei comandi)"

while :
do
    read -rep "$(tput setaf 5)$(whoami)$(tput setaf 7)_$(tput setaf 6)gitemmuort$(tput setaf 7) % " command
    
    case $command in
        
        "piliamm" | "p")
            git pull
        ;;
        
        "ammutta" | "pu")
            git push
        ;;
        
        "ammutta forte" | "puf")
            git push -f
        ;;
        
        "sarba" | "s")
            git stash
        ;;
        
        "sarba e metti" | "sa")
            git stash apply
        ;;
        
        "controlla" | "l")
            git log
        ;;
        
        "commetti" | "c")
            git_commmit
        ;;
        
        "resetta e sarba" | "rs")
            git_reset_soft
        ;;
        
        "resetta tutt cos" | "rh")
            git_reset_hard
        ;;
        
        "sq")
            git_squash
        ;;
        
        "help" | "h")
            git_help
        ;;
        
        "restart" | "r")
            start
        ;;
        
        *)
            $command
        ;;
    esac
done