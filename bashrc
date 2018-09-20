PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/tthompson/bin

# Prompt
PS1="\u@\h:\w\$: "

# SSH shortcut
# Change the domain as appropriate
#function conn { ssh "$1".domain.com; }
#export -f conn

#################
### FUNCTIONS ###
#################

# Hostname in tmux pane
# Obviously, this won't work w/o tmux installed
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "SERVER:$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi;
    }
export -f ssh

# Make a directory and cd into it
mcd () {
    mkdir -p $1
    cd $1
}

# The more of these utilities you have installed, the better this function works
extract () {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# A list of my 10 most-used commands
comstat () {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

# Basic system info
sysinfo () {
    printf "CPU: "
    cat /proc/cpuinfo | grep "model name" | head -1 | awk '{ for (i = 4; i <= NF; i++) printf "%s ", $i }'
    printf "\n"a
    cat /etc/issue | awk '{ printf "OS: %s %s %s %s | " , $1 , $2 , $3 , $4 }'
    uname -a | awk '{ printf "Kernel: %s " , $3 }'
    uname -m | awk '{ printf "%s | " , $1 }'
    printf "\n"
    uptime | awk '{ printf "Uptime: %s %s %s", $3, $4, $5 }' | sed 's/,//g'
    printf "\n"
    printf "MEMORY: "
    free -b | grep "Mem" | awk '{print $2, $3}' > /tmp/memdata
    while read total used
    do
        percent=$((200*$used/$total % 2 + 100*$used/$total))
        total_human=$(echo $total | awk '{ byte = $1 /1024/1024**2 ; print byte "GB" }')
        echo "$HOSTNAME is using $percent% of $total_human memory"
    done < /tmp/memdata
    rm -rf /tmp/memdata
    printf "\n"
    printf "DISK: "
    printf "\n"
    df -h
}

# Kill a process by name. USAGE: kp program_name
kp () {
    ps aux | grep $1 > /dev/null
    mypid=$(pidof $1)
    if [ "$mypid" != "" ]; then
        kill -9 $(pidof $1)
        if [[ "$?" == "0" ]]; then
            echo "PID $mypid ($1) killed."
        fi
    else
        echo "None killed."
    fi
    return;
}

# Count the number of characters in a string
charcount () {
    word=$1
    echo "${#word}"
}

# See if package is installed
installed () {
    package=$1
    rhel="rhel"
    redhat="redhat"
    ubuntu="ubuntu"
    if grep -qF "$rhel" /etc/os-release;then
        sudo yum list installed "$package"
    elif grep -qF -i "$redhat" /etc/os-release;then
        sudo yum list installed "$package"
    elif grep -qF -i "$ubuntu" /etc/os-release;then
        sudo dpkg -l | grep -i "$package"
    else
        echo "Could not determine OS"
    fi
}
#####################
### END FUNCTIONS ###
#####################

###############
### ALIASES ###
###############

# ps
alias ps="ps aux"
alias psg="ps | grep -v grep | grep -i -e VSZ -e"

# Search history
alias hg="history | grep"

# See if system is listening on provided port
alias netport="netstat -lntp | grep -v grep | grep -i 'listen' | grep -i -e VSZ -e"

# Get my IP address
alias myip="curl http://ipecho.net/plain; echo"

# df -h shortcut
alias df="df -h"

# Back to the previous directory
alias back='cd "$OLDPWD"'

# Update current svn repo
alias fresh="svn up"
