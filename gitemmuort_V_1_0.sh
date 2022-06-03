#!/bin/bash
echo "
$(tput setaf 6)   _____ _____ _______ ______ __  __ __  __ _    _  ____  _____ _______ 
$(tput setaf 6)  / ____|_   _|__   __|  ____|  \/  |  \/  | |  | |/ __ \|  __ \__   __|
$(tput setaf 6) | |  __  | |    | |  | |__  | \  / | \  / | |  | | |  | | |__) | | |   
$(tput setaf 6) | | |_ | | |    | |  |  __| | |\/| | |\/| | |  | | |  | |  _  /  | |   
$(tput setaf 6) | |__| |_| |_   | |  | |____| |  | | |  | | |__| | |__| | | \ \  | |   
$(tput setaf 6)  \_____|_____|  |_|  |______|_|  |_|_|  |_|\____/ \____/|_|  \_\ |_| $(tput setaf 5) V 1.0
"
echo "$(tput setaf 7)"

$path_check="false"

while [$path_check=="false"]:
do
	echo "Inserisci percorso"
	read path
	echo $path
	cd $path
	if [$? -eq 0]; then $path_check="true"
done


git_help() {
	echo "
	$(tput setaf 7)  _____________________________________
	$(tput setaf 7) |                                     |
	$(tput setaf 7) | git piliamm $(tput setaf 5) > $(tput setaf 6) git pull $(tput setaf 7)           |
	$(tput setaf 7) | git sarba $(tput setaf 5) > $(tput setaf 6) git push $(tput setaf 7)             |
	$(tput setaf 7) | git sarba sicuro $(tput setaf 5) > $(tput setaf 6) git push -f $(tput setaf 7)   |
	$(tput setaf 7) | git puliziamm $(tput setaf 5) > $(tput setaf 6) git stash $(tput setaf 7)        |
	$(tput setaf 7) | git situescion $(tput setaf 5) > $(tput setaf 6) git log $(tput setaf 7)         |
	$(tput setaf 7) |_____________________________________|
	"
}

echo
echo "Inserisci un comando (digita $(tput setaf 6)'help'$(tput setaf 7) per la lista dei comandi)"

while :
do
	read command
	
	case $command in
	
		"git piliamm")
			git pull
			;;

		"git sarba")
			git push
			;;

		"git sarba sicuro")
			git push -f
			;;

		"git puliziamm")
			git stash
			;;

		"git situescion")
			git log
			;;

		"help")
			git_help
			;;

		*)
			$command
			;;
	esac
done