# Fix El Capitan UTF8 encoding. Check via `locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# CLI Prefix: User:Path(blue)$
export PS1="\u:\[\e[34m\]\W\[\e[0m\]\$ "

# Bash completion from homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


#### Environment variables
# System Python with packages
    export PATH=${HOME}/Library/Python/2.7/bin:${PATH}

# Java
    export JAVA_HOME=$(/usr/libexec/java_home)

# ROOT6
	#export ROOTSYS=${HOME}/root/v6.06.08/build/
	#source $ROOTSYS/bin/thisroot.sh

# Init pyenv python version manager
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"; 
  export PYENV_VIRTUALENV_DISABLE_PROMPT=0
fi


#### Alias
alias ls='ls -GFAh'
alias cpp="pwd | pbcopy"

# From https://coderwall.com/p/grmruq/git-status-on-all-repos-in-folder
alias gitsall="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"
alias gitpall="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git pull && echo)' \;"

# function to mount machines
function mntsshfs {
    if [ "$1" == "-h" ]; then
      echo "Usage: mntsshfs <ssh_host> [remote_dir, '/']"
      echo "Mounts a remote file system via sshfs to ~/sshfs/<ssh_host>"
      return 0
    fi
    if [ -z "$1" ]; then
        echo "Need ssh host from config as argument. Exiting."; return 1 2>/dev/null;
    fi
    MNTDIR="${2:-/}"
    mkdir -p ${HOME}/sshfs/"$1"
    sshfs "$1":"$2" ${HOME}/sshfs/"$1" -o volname="$1",auto_cache,reconnect,defer_permissions,noappledouble
}

# handle insitu data
alias getinsitudata="rsync -avzu -e ssh e5hardware-cern:data ~/InsituIrrad/"
alias insitudatatofhgfs="rsync -avz -e ssh ~/InsituIrrad/data/insitu/ klaus-wacker:/fhgfs/groups/e5/lhcb/detector/scifi/insitu-irrad/Data/"


