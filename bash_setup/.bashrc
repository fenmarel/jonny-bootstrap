# Include bash customized config files

# if running bash
if [ -n "$BASH_VERSION" ]; then

    # include .bash_ps1 if it exists
    if [ -f "$HOME/.bash_ps1" ]; then
	. "$HOME/.bash_ps1"
    fi

    # include .bash_custom if it exists
    if [ -f "$HOME/.bash_custom" ]; then
	. "$HOME/.bash_custom"
    fi

    # include .bash_local if it exists
    if [ -f "$HOME/.bash_local" ]; then
	. "$HOME/.bash_local"
    fi

fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH="/usr/local/sbin:$PATH"
