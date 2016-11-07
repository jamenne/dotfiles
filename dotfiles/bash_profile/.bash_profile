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
# System Python with packages in ~/Library/Python/2.7: preferred Python path
    export PATH=${HOME}/Library/Python/2.7/bin:${PATH}

# Java
    export JAVA_HOME=$(/usr/libexec/java_home)

# ROOT6
	export ROOTSYS=${HOME}/root/v6.06.08/build/
	source $ROOTSYS/bin/thisroot.sh


#### Alias
alias ls='ls -GFAh'
alias cpp="pwd | pbcopy"

# From https://coderwall.com/p/grmruq/git-status-on-all-repos-in-folder
alias gitsall="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"
alias gitpall="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git pull && echo)' \;"

alias mnte5hardware-cern="sshfs e5hardware-cern:/ ${HOME}/mount -o volname=e5hardware,auto_cache,reconnect,defer_permissions,noappledouble"