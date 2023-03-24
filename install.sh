#!/usr/bin/env bash

DESC="$0 -- System install in bash capable systems"

unset TEST

# Detects package management system
OS="`uname`"
case $OS in
	'Linux')
		if [ $(dpkg-query -W -f='${Status}' apt 2>/dev/null | grep -c "ok installed") -eq 1 ]
		then
			#PKG_CMD="$DRY_RUN_PREFFIX apt-get install";
			PKG_UPDATE="sudo apt-get update"
			PKG_UPGRADE="sudo apt-get upgrade"
			PKG_INSTALL="sudo apt-get install"
			TARGET_SYSTEM="debian"
		elif [ $(dpkg-query -W -f='${Status}' pacman 2>/dev/null | grep -c "ok installed") -eq 1 ]
		then
			PKG_CMD="pacman -S"
			"${DRY_RUN_PREFFIX} pacman -Syu"
		fi
		;;
	'Darwin')
		PKG_CMD="brew install"
		;;
	*) ;;
esac


Help ()
{
	echo "\
$DESC

Available options:

-d      Debug. Before command is run, show it.
-t      Test mode. Show commands, do not really execute.

The -t option takes precedence over -d option."

	exit ${1:-0}
}


Run ()
{
	if [ "$TEST" ]; then
		echo "$*"
		return 0
	fi

	if [ "$DEBUG" ]; then
		echo "$*"
	fi

	eval "$@"
}


Install ()
{
	echo "Update the package manager cache"
	Run $PKG_UPDATE

	echo "Upgrade the installed packages"
	Run $PKG_UPGRADE

	echo "Run pre-install commands"
	# nodejs is required for GitHub Copilot
	#curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&sudo apt-get install -y nodejs
	Run curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash -
	Run sudo apt-get install -y nodejs
	# Create support folders
	Run mkdir -p ~/apps_data

	echo "Install system packages"
	Run $PKG_INSTALL $(xargs echo <pkgs_install.txt)

	echo "Install python packages"
	Run pip install -r pip_pkgs.txt

	echo "Install todotxt-cli"
	if [ $TARGET_SYSTEM == "debian" ]; then
		Run git clone https://github.com/todotxt/todo.txt-cli.git
		Run cd todo.txt-cli
		Run mkdir -p temp
		Run make
		Run sudo make install CONFIG_DIR=temp INSTALL_DIR=/usr/bin BASH_COMPLETION=/usr/share/bash-completion/completions
		Run cd ..
		Run sudo rm -rf todo.txt-cli
		Run sudo rm -rf .todo-txt
	else
		Run $PKG_CMD todotxt-cli
	fi
}


Main ()
{
	OPTIND=1
	local arg

	while getopts "hdt" arg "$@"
	do
		case "$arg" in
			h)	Help
				;;
			t) TEST="test"
				;;
			d) DEBUG="debug"
				;;
		esac
	done

	# Remove found options from command line arguments.
	shift $(($OPTIND -1))

	# Run the install
	Install
}

Main "$@"

