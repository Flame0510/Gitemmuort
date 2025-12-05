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
        show_error "Chistu nun è territorio nosto! (Non sei in una repository Git!)"
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
    echo "$(tput setaf 1)✘ $1$(tput sgr0)"
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
    
    echo "Addò stongo mo (Percorso attuale): $(pwd)"
    echo
    
    echo
    echo
    echo "Che vuo fa'? (Cosa vuoi fare?) - Digita $(tput setaf 6)'help'$(tput setaf 7) o $(tput setaf 6)'h'$(tput setaf 7) p'a lista"
    reset_colors
}

# Mostra il menu di aiuto con tutti i comandi disponibili
git_help() {
    echo "
$(tput setaf 6)  ╔══════════════════════════════════════════════════════════════════════════╗
$(tput setaf 6)  ║ $(tput setaf 5)🔫 GITEMMUORT - 'O SISTEMA P' GIT$(tput setaf 6)                                        ║
$(tput setaf 6)  ║ $(tput setaf 7)Ogni comando ha 2 versioni: $(tput setaf 1)Napoletano$(tput setaf 7) (divertente) | $(tput setaf 2)Veloce$(tput setaf 7) (1-2 char)$(tput setaf 6) ║
$(tput setaf 6)  ╚══════════════════════════════════════════════════════════════════════════╝

$(tput setaf 7)  📦 $(tput setaf 5)CLONE & FETCH$(tput setaf 7)
    $(tput setaf 1)pigliat 'a roba$(tput setaf 7) | $(tput setaf 2)cln$(tput setaf 7) → git clone
    $(tput setaf 1)controlla 'o giro$(tput setaf 7) | $(tput setaf 2)f$(tput setaf 7) → git fetch

$(tput setaf 7)  🏢 $(tput setaf 5)BRANCH (I CLAN)$(tput setaf 7)
    $(tput setaf 1)vir 'e clan$(tput setaf 7) | $(tput setaf 2)b$(tput setaf 7) → git branch
    $(tput setaf 1)fonda nu clan$(tput setaf 7) | $(tput setaf 2)ab$(tput setaf 7) → crea nuovo branch
    $(tput setaf 1)fai sapé a tutt$(tput setaf 7) | $(tput setaf 2)pb$(tput setaf 7) → pubblica branch
    $(tput setaf 1)leva 'o clan$(tput setaf 7) | $(tput setaf 2)db$(tput setaf 7) → elimina branch
    $(tput setaf 1)sciogliere stu clan$(tput setaf 7) | $(tput setaf 2)dcb$(tput setaf 7) → elimina corrente

$(tput setaf 7)  🔄 $(tput setaf 5)CHECKOUT (CAMBIO CLAN)$(tput setaf 7)
    $(tput setaf 1)passa a n'atu clan$(tput setaf 7) | $(tput setaf 2)ch$(tput setaf 7) → checkout (menu)
    $(tput setaf 1)torna dò sistema$(tput setaf 7) | $(tput setaf 2)chm$(tput setaf 7) → master/main
    $(tput setaf 1)torna arè$(tput setaf 7) | $(tput setaf 2)chl$(tput setaf 7) → branch precedente

$(tput setaf 7)  🤝 $(tput setaf 5)MERGE & REBASE$(tput setaf 7)
    $(tput setaf 1)alleat 'e clan$(tput setaf 7) | $(tput setaf 2)m$(tput setaf 7) → git merge
    $(tput setaf 1)mettit sottò sistem$(tput setaf 7) | $(tput setaf 2)rbm$(tput setaf 7) → rebase da master
    $(tput setaf 1)aggiorna e mettit sott$(tput setaf 7) | $(tput setaf 2)prbm$(tput setaf 7) → pull+rebase
    $(tput setaf 1)vai avanti$(tput setaf 7) | $(tput setaf 2)rbc$(tput setaf 7) → continua rebase
    $(tput setaf 1)ferma tutt$(tput setaf 7) | $(tput setaf 2)rba$(tput setaf 7) → annulla rebase

$(tput setaf 7)  📤 $(tput setaf 5)PUSH & PULL$(tput setaf 7)
    $(tput setaf 1)pigl 'a merce$(tput setaf 7) | $(tput setaf 2)p$(tput setaf 7) → git pull
    $(tput setaf 1)manna 'a merce$(tput setaf 7) | $(tput setaf 2)pu$(tput setaf 7) → git push
    $(tput setaf 1)spacca tutt$(tput setaf 7) | $(tput setaf 2)puf$(tput setaf 7) → git push -f $(tput setaf 1)⚠️$(tput setaf 7)

$(tput setaf 7)  📝 $(tput setaf 5)ADD, STATUS & COMMIT$(tput setaf 7)
    $(tput setaf 1)mett dintò sacc$(tput setaf 7) | $(tput setaf 2)a$(tput setaf 7) → git add .
    $(tput setaf 1)comm stann 'e ccose$(tput setaf 7) | $(tput setaf 2)st$(tput setaf 7) → git status
    $(tput setaf 1)segna 'a moviment$(tput setaf 7) | $(tput setaf 2)c$(tput setaf 7) → add + commit

$(tput setaf 7)  💾 $(tput setaf 5)STASH$(tput setaf 7)
    $(tput setaf 1)scunne 'a roba$(tput setaf 7) | $(tput setaf 2)as$(tput setaf 7) → add + stash
    $(tput setaf 1)scunne$(tput setaf 7) | $(tput setaf 2)s$(tput setaf 7) → git stash
    $(tput setaf 1)tira for 'a roba$(tput setaf 7) | $(tput setaf 2)sa$(tput setaf 7) → stash apply

$(tput setaf 7)  📜 $(tput setaf 5)LOG & HISTORY$(tput setaf 7)
    $(tput setaf 1)vir 'a storia$(tput setaf 7) | $(tput setaf 2)l$(tput setaf 7) → git log

$(tput setaf 7)  ⏮️  $(tput setaf 5)RESET$(tput setaf 7)
    $(tput setaf 1)torna arrèt accort$(tput setaf 7) | $(tput setaf 2)rs$(tput setaf 7) → reset --soft
    $(tput setaf 1)brucia tutt cos$(tput setaf 7) | $(tput setaf 3)resetta tutt cos$(tput setaf 7) | $(tput setaf 2)rh$(tput setaf 7) → reset --hard $(tput setaf 1)⚠️$(tput setaf 7)

$(tput setaf 7)  🗜️  $(tput setaf 5)SQUASH$(tput setaf 7)
    $(tput setaf 1)accumpagna 'e cose$(tput setaf 7) | $(tput setaf 2)sq$(tput setaf 7) → squash N commit (nuovo messaggio)
    $(tput setaf 1)accumpagna accussì$(tput setaf 7) | $(tput setaf 2)sql$(tput setaf 7) → squash (mantieni ultimo messaggio)

$(tput setaf 7)  🔧 $(tput setaf 5)UTILITÀ$(tput setaf 7)
    $(tput setaf 3)help$(tput setaf 7) | $(tput setaf 2)h$(tput setaf 7) → questo menu
    $(tput setaf 3)restart$(tput setaf 7) | $(tput setaf 2)r$(tput setaf 7) → riavvia banner
    $(tput setaf 3)pulisci e ricomincia$(tput setaf 7) | $(tput setaf 2)cr$(tput setaf 7) → clear + restart
    $(tput setaf 3)esci$(tput setaf 7) / $(tput setaf 3)exit$(tput setaf 7) | $(tput setaf 2)q$(tput setaf 7) → esci

$(tput setaf 6)  ═══════════════════════════════════════════════════════════════════════════
$(tput setaf 3)  💡 TIP: Comandi $(tput setaf 2)brevi$(tput setaf 3) per velocità, comandi $(tput setaf 1)Gomorra$(tput setaf 3) per divertimento!
$(tput setaf 3)  🎭 Reset hard mantiene anche "$(tput setaf 7)resetta tutt cos$(tput setaf 3)" per sicurezza 🔫
$(tput setaf 6)  ═══════════════════════════════════════════════════════════════════════════
$(tput sgr0)
    "
}

#==============================================================================
# FUNZIONI GIT - CLONE
#==============================================================================

# Clona una repository Git da un URL fornito dall'utente
git_clone() {
    echo "Damm 'o link d'a repo (Dammi il link della repository) [vuoto p'ascì]:"
    read -e git_url
    
    if [ "$git_url" ]
    then
        git clone "$git_url"
        echo
    else
        echo "Jamm bello, nient 'a fa"
    fi
}

#==============================================================================
# FUNZIONI GIT - COMMIT
#==============================================================================

# Esegue git add . seguito da git commit con un messaggio personalizzato
git_commit() {
    check_git_repo || return
    echo "Che vuò scriv p'sta moviment? (Che vuoi scrivere per questa modifica?) [vuoto p'ascì]:"
    read -e commit_message
    
    if [ "$commit_message" ]
    then
        git add . || { show_error "Nun pozz mett 'e file! (Impossibile aggiungere i file!)"; return 1; }
        git commit -m "$commit_message" || { show_error "'A moviment nun s'è registrata! (Il commit non è riuscito!)"; return 1; }
        git log -2
        echo
    else
        echo "Va buon, nisciun moviment"
    fi
}

#==============================================================================
# FUNZIONI GIT - RESET
#==============================================================================

# Esegue un reset soft, tornando indietro di N commit mantenendo le modifiche staged
git_reset_soft() {
    check_git_repo || return
    echo "Quante moviment vuò caccià arrèt? (Quanti commit indietro?) [RESET SOFT - Digita $(tput setaf 6)0$(tput setaf 7) p'ascì]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --soft HEAD~$commit_number || { show_error "Nun pozz turnà arrèt! (Impossibile fare il reset!)"; return 1; }
        
        echo
        echo "$(tput setaf 6)✓ Turnato arrèt accumpanat (Reset soft effettuato)$(tput sgr0)"
        echo
        git log -2
        echo
    else
        echo "Statt accumpanat"
    fi
}

# Esegue un reset hard, tornando indietro di N commit e scartando tutte le modifiche
git_reset_hard() {
    check_git_repo || return
    echo "Quante moviment vuò bruciare? (Quanti commit cancellare?) [RESET HARD - Digita $(tput setaf 6)0$(tput setaf 7) p'ascì]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --hard HEAD~$commit_number || { show_error "Nun pozz bruciare tutt cos! (Impossibile fare il reset!)"; return 1; }
        
        echo
        echo "$(tput setaf 6)✓ Tutt cos è bruciato! (Reset hard effettuato!)$(tput sgr0)"
        echo
        git log -2
        echo
    else
        echo "Statt accumpanat"
    fi
}

#==============================================================================
# FUNZIONI GIT - BRANCH MANAGEMENT
#==============================================================================

# Crea e fa checkout su un nuovo branch
git_add_branch() {
    check_git_repo || return
    echo "Comm s'adda chiamm 'o nuovo clan? (Come si deve chiamare il nuovo branch?) [vuoto p'ascì]:"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git checkout -b "$branch_name" || { show_error "Nun pozz fundà stu clan! (Impossibile creare il branch!)"; return 1; }
        echo
        git branch
    else
        echo "Nisciun clan fondato"
    fi
}

# Pubblica il branch corrente su origin (git push -u origin <branch>)
git_publish_branch() {
    check_git_repo || return
    current_branch=`git branch --show-current`
    
    if [ -z "$current_branch" ]; then
        show_error "Nun saccio addò stongo! (Impossibile determinare il branch corrente!)"
        return 1
    fi
    
    git push -u origin $current_branch || { show_error "Nun pozz fa' sapé a nisciuno! (Impossibile pubblicare il branch!)"; return 1; }
}

# Elimina un branch specificato dall'utente (git branch -D)
git_delete_branch() {
    check_git_repo || return
    git branch
    echo
    echo "Quale clan vuò sciogl? (Quale branch vuoi eliminare?) [vuoto p'ascì]:"
    read -e branch_name
    
    if [ "$branch_name" ]
    then
        git branch -D "$branch_name" || { show_error "Nun pozz sciogl stu clan! (Impossibile eliminare il branch!)"; return 1; }
        echo
        git branch
    else
        echo "Nisciun clan sciolto"
    fi
}

# Elimina il branch corrente dopo essere passato al branch principale
# Previene l'eliminazione del branch principale
git_delete_current_branch() {
    check_git_repo || return
    current_branch=`git branch --show-current`
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    
    if [ "$current_branch" = "$master" ]; then
        show_error "'O sistema nun se tocca! (Il branch principale non si elimina!)"
        return 1
    fi
    
    git checkout $master || { show_error "Nun pozz turnà dò sistema! (Impossibile tornare al master!)"; return 1; }
    git branch -D $current_branch || { show_error "Nun pozz sciogl stu clan! (Impossibile eliminare il branch!)"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - CHECKOUT
#==============================================================================

# Mostra un menu interattivo per selezionare e fare checkout su un branch
git_checkout() {
    check_git_repo || return
    branches=($(git branch | awk '{print $1}'))
    options=("${branches[@]}" "Esci")
    
    # Menu interattivo
    PS3="Seleziona una branch: "
    select branch in "${options[@]}"
    do
        case $branch in
            "Esci")
                break
            ;;
            *)
                git checkout "$branch" || { show_error "Nun pozz passà a chillu clan! (Impossibile cambiare branch!)"; return 1; }
                break
            ;;
        esac
    done
}

# Fa checkout sul branch principale (master/main) del repository
git_checkout_master() {
    check_git_repo || return
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master || { show_error "Nun pozz turnà dò sistema! (Impossibile tornare al master!)"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - MERGE
#==============================================================================

# Mostra un menu interattivo per selezionare e mergiare un branch
git_merge() {
    check_git_repo || return
    branches=($(git branch | awk '{print $1}'))
    options=("${branches[@]}" "Esci")
    
    # Menu interattivo
    PS3="Seleziona una branch da mergiare: "
    select branch in "${options[@]}"
    do
        case $branch in
            "Esci")
                break
            ;;
            *)
                git merge "$branch" || { show_error "Nun pozz alleà sti clan! (Impossibile fare il merge!)"; return 1; }
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
    git rebase $master || { show_error "Nun pozz mett sottò sistema! (Impossibile fare il rebase!)"; return 1; }
}

# Va sul branch principale, fa pull, torna indietro e fa rebase
# Utile per aggiornare il branch corrente con le ultime modifiche del principale
git_pull_rebase_master() {
    check_git_repo || return
    master=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    git checkout $master || { show_error "Nun pozz turnà dò sistema! (Impossibile tornare al master!)"; return 1; }
    git pull || { show_error "Nun pozz piglià 'a merce! (Impossibile fare pull!)"; return 1; }
    git checkout - || { show_error "Nun pozz turnà addò stevo! (Impossibile tornare al branch precedente!)"; return 1; }
    git rebase $master || { show_error "Nun pozz mett sottò sistema! (Impossibile fare il rebase!)"; return 1; }
}

#==============================================================================
# FUNZIONI GIT - PUSH & PULL
#==============================================================================

# Push forzato con messaggio di avviso prima e dopo l'operazione
git_push_force() {
    check_git_repo || return
    echo "$(tput setaf 1)⚠️  Stai facenn nu push forzato! (Stai per fare un push forzato!)$(tput sgr0)"
    git push -f && echo "$(tput setaf 3)✓ Tutto spaccato! (Push forzato completato!)$(tput sgr0)"
}

#==============================================================================
# FUNZIONI GIT - SQUASH
#==============================================================================

# Fa lo squash di N commit in uno solo con un nuovo messaggio
# Utile per comprimere più commit in uno prima di fare push
git_squash() {
    check_git_repo || return
    echo "Quante moviment vuò accumpagnà? (Quanti commit unire?) [SQUASH - Digita $(tput setaf 6)0$(tput setaf 7) p'ascì]"
    read -e commit_number
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        echo "Che vuò scriv p'sta moviment? (Che messaggio vuoi?) [vuoto p'ascì]:"
        read -e commit_message
        
        if [ "$commit_message" ]
        then
            git reset --soft HEAD~$commit_number || { show_error "Nun pozz turnà arrèt! (Impossibile fare il reset!)"; return 1; }
            git add . || { show_error "Nun pozz mett 'e file! (Impossibile aggiungere i file!)"; return 1; }
            git commit -m "$commit_message" || { show_error "'A moviment nun s'è registrata! (Il commit non è riuscito!)"; return 1; }
            git log -2
            echo
            echo "$(tput setaf 6)✓ Tutt cos accumpagnato! (Squash effettuato!)$(tput sgr0)"
        else
            echo "Nient 'a accumpagnà"
        fi
    else
        echo "Nient 'a accumpagnà"
    fi
}

# Fa lo squash di N commit mantenendo il messaggio dell'ultimo commit
git_squash_last_commit() {
    check_git_repo || return
    echo "Quante moviment vuò accumpagnà? (Quanti commit unire?) [SQUASH CON ULTIMO MESSAGGIO - Digita $(tput setaf 6)0$(tput setaf 7) p'ascì]"
    read -e commit_number
    
    last_commit_message=$(git log -1 --pretty=%B)
    
    if [[ "$commit_number" =~ ^[0-9]+$ ]] && [[ "$commit_number" -gt 0 ]]
    then
        git reset --soft HEAD~$commit_number || { show_error "Nun pozz turnà arrèt! (Impossibile fare il reset!)"; return 1; }
        git add . || { show_error "Nun pozz mett 'e file! (Impossibile aggiungere i file!)"; return 1; }
        git commit -m "$last_commit_message" || { show_error "'A moviment nun s'è registrata! (Il commit non è riuscito!)"; return 1; }
        git log -2
        echo
        echo "$(tput setaf 6)✓ Tutt cos accumpagnato! (Squash effettuato!)$(tput sgr0)"
    else
        echo "Nient 'a accumpagnà"
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
        "pigliat 'a roba" | "cln")
            git_clone
        ;;
        
        # FETCH - Aggiorna i riferimenti remoti
        "controlla 'o giro" | "f")
            check_git_repo && git fetch
        ;;
        
        # BRANCH - Visualizza tutti i branch
        "vir 'e clan" | "b")
            check_git_repo && git branch
        ;;
        
        # Crea un nuovo branch
        "fonda nu clan" | "ab")
            git_add_branch
        ;;
        
        # Pubblica il branch corrente su origin
        "fai sapé a tutt" | "pb")
            git_publish_branch
        ;;
        
        # Elimina un branch specifico
        "leva 'o clan" | "db")
            git_delete_branch
        ;;
        
        # Elimina il branch corrente
        "sciogliere stu clan" | "dcb")
            git_delete_current_branch
        ;;
        
        # CHECKOUT - Cambia branch tramite menu interattivo
        "passa a n'atu clan" | "ch")
            git_checkout
        ;;
        
        # Passa al branch principale (master/main)
        "torna dò sistema" | "chm")
            git_checkout_master
        ;;
        
        # Torna al branch precedente
        "torna arè" | "chl")
            check_git_repo && git checkout -
        ;;
        
        # MERGE - Mergia un branch nel corrente
        "alleat 'e clan" | "m")
            git_merge
        ;;
        
        # REBASE - Fa rebase dal branch principale
        "mettit sottò sistem" | "rbm")
            git_rebase_master
        ;;
        
        # Pull + Rebase dal branch principale
        "aggiorna e mettit sott" | "prbm")
            git_pull_rebase_master
        ;;
        
        # Continua un rebase dopo aver risolto i conflitti
        "vai avanti" | "rbc")
            check_git_repo && git rebase --continue
        ;;
        
        # Annulla un rebase in corso
        "ferma tutt" | "rba")
            check_git_repo && git rebase --abort
        ;;
        
        # PULL - Scarica e integra le modifiche dal remoto
        "pigl 'a merce" | "p")
            check_git_repo && git pull
        ;;
        
        # PUSH - Carica le modifiche sul remoto
        "manna 'a merce" | "pu")
            check_git_repo && git push
        ;;
        
        # Push forzato (attenzione: sovrascrive la storia remota)
        "spacca tutt" | "puf")
            git_push_force
        ;;
        
        # ADD - Aggiunge tutti i file modificati allo stage
        "mett dintò sacc" | "a")
            check_git_repo && git add .
        ;;
        
        # STATUS - Mostra lo stato dei file
        "comm stann 'e ccose" | "st")
            check_git_repo && git status
        ;;
        
        # STASH - Aggiunge i file e li salva nello stash
        "scunne 'a roba" | "as")
            if check_git_repo; then
                git add .
                git stash && echo "$(tput setaf 6)✓ Roba scunnuta! (Tutto salvato nello stash!)$(tput sgr0)"
            fi
        ;;
        
        # Salva le modifiche correnti nello stash
        "scunne" | "sarba" | "s")
            check_git_repo && git stash
        ;;
        
        # Applica le modifiche salvate nello stash
        "tira for 'a roba" | "sa")
            check_git_repo && git stash apply && echo "$(tput setaf 6)✓ Roba tirata fora! (Stash applicato!)$(tput sgr0)"
        ;;
        
        # LOG - Visualizza la cronologia dei commit
        "vir 'a storia" | "l")
            check_git_repo && git log
        ;;
        
        # COMMIT - Aggiunge tutti i file e crea un commit
        "segna 'a moviment" | "c")
            git_commit
        ;;
        
        # RESET SOFT - Torna indietro di N commit mantenendo le modifiche
        "torna arrèt accort" | "rs")
            git_reset_soft
        ;;
        
        # RESET HARD - Torna indietro di N commit scartando tutto
        "brucia tutt cos" | "resetta tutt cos" | "rh")
            git_reset_hard
        ;;
        
        # SQUASH - Comprime N commit in uno con nuovo messaggio
        "accumpagna 'e cose" | "sq")
            git_squash
        ;;
        
        # SQUASH - Comprime N commit mantenendo l'ultimo messaggio
        "accumpagna accussì" | "sql")
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
            echo "$(tput setaf 6)Jamme bella, ce verimm!$(tput sgr0)"
            exit 0
        ;;
        
        # Comando vuoto - Ignora e continua
        "")
            # Non fare nulla
        ;;
        
        # Comando non riconosciuto - Mostra messaggio di errore
        *)
            show_error "Stu comando nun 'o cunosco! (Comando non riconosciuto: '$command')"
            echo "Digita $(tput setaf 6)'help'$(tput setaf 7) o $(tput setaf 6)'h'$(tput setaf 7) p'a lista d'e comandi (per la lista)$(tput sgr0)"
        ;;
    esac
done