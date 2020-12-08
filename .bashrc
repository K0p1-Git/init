## if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth  ## don't put duplicate lines or lines starting with space in the history.
shopt -s histappend     ## append to the history file, don't overwrite it
HISTSIZE=1000           ## history file length
HISTFILESIZE=2000       ## history file size

shopt -s checkwinsize   ## check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

## set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes  ## Ofcourse color is enabled

## little helper function to help ID VPN
export VPNSTATUS=$(ifconfig | grep "tun0")
if [ -z "$VPNSTATUS" ]
then
	export IP=$(ifconfig eth0 | grep "inet " | cut -d " " -f 10)
else
	export IP=$(ifconfig tun0 | grep "inet " | cut -d " " -f 10)
	echo "Connected to OpenVPN : "$IP
fi

PS1='\[\e[0;1;2m\][\[\e[0;1;38;5;51m\]\u\[\e[0;1;2m\]@\[\e[0;1;93m\]\h\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;92m\]'$IP'\[\e[0;1;2m\]]\[\e[0;1;92m\]-\[\e[0;1;2m\][\[\e[0;1;38;5;50m\]\W\[\e[0;1;2m\]]\[\e[m\] \[\e[0;1;2m\]\$\[\e[m\] \[\e0'

## If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## aliases
alias ll='ls -l'
alias la='ls -A'
alias gl='git log --graph --oneline'
alias vi='vim'