# Base-files version 3.6-1

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
# esac

# History Options
# ###############

# Don't put duplicate lines in the history.
# export HISTCONTROL=ignoredups

# Ignore some controlling instructions
# export HISTIGNORE="[   ]*:&:bg:fg:exit"
export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
# alias df='df -h'
# alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
export GREP_OPTIONS='--color=auto'
export CLICOLOR=1
# use yellow for directories
export LSCOLORS=dxfxcxdxbxegedabagacad

# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #
alias e='/Applications/Aquamacs.app/Contents/MacOS/bin/emacsclient -n'

# Functions
# #########
function uc () { awk -F" " "!_[\$$1]++"; }
# Some example functions
# function settitle() { echo -n "^[]2;$@^G^[]1;$@^G"; }

# alias ri='RI="${RI} -f ansi" LESS="${LESS}-f-R" ri'
# export VIM=/usr/share/vim

alias emacs="/Applications/Aquamacs.app/Contents/MacOS/bin/emacsclient -n"
alias eb="/Applications/Aquamacs.app/Contents/MacOS/Aquamacs -nw -batch"
export EDITOR=emacs


# Brew bash shell completions - https://docs.brew.sh/Shell-Completion
if type brew 2&>/dev/null; then
  source "$(brew --prefix)/etc/bash_completion"
else
  echo "run: brew install git bash-completion"
fi

# PS1="[\!] \[\033[1;31m\]\u\[\033[0m\] \t [ \[\033[1;36m\]\H\[\033[0m\]:\[\033[1;33m\]\w\[\033[0m\] ] \n> "
#
__git_ps1 () {
    local b="$(git branch 2>/dev/null|grep '^*' | colrm 1 2)" || return
    if [ -n "$b" ]; then
        echo -ne "[${b}]"
    fi
}

PS1="\u@\h \w \[\033[1;35m\]\$(__git_ps1)\[\033[0m\]\$ "

export MYSQL_PS1="mysql [\d] >"
alias git_me='git config --local user.email emarcetta@gmail.com && git config --local --unset user.name'

# Mysql grant privileges
__mysql_grant () {
    echo $1 | grep -E -q '^[a-zA-Z]+$' || { echo "Alpha argument required, '${1}' provided."; return; }
    mysql --host=localhost --user=root << END

GRANT ALL on ${1}_test.* to 'steam'@'%';
GRANT ALL on ${1}_development.* to 'steam'@'%';
GRANT ALL on ${1}_production.* to 'steam'@'%';

END

}
alias my_grant=__mysql_grant

# gems
# https://gist.github.com/IanVaughan/2902499
# prompt
# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
__uninstall_gems() {
  read -p "Remove all gems in `rbenv version` (y/n)?" -n 1 -r
  echo
  if ! [[ $REPLY =~ ^[Yy]$ ]]
  then
     return 0
  fi
  list=`gem list --no-versions`
  for gem in $list; do
    gem uninstall $gem -aIx
  done
  gem list
  gem install bundler
}

alias gem_uall=__uninstall_gems

source /Users/emil/.profile
