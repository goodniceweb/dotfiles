# nav aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if [ -f $HOME/.bashenv ]; then
      . $HOME/.bashenv
fi

# -v /home/a/info/taxipixi/docker:/data/db \
# -v /home/a/info/taxipixi/docker_hd:/var/jenkins_home \
# docker
alias mongo_docker="docker run --rm \
-v $MONGO:/data/db \
-p 27017:27017 \
--name mongodb \
mongod:2.6"
alias jenkins_docker="docker run --rm \
-p 8080:8080 \
-v $JENKINS:/var/jenkins_home \
--name myjenkins \
--link mongodb:db \
taxipixi/jenkins:latest"

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

export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export PATH="$PATH:$HOME/.rvm/bin"
