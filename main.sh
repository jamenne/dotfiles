#!/bin/sh

echo "Starting setup script. Continue (yes/no)?"
while True; do
	read answer
	if [ "$answer" == "yes" ]; then
		echo "Starting setup now."; break;
	elif [ "$answer" == "no" ]; then
		echo "Exiting."; exit;
	else
		echo "Please enter yes or no."
	fi
done


echo "-----------------------------------------------------------------------"
echo ":: Installing xcode command line tools ::"
xcode-select --install


echo "-----------------------------------------------------------------------"
echo ":: Installing homebrew ::"
if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "  Running brew update ..."
brew update

echo "  Install brews via brew bundle from Brewfile ..."
brew tap homebrew/bundle
brew bundle -v

echo "  Cleaning up brew binaries and cache to free disk space ..."
brew cask cleanup
rm -rf $(brew --cache)


echo "-----------------------------------------------------------------------"
echo ":: Stowing dotfiles to home folder ::"
for d in `ls ./dotfiles`; do
	stow --dir=dotfiles --target=${HOME} -v $d
done  # Unstow with -vD option

echo "-----------------------------------------------------------------------"
echo ":: Setting up OSX python ::"
chmod 744 ./python.sh
#./python.sh


echo "-----------------------------------------------------------------------"
echo ":: Install new dictionaries for Sublime Text 3"
git clone https://github.com/titoBouzout/Dictionaries.git ${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/Dictionaries/


echo "-----------------------------------------------------------------------"
echo ":: Update and setup MacTex ::"
echo "  Use new /etc/paths.d/TeX paths without starting a new terminal ..."
eval `/usr/libexec/path_helper -s`

echo "  Set some MacTe X settings ..."
sudo tlmgr option autobackup -- -1
sudo tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet

echo "  Update MacTeX ..."
sudo tlmgr update --self --all --reinstall-forcibly-removed


echo "#######################################################################"
echo "Done. Restart the terminal and you're ready to go."

