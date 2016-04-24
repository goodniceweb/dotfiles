# bashenv needs for customize bash depends on comp it's running
if [ -f $HOME/.bashenv ]; then
      . $HOME/.bashenv
fi

# nav aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# command line to system clipboard
# dependency:
# sudo apt-get install xclip
alias clip='xclip -sel clip < '

# useful staff when you work with ports and network
alias portusage='netstat -tulpn'

#TODO: move line below to git aliases
#alias make_patch='git format-patch -1 HEAD'
alias gitlbr='git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname) %(committerdate)" | sed "s/refs\/heads\///g" | column -t | head -n 15'
alias git-root='cd $(git rev-parse --show-cdup)'

# Don't use swap file
alias vim='vim -n'
alias vi='vim -n'

# I <3 rvm
alias r='reload_directory'

# to be honest: X in linux can fail from time to time :)
alias startx='startx -- -nolisten tcp'

# https://hub.github.com/
alias git='hub'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# Useful for long time tasks who blocks your current work
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# TODO: not work well for me
# git branch in prompt
# source ~/.git_config/git-prompt.sh

# func for kill -9 all processes
justkill() {
  ps -e -o pid,comm | grep $1 | awk {'print$1'} | xargs kill -9
}
killsidekiq() {
  ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9
}

# terminator title
ORIG=$PS1
# TITLE="\e]2;$PWD\a"
# https://www.digitalocean.com/community/tutorials/how-to-customize-your-bash-prompt-on-a-linux-vps
# PS1="\[\e[1;32m\]\u@\h \[\e[1;36m\]\w \W$(__git_ps1 " (%s)") \[\e[0m\]$ "
PS1="\[\e[1;32m\]\u@\h \[\e[1;36m\]\w \[\e[0m\]$ "
# PS1="\[\e[1;32m\]\u@\h \[\e[1;36m\]\w \[\e[1;35m\]$git_branch \[\e[0;37m\]$ "
# export PS1="\[\e[1;32m\]\u@\h \[\e[1;36m\]\w \[\e[1;35m\]$git_branch \[\e[0m\]$ "
# solution from here:
# http://superuser.com/questions/42362/gnome-terminal-process-name-in-tab-title
# If this is an xterm set the title to user@host:dir
# --------------------------------------------------
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'
    #PROMPT_COMMAND='echo -ne "\[\033]0;\u@\h:\w\007\]"'
    #TITLEBAR='\[\033]0;\u@\h:\w\007\]'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${PWD}: ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

# https://github.com/Linuxbrew/linuxbrew
# Installation
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/linuxbrew/go/install)"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# RVM
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# https://github.com/asdf-vm/asdf
. $HOME/.asdf/asdf.sh
