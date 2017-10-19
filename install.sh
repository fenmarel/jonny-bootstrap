#!/bin/bash


target="NONE"

function show_help {
	echo "-t <target os>   (options: osx, deb, rh)"
}

function is_valid_os {
	if [[ $1 != "osx" ]] && [[ $1 != "deb" ]] && [[ $1 != "rh" ]]; then
		echo 0
	else
		echo 1
	fi
}

while getopts "ht:" opt; do
    case "$opt" in
    h)
        show_help
        exit 0
        ;;
    t)  target=$OPTARG
		check=$(is_valid_os $target)
		if [[ $check == "0" ]]; then
			echo "Error:  Must specify a valid target os with the -t flag"
			exit 1
		fi
        ;;
    esac
done


echo "Deleting old bash dot files..."
rm $HOME/.bashrc $HOME/.bash_profile $HOME/.bash_ps1 $HOME/.bash_custom

echo "Linking new bash dot files..."
ln -s $(pwd)/bash_setup/.bashrc $HOME/.bashrc
ln -s $(pwd)/bash_setup/.bash_profile $HOME/.bash_profile
ln -s $(pwd)/bash_setup/.bash_ps1 $HOME/.bash_ps1
ln -s $(pwd)/bash_setup/.bash_custom $HOME/.bash_custom
. $HOME/.bashrc

if [[ ! -f $HOME/.bash_custom ]] ; then
  # don't mess with existing local configs
  echo "# Put local configs here, this will not be tracked by git" > $HOME/.bash_local
fi


echo "Deleting old dot files..."
rm $HOME/.gitconfig $HOME/.vimrc

echo "Linking assorted dot files..."
ln -s $(pwd)/dot_files/.gitconfig $HOME/.gitconfig
ln -s $(pwd)/dot_files/.vimrc $HOME/.vimrc


echo "Installing initial packages..."
if [[ $target == "osx" ]]; then
	if [[ ! $(which brew) ]]; then
		# install homebrew... it's "safe enough"...
		echo "Installing homebrew..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew install git bash-completion

else if [[ $target == "deb" ]]; then
	sudo apt update
	sudo apt upgrade
	sudo apt install git
fi



