###############################################################################
#                              Settings
###############################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# Shows time and date for history command
export HISTTIMEFORMAT="%d/%m/%y %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar 
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
#                              Common aliases
###############################################################################

alias srbr='source ~/.bashrc'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias default_shell='echo $SHELL'
alias current_shell='echo $0'
alias dumd1='sudo du -h --max-depth=1 | sort -hr'

###############################################################################
#                    Linux version and architecture info
###############################################################################

# Command to find linux version
alias lnxver='lsb_release -a'

# Command to find kernel, hardware arch and os related information
alias hw_ker_os_info='uname -a'

# Command to get complete hardware information
alias full_hw_info='sudo lshw'

# Command to get short summary of hardware information
alias short_hw_info='lshw -short'

###############################################################################
#                              Utility functions
###############################################################################

# Function to delete files recursively which has a wildcard pattern
# $1 = path, $2 = Wildcard, for example \*.o. note: * has to be escaped
function delrec()
{
  find $1 -type f -name "$2" -delete
}

# Function to replace words recursively
# $1 = path, $2 = string to be replaced, $3 = replacing string
function reprec()
{
  find $1 -type f -exec sed -i "s/$2/$3/g" {} \;
}

function s256() #for linux
{
  read -s P
  echo -n $P | sha256sum | tr -d '\n -' | xclip -selection clipboard
  history -c
  exit
}

# Set title of current terminal
setTerminalTitle()
{
  wmctrl -r :ACTIVE: -N "$1"
}
alias termName=setTerminalTitle

###############################################################################
#                              git related
###############################################################################

# Function to add email to git
function git_email_conf()
{
  if [ -z "$1" ]
  then
    echo "email id is empty, please enter a valid email ID"
    return
  fi
  git config --global user.email "$1"
}

###############################################################################
#                              tar related
###############################################################################

#Creates a tar.gz file, use it as "do_tar newfile.tar.gz oldfile"
alias do_tar='tar -cvzf'

#Creates a tar.gz file, use it as "do_untar file.tar.gz"
alias do_untar='tar -xvf'

###############################################################################
#                              golang related
###############################################################################

#List all golang related environment variables
alias goenv='go env'

###############################################################################
#                              xclip related
###############################################################################
alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'

###############################################################################
# Set title of current terminal
setTerminalTitle()
{
  wmctrl -r :ACTIVE: -N "$1"
}
alias termName=setTerminalTitle


###############################################################################
#                            DELL Laptop specefic
###############################################################################

alias sshzm='ssh -X mjanardhana@192.168.50.7'
alias sshzm2='ssh -X mjanardhana@10.22.16.34'
alias sshzm3='ssh -X mjanardhana@192.168.178.24'
