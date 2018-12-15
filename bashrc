PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/tthompson/bin

# Prompt
#PS1="\u@\h:\w\$: "
PS1="[\h:]\w\$: "

# SSH shortcut
#function conn { ssh_conn "$1".hostname.com; }
#export -f conn

#################
### FUNCTIONS ###
#################

# Hostname in tmux pane
conn() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "SERVER:$(echo $* | cut -d . -f 1).hostname.com"
        command ssh -t "$@" "cd /home/tthompson; bash --rcfile /home/tthompson/.bashrc -i"
        #command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
        #command ssh -t "$@" "cd /home/tthompson; bash --rcfile /home/tthompson/.bashrc -i"
    fi;
    }
export -f conn

# Make a directory and cd into it
mcd () {
    mkdir -p $1
    cd $1
}

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
#    ps a | grep $1 > /dev/null
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

# Generate a password
genpass () {
    if [ -f "/usr/bin/pwgen" ]; then
        pwgen -y 20
    else
        echo "pwgen is not installed"
    fi
}


# Generate encrypted password
genhash () {
    rawpass=$1
    echo -n $rawpass | makepasswd --crypt-md5 --clearfrom - | awk '{print $2}'
}

# Get the last uid from puppet
lastuid () {
    grep uid /home/tthompson/build/repos/hostname/devops/puppet/trunk/modules/accounts/manifests/init.pp | awk '{print $3}' | cut -d "'" -f2 | sort -n | tail -n1
}

# Put something on the clipboard
clip () {
    target=$1
    echo $target | xclip -sel clipboard
}

# Recursive grep on the current directory
crawl () {
    target=$1
    mypath=$2

    if [ -z "$mypath" ]
    then
        grep -R "$target" . | grep -v grep | grep -v "pristine"
    else
        grep -R "$target" "$mypath" | grep -v grep | grep -v "pristine"
    fi
}

#####################
### END FUNCTIONS ###
#####################

###############
### ALIASES ###
###############

# ps
#alias ps="ps a"
alias psg="ps a | grep -v grep | grep -i -e VSZ -e"

# ls
alias lg="ls -l | grep -v grep | grep -i -e VSZ -e"

# Search history
alias hg="history | grep"

# See if system is listening on provided port
alias netport="sudo netstat -lntp | grep -v grep | grep -i 'listen' | grep -i -e VSZ -e"

# Get my IP address
alias myip="curl http://ipecho.net/plain; echo"

# df -h shortcut
alias df="df -h"

# Back to the previous directory
alias back='cd "$OLDPWD"'

# Update current svn repo
alias fresh="svn up"

# generate a cleartext password
alias gimmeapass='pwgen -sy 16 1'
