#!/bin/bash

#==============================================================================
# GITEMMUORT - Wrapper interattivo per Git in italiano napoletano
# Versione: 1.0
# Descrizione: Interfaccia user-friendly per comandi Git con alias in dialetto
#==============================================================================

# Se viene passato un argomento, cambia directory
if [ "$1" ]
then
    cd "$1"
fi

#==============================================================================
# FUNZIONI DI UTILITÀ
#==============================================================================

# Verifica se si è in una repository Git
# Ritorna 0 se si è in una repo Git, 1 altrimenti
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        show_error "Non sei in una repository Git!"
        return 1
    fi
    return 0
}

# Reset dei colori del terminale
# Ripristina i colori di default del terminale
reset_colors() {
    tput sgr0
}

# Mostra un messaggio di errore formattato
# Parametro: $1 - Il messaggio di errore da visualizzare
show_error() {
    echo "$(tput setaf 1)Errore: $1$(tput sgr0)"
}

start() {
    echo "
$(tput setaf 5)  _____ _____ _______ $(tput setaf 6)______ __  __ __  __ _    _  ____  _____ _______
$(tput setaf 5) / ____|_   _|__   __$(tput setaf 6)|  ____|  \/  |  \/  | |  | |/ __ \|  __ \__   __|
$(tput setaf 5)| |  __  | |    | |  $(tput setaf 6)| |__  | \  / | \  / | |  | | |  | | |__) | | |
$(tput setaf 5)| | |_ | | |    | |  $(tput setaf 6)|  __| | |\/| | |\/| | |  | | |  | |  _  /  | |
$(tput setaf 5)| |__| |_| |_   | |  $(tput setaf 6)| |____| |  | | |  | | |__| | |__| | | \ \  | |
$(tput setaf 5) \_____|_____|  |_|  $(tput setaf 6)|______|_|  |_|_|  |_|\____/ \____/|_|  \_\ |_| $(tput setaf 5) V 1.0
    "
    echo "$(tput setaf 7)"
    
    echo "Percorso attuale: $(pwd)"
    echo
    
    echo
    echo
    echo "Inserisci un comando (digita $(tput setaf 6)'help'$(tput setaf 7) oppure $(tput setaf 6)'h'$(tput setaf 7) per la lista dei comandi)"
    reset_colors
}

# Mostra il menu di aiuto con tutti i comandi disponibili
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
$(tput setaf 7) | rebase continue | rbc $(tput setaf 5) > $(tput setaf 6) rebase continue $(tput setaf 7)                       |
$(tput setaf 7) | rebase abort | rba $(tput setaf 5) > $(tput setaf 6) rebase abort $(tput setaf 7)                             |
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
$(tput setaf 7) | pulisci e ricomincia | cr $(tput setaf 5) > $(tput setaf 6) clear e restart $(tput setaf 7)                   |
$(tput setaf 7) | esci | q | exit $(tput setaf 5) > $(tput setaf 6) esci da gitemmuort $(tput setaf 7)                          |
$(tput setaf 7) |__________________________________________________________________|
    "
}

#==============================================================================
# FUNZIONI GIT - CLONE
#==============================================================================

# Clona una repository Git da un URL fornito dall'utente
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

#==============================================================================
# FUNZIONI GIT - COMMIT
#==============================================================================

# Esegue git add . seguito da git commit con un messaggio personalizzato
git_commit() {
    check_git_repo || return
    echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
    read -e commit_message
    
    if [ "$commit_message" ]
    then
        git add . || { show_error "Impossibile aggiungere i file"; return 1; }
        git commit -m "$commit_message" || { show_error "Impossibile effettuare il commit"; return 1; }
        git log -2
        echo
    else
        echo "Fatto"
    fi
}

#==============================================================================
# FUNZIONI GIT - RESET
#==============================================================================

# Esegue un reset soft, tornando indietro di N commit mantenendo le modifiche staged
git_reset_soft() {
    check_git_repo || return
    echo "Di quanti commit vuoi tornare indietro? (RESET SOFT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --soft HEAD~$commit_number || { show_error "Impossibile effettuare il reset soft"; return 1; }
        
        echo
        echo "$(tput setaf 6) Reset SOFT EFFETTUATO$(tput sgr0)"
        echo
        git log -2
        echo
    else
        echo "Fatto"
    fi
}

# Esegue un reset hard, tornando indietro di N commit e scartando tutte le modifiche
git_reset_hard() {
    check_git_repo || return
    echo "Di quanti commit vuoi tornare indietro? (RESET HARD) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --hard HEAD~$commit_number || { show_error "Impossibile effettuare il reset hard"; return 1; }
        
        echo
        echo "$(tput setaf 6) Reset HARD EFFETTUATO$(tput sgr0)"
        echo
        git log -2
        echo
    else
        echo "Fatto"
    fi
}

#==============================================================================
# FUNZIONI GIT - BRANCH MANAGEMENT
#==============================================================================

# Crea e fa checkout su un nuovo branch
git_add_branch() {
    check_git_repo || return
    echo "Inserisci il nome del nuovo branch (Lascia il campo vuoto per uscire):"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git checkout -b "$branch_name" || { show_error "Impossibile creare il branch"; return 1; }
        echo
        git branch
    else
        echo "Fatto"
    fi
}

# Pubblica il branch corrente su origin (git push -u origin <branch>)
git_publish_branch() {
    check_git_repo || return
    current_branch=`git branch --show-current`
    
    if [ -z "$current_branch" ]; then
        show_error "Impossibile determinare il branch corrente"
        return 1
    fi
    
    git push -u origin $current_branch || { show_error "Impossibile pubblicare il branch"; return 1; }
}

# Elimina un branch specificato dall'utente (git branch -D)
git_delete_branch() {
    check_git_repo || return
    git branch
    echo
    echo "Inserisci il nome del branch che vuoi eliminare (Lascia il campo vuoto per uscire):"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git branch -D "$branch_name" || { show_error "Impossibile eliminare il branch"; return 1; }
        echo
        git branch
    else
        echo "Fatto"
    fi
}

# Elimina il branch corrente dopo essere passato al branch principale
# Previene l'eliminazione del branch principale
git_delete_current_branch() {
    check_git_repo || return
    current_branch=`git branch --show-current`
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    
    if [ "$current_branch" = "$master" ]; then
        show_error "Non puoi eliminare il branch principale!"
        return 1
    fi
    
    git checkout $master || { show_error "Impossibile fare checkout"; return 1; }
    git branch -D $current_branch || { show_error "Impossibile eliminare il branch"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - CHECKOUT
#==============================================================================

# Mostra un menu interattivo per selezionare e fare checkout su un branch
git_checkout() {
    check_git_repo || return
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
                git checkout "$branch" || { show_error "Impossibile fare checkout"; return 1; }
                break
            ;;
        esac
    done
}

# Fa checkout sul branch principale (master/main) del repository
git_checkout_master() {
    check_git_repo || return
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master || { show_error "Impossibile fare checkout"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - MERGE
#==============================================================================

# Mostra un menu interattivo per selezionare e mergiare un branch
git_merge() {
    check_git_repo || return
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
                git merge "$branch" || { show_error "Impossibile effettuare il merge"; return 1; }
                break
            ;;
        esac
    done
}

#==============================================================================
# FUNZIONI GIT - REBASE
#==============================================================================

# Esegue un rebase del branch corrente sul branch principale
git_rebase_master() {
    check_git_repo || return
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git rebase $master || { show_error "Impossibile effettuare il rebase"; return 1; }
}

# Va sul branch principale, fa pull, torna indietro e fa rebase
# Utile per aggiornare il branch corrente con le ultime modifiche del principale
git_pull_rebase_master() {
    check_git_repo || return
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master || { show_error "Impossibile fare checkout"; return 1; }
    git pull || { show_error "Impossibile fare pull"; return 1; }
    git checkout - || { show_error "Impossibile tornare al branch precedente"; return 1; }
    git rebase $master || { show_error "Impossibile effettuare il rebase"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - SQUASH
#==============================================================================

# Fa lo squash di N commit in uno solo con un nuovo messaggio
# Utile per comprimere più commit in uno prima di fare push
git_squash() {
    check_git_repo || return
    echo "Di quanti commit vuoi fare lo squash? (SQUASH CON MESSAGGIO DI COMMIT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        echo "Inserisci il messaggio del commit (Lascia il campo vuoto per uscire):"
        read -e commit_message
        
        if [ "$commit_message" ]
        then
            git reset --soft HEAD~$commit_number || { show_error "Impossibile effettuare il reset"; return 1; }
            git add . || { show_error "Impossibile aggiungere i file"; return 1; }
            git commit -m "$commit_message" || { show_error "Impossibile effettuare il commit"; return 1; }
            git log -2
            echo
            echo "$(tput setaf 6) Squash effettuato$(tput sgr0)"
        else
            echo "Fatto"
        fi
    else
        echo "Fatto"
    fi
}

# Fa lo squash di N commit mantenendo il messaggio dell'ultimo commit
git_squash_last_commit() {
    check_git_repo || return
    echo "Di quanti commit vuoi fare lo squash? (SQUASH CON L'ULTIMO MESSAGGIO DI COMMIT) [Digita $(tput setaf 6)0$(tput setaf 7) per uscire]"
    read -e commit_number
    
    last_commit_message=$(git log -1 --pretty=%B)
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --soft HEAD~$commit_number || { show_error "Impossibile effettuare il reset"; return 1; }
        git add . || { show_error "Impossibile aggiungere i file"; return 1; }
        git commit -m "$last_commit_message" || { show_error "Impossibile effettuare il commit"; return 1; }
        git log -2
        echo
        echo "$(tput setaf 6) Squash effettuato$(tput sgr0)"
    else
        echo "Fatto"
    fi
}

#==============================================================================
# INIZIALIZZAZIONE E LOOP PRINCIPALE
#==============================================================================

# Avvia il programma mostrando il banner
start

# Loop infinito che legge e processa i comandi dell'utente
while :
do
    # Legge il comando con prompt colorato
    read -rep "$(tput setaf 5)$(whoami)$(tput setaf 7)_$(tput setaf 6)gitemmuort$(tput setaf 7) % " command
    reset_colors
    
    # Switch case per processare i vari comandi
    case $command in
        
        # CLONE - Clona una repository
        "clona" | "cln")
            git_clone
        ;;
        
        # FETCH - Aggiorna i riferimenti remoti
        "riallinea" | "f")
            check_git_repo && git fetch
        ;;
        
        # BRANCH - Visualizza tutti i branch
        "ramo" | "b")
            check_git_repo && git branch
        ;;
        
        # Crea un nuovo branch
        "crea ramo" | "ab")
            git_add_branch
        ;;
        
        # Pubblica il branch corrente su origin
        "pubblica ramo" | "pb")
            git_publish_branch
        ;;
        
        # Elimina un branch specifico
        "elimina ramo" | "db")
            git_delete_branch
        ;;
        
        # Elimina il branch corrente
        "elimina ramo attuale" | "dcb")
            git_delete_current_branch
        ;;
        
        # CHECKOUT - Cambia branch tramite menu interattivo
        "vai a" | "ch")
            git_checkout
        ;;
        
        # Passa al branch principale (master/main)
        "vai al principale" | "chm")
            git_checkout_master
        ;;
        
        # Torna al branch precedente
        "vai al precedente" | "chl")
            check_git_repo && git checkout -
        ;;
        
        # MERGE - Mergia un branch nel corrente
        "merge" | "m")
            git_merge
        ;;
        
        # REBASE - Fa rebase dal branch principale
        "rebase main" | "rbm")
            git_rebase_master
        ;;
        
        # Pull + Rebase dal branch principale
        "pull rebase main" | "prbm")
            git_pull_rebase_master
        ;;
        
        # Continua un rebase dopo aver risolto i conflitti
        "rebase continue" | "rbc")
            check_git_repo && git rebase --continue
        ;;
        
        # Annulla un rebase in corso
        "rebase abort" | "rba")
            check_git_repo && git rebase --abort
        ;;
        
        # PULL - Scarica e integra le modifiche dal remoto
        "piliamm" | "p")
            check_git_repo && git pull
        ;;
        
        # PUSH - Carica le modifiche sul remoto
        "ammutta" | "pu")
            check_git_repo && git push
        ;;
        
        # Push forzato (attenzione: sovrascrive la storia remota)
        "ammutta forte" | "puf")
            check_git_repo && git push -f
        ;;
        
        # ADD - Aggiunge tutti i file modificati allo stage
        "aggiungi" | "a")
            check_git_repo && git add .
        ;;
        
        # STATUS - Mostra lo stato dei file
        "stato" | "st")
            check_git_repo && git status
        ;;
        
        # STASH - Aggiunge i file e li salva nello stash
        "aggiungi e sarba" | "as")
            if check_git_repo; then
                git add .
                git stash
            fi
        ;;
        
        # Salva le modifiche correnti nello stash
        "sarba" | "s")
            check_git_repo && git stash
        ;;
        
        # Applica le modifiche salvate nello stash
        "sarba e metti" | "sa")
            check_git_repo && git stash apply
        ;;
        
        # LOG - Visualizza la cronologia dei commit
        "controlla" | "l")
            check_git_repo && git log
        ;;
        
        # COMMIT - Aggiunge tutti i file e crea un commit
        "commetti" | "c")
            git_commit
        ;;
        
        # RESET SOFT - Torna indietro di N commit mantenendo le modifiche
        "resetta e sarba" | "rs")
            git_reset_soft
        ;;
        
        # RESET HARD - Torna indietro di N commit scartando tutto
        "resetta tutt cos" | "rh")
            git_reset_hard
        ;;
        
        # SQUASH - Comprime N commit in uno con nuovo messaggio
        "sq")
            git_squash
        ;;
        
        # SQUASH - Comprime N commit mantenendo l'ultimo messaggio
        "sql")
            git_squash_last_commit
        ;;
        
        # HELP - Mostra il menu di aiuto
        "help" | "h")
            git_help
        ;;
        
        # RESTART - Riavvia il programma mostrando di nuovo il banner
        "restart" | "r")
            start
        ;;
        
        # CLEAR + RESTART - Pulisce lo schermo e riavvia
        "pulisci e ricomincia" | "cr")
            clear
            start
        ;;
        
        # EXIT - Esce dal programma
        "esci" | "exit" | "q")
            echo "$(tput setaf 6)Arrivederci!$(tput sgr0)"
            exit 0
        ;;
        
        # Comando vuoto - Ignora e continua
        "")
            # Non fare nulla
        ;;
        
        # Comando non riconosciuto - Mostra messaggio di errore
        *)
            show_error "Comando non riconosciuto: '$command'"
            echo "Digita $(tput setaf 6)'help'$(tput setaf 7) o $(tput setaf 6)'h'$(tput setaf 7) per la lista dei comandi$(tput sgr0)"
        ;;
    esac
done