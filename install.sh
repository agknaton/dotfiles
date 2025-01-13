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


printmessage () {
	echo ""
	echo "--------------------------------------------"
	echo $1
	echo "--------------------------------------------"
}


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
	printmessage "Update the package manager cache"
	Run $PKG_UPDATE

	printmessage "Upgrade the installed packages"
	Run $PKG_UPGRADE

	printmessage "Run pre-install commands"
	printmessage "    - Create support folders"
	Run mkdir -p ~/temp
	Run mkdir -p ~/apps_data
	printmessage "    - Make sure curl is installed"
	Run sudo apt-get install -y curl
	printmessage "    - Install nodejs"
	# nodejs is required for GitHub Copilot
	Run cd ~/temp
	Run curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
	Run sudo -E bash nodesource_setup.sh
	Run sudo apt-get install -y nodejs
	Run rm -rf nodesource_setup.sh
	Run cd ~

	printmessage "Install system packages"
	Run $PKG_INSTALL $(xargs echo <pkgs_install.txt)

	printmessage "Install python packages"
	Run pip install -r pip_pkgs.txt

	printmessage "Install todotxt-cli"
	if [ $TARGET_SYSTEM == "debian" ]; then
		Run cd ~/temp
		Run git clone https://github.com/todotxt/todo.txt-cli.git
		Run cd todo.txt-cli
		Run mkdir -p temp
		Run make
		Run sudo make install CONFIG_DIR=temp INSTALL_DIR=/usr/bin BASH_COMPLETION=/usr/share/bash-completion/completions
		Run cd ..
		Run sudo rm -rf todo.txt-cli
		Run sudo rm -rf .todo-txt
		Run cd ~
	else
		Run $PKG_CMD todotxt-cli
	fi

	printmessage "Install latest NeoVim"
	Run cd ~/temp
	Run curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	Run sudo rm -rf /opt/nvim
	Run sudo tar -C /opt -xzf nvim-linux64.tar.gz
	Run sudo ln -s /opt/nvim-linux64/bin/nvim /opt/nvim
	Run rm -rf nvim-linux64.tar.gz
	Run cd ~
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

