#!/bin/bash

if [ "$1" ]
then
    cd "$($1)"
fi

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

    echo
    echo
    echo "Inserisci un comando (digita $(tput setaf 6)'help'$(tput setaf 7) oppure $(tput setaf 6)'h'$(tput setaf 7) per la lista dei comandi)"
}

git_help() {
    echo "
$(tput setaf 7)  __________________________________________________________________
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | $(tput setaf 5)COMMANDS: $(tput setaf 7)                                                       |
$(tput setaf 7) |__________________________________________________________________|
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | clona | cln $(tput setaf 5) > $(tput setaf 6) git clone $(tput setaf 7)                                       |
$(tput setaf 7) | riallinea | f $(tput setaf 5) > $(tput setaf 6) git fetch $(tput setaf 7)                                     |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | ramo | b $(tput setaf 5) > $(tput setaf 6) git branch $(tput setaf 7)                                         |
$(tput setaf 7) | crea ramo | ab $(tput setaf 5) > $(tput setaf 6) crea nuova branch $(tput setaf 7)                            |
$(tput setaf 7) | pubblica ramo | pb $(tput setaf 5) > $(tput setaf 6) pubblica branch $(tput setaf 7)                          |
$(tput setaf 7) | elimina ramo | db $(tput setaf 5) > $(tput setaf 6) git branch -D $(tput setaf 7)                             |
$(tput setaf 7) | elimina ramo attuale | dcb $(tput setaf 5) > $(tput setaf 6) elimina ramo attuale $(tput setaf 7)             |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | vai a | ch $(tput setaf 5) > $(tput setaf 6) git checkout $(tput setaf 7)                                     |
$(tput setaf 7) | vai al principale | chm $(tput setaf 5) > $(tput setaf 6) checkout ramo principale $(tput setaf 7)            |
$(tput setaf 7) | vai al precedente | chl $(tput setaf 5) > $(tput setaf 6) checkout ramo precedente $(tput setaf 7)            |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | merge | m $(tput setaf 5) > $(tput setaf 6) git merge                           $(tput setaf 7)               |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | rebase main | rbm $(tput setaf 5) > $(tput setaf 6) rebase da branch principale $(tput setaf 7)               |
$(tput setaf 7) | pull rebase main | prbm $(tput setaf 5) > $(tput setaf 6) pull rebase da branch principale $(tput setaf 7)    |
$(tput setaf 7) | rebase continue | rba $(tput setaf 5) > $(tput setaf 6) rebase continue $(tput setaf 7)                       |
$(tput setaf 7) | rebase abort | rbc $(tput setaf 5) > $(tput setaf 6) rebase abort $(tput setaf 7)                             |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | piliamm | p $(tput setaf 5) > $(tput setaf 6) git pull $(tput setaf 7)                                        |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | ammutta | pu $(tput setaf 5) > $(tput setaf 6) git push $(tput setaf 7)                                       |
$(tput setaf 7) | ammutta forte | puf $(tput setaf 5) > $(tput setaf 6) git push -f $(tput setaf 7)                             |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | aggiungi | a $(tput setaf 5) > $(tput setaf 6) git add . $(tput setaf 7)                                      |
$(tput setaf 7) | stato | st $(tput setaf 5) > $(tput setaf 6) git status $(tput setaf 7)                                       |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | aggiungi e sarba | as $(tput setaf 5) > $(tput setaf 6) git add . + git stash $(tput setaf 7)                 |
$(tput setaf 7) | sarba | s $(tput setaf 5) > $(tput setaf 6) git stash $(tput setaf 7)                                         |
$(tput setaf 7) | sarba e metti | sa$(tput setaf 5) > $(tput setaf 6) git stash apply $(tput setaf 7)                           |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | controlla | l $(tput setaf 5) > $(tput setaf 6) git log $(tput setaf 7)                                       |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | commetti | c $(tput setaf 5) > $(tput setaf 6) git commit -m $(tput setaf 7)                                  |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | resetta e sarba | rs $(tput setaf 5) > $(tput setaf 6) git reset --soft $(tput setaf 7)                       |
$(tput setaf 7) | resetta tutt cos | rh $(tput setaf 5) > $(tput setaf 6) git reset --hard $(tput setaf 7)                      |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | sq $(tput setaf 5) > $(tput setaf 6) squash $(tput setaf 7)                                                   |
$(tput setaf 7) | sql $(tput setaf 5) > $(tput setaf 6) squash with last commit message $(tput setaf 7)                         |
$(tput setaf 7) |                                                                  |
$(tput setaf 7) | restart | r $(tput setaf 5) > $(tput setaf 6) riavvia gitemmuort $(tput setaf 7)                              |
$(tput setaf 7) |__________________________________________________________________|
    "
}


#FUNCTIONS
git_clone() {
    echo "Inserisci il link della repository (Lascia il campo vuoto per uscire):"
    read -e git_url
    
    if [ "$git_url" ]
    then
        git clone "$git_url"        
        echo
    else
        echo "Fatto"
    fi
}

git_commmit() {
    echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
    read -e commit_message
    
    if [ "$commit_message" ]
    then
        git add .
        git commit -m "$commit_message"
        git log -2
        echo
    else
        echo "Fatto"
    fi
}


#RESET
git_reset_soft() {
    echo "Di quanti commit vuoi tornare indietro? (RESET SOFT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" > 0 ]]
    then
        git reset --soft HEAD~$commit_number
        
        echo
        echo "$(tput setaf 6) Reset SOFT EFFETTUATO"
        echo
        git log -2
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
        git log -2
        echo
    else
        echo "Fatto"
    fi
}


#BRANCH
git_add_branch() {
    echo "Inserisci il nome del nuovo branch (Lascia il campo vuoto per uscire):"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git checkout -b "$branch_name"        
        echo
        git branch
    else
        echo "Fatto"
    fi
}

git_publish_branch() {
    current_branch=`git branch --show current`

    git push -u origin $current_branch
}

git_delete_branch() {
    git branch
    echo 
    echo "Inserisci il nome del branch che vuoi eliminare (Lascia il campo vuoto per uscire):"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git branch -D "$branch_name"        
        echo
        git branch
    else
        echo "Fatto"
    fi
}

git_delete_current_branch() {
    current_branch=`git branch --show current`
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`

    git checkout $master
    git branch -D $current_branch
}


#CHECKOUT
git_checkout() {
    branches=($(git branch | awk '{print $1}'))
    options=("${branches[@]}" "Esci")

    PS3="Seleziona una branch: "
    select branch in "${options[@]}"
    do
        case $branch in
            "Esci")
                break
                ;;
            *)
                git checkout "$branch"
                break
                ;;
        esac
    done
}

git_checkout_master() {
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master
}

#MERGE
git_merge() {
    branches=($(git branch | awk '{print $1}'))
    options=("${branches[@]}" "Esci")

    PS3="Seleziona una branch da mergiare: "
    select branch in "${options[@]}"
    do
        case $branch in
            "Esci")
                break
                ;;
            *)
                git merge "$branch"
                break
                ;;
        esac
    done
}

#REBASE
git_rebase_master() {
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git rebase $master
}

git_pull_rebase_master() {
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master
    git pull
    git checkout -
    git rebase $master
}


#SQUASH
git_squash() {
    echo "Di quanti commit vuoi fare lo squash? (SQUASH CON MESSAGGIO DI COMMIT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" > 0 ]]
    then
        echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
        read -e commit_message
        
        if [ "$commit_message" ]
        then
            git reset --soft HEAD~$commit_number
            git add .
            git commit -m "$commit_message"
            git log -2
            echo
        else
            echo "Fatto"
        fi
        
        echo "$(tput setaf 6) Squash effettuato"
    else
        echo "Fatto"
    fi
}

git_squash_last_commit() {
    echo "Di quanti commit vuoi fare lo squash? (SQUASH CON L'ULTIMO MESSAGGIO DI COMMIT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    last_commit_message=$(git log -1 --pretty=%B)
    
    if [[ "$commit_number" > 0 ]]
    then
        git reset --soft HEAD~$commit_number
        git add .
        git commit -m "$last_commit_message"
        git log -2
        echo
        echo "$(tput setaf 6) Squash effettuato"
    else
        echo "Fatto"
    fi
}


#restart_console() {
  #  break
 #   console
#}

other_commands() {
    
    stty echo

    #console

   #printf "\n$(tput setaf 5)$(whoami)$(tput setaf 7)_$(tput setaf 6)gitemmuort$(tput setaf 7) %s " "%"
}

trap other_commands SIGINT

console() {
    

while :
do
    read -rep "$(tput setaf 5)$(whoami)$(tput setaf 7)_$(tput setaf 6)gitemmuort$(tput setaf 7) % " command
    
    trap return INT

    case $command in

        "test")
            git_selector
        ;;
        
        
        #clone
        "clona" | "cln")
            git_clone
        ;;
        
        #fetch
        "riallinea" | "f")
            git fetch
        ;;
        

        #branch
        "ramo" | "b")
            git branch
        ;;

        "crea ramo" | "ab")
            git_add_branch
        ;;

        "pubblica ramo" | "pb")
            git_publish_branch
        ;;

        "elimina ramo" | "db")
            git_delete_branch
        ;;

        "elimina ramo attuale" | "dcb")
            git_delete_current_branch
        ;;        


        #checkout
        "vai a" | "ch")
            git_checkout
        ;;

        "vai al principale" | "chm")
            git_checkout_master
        ;;

        "vai al precedente" | "chl")
            git checkout -
        ;;


        #merge
        "merge" | "m")
            git_merge
        ;;


        #rebase
        "rebase main" | "rbm")
            git_rebase_master
        ;;

        "pull rebase main" | "prbm")
            git_pull_rebase_master
        ;;

        "rebase continue" | "rbc")
            git rebase --continue
        ;;

        "rebase abort" | "rba")
            git rebase --abort
        ;;

        #pull
        "piliamm" | "p")
            git pull
        ;;
        
        #push
        "ammutta" | "pu")
            git push
        ;;
        
        "ammutta forte" | "puf")
            git push -f
        ;;


        #add - status
        "aggiungi" | "a")
            git add .
        ;;

        "stato" | "st")
            git status
        ;;
        

        #stash
        "aggiungi e sarba" | "as")
            git add .
            git stash
        ;;

        "sarba" | "s")
            git stash
        ;;
        
        "sarba e metti" | "sa")
            git stash apply
        ;;


        #log
        "controlla" | "l")
            git log
        ;;
        
        
        #commit
        "commetti" | "c")
            git_commmit
        ;;
        

        #reset
        "resetta e sarba" | "rs")
            git_reset_soft
        ;;
        
        "resetta tutt cos" | "rh")
            git_reset_hard
        ;;
        

        #squash
        "sq")
            git_squash
        ;;
        
        "sql")
            git_squash_last_commit
        ;;


        #help
        "help" | "h")
            git_help
        ;;


        #restart
        "restart" | "r")
            start
        ;;
        
        "pulisci e ricomincia" | "cr")
            clear
            start
        ;;

        #skip
        "skip")
            continue
        ;;

        #exit
        "exit")
            exit
        ;;
        
        *)
            $command
        ;;
    esac
done
}


start
console

