PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/tthompson/bin

# Prompt
#PS1="\u@\h:\w\$: "
PS1="[\h:]\w\$: "

#################
### FUNCTIONS ###
#################

# Hostname in tmux pane
SSHEXEC=$(which ssh)
conn() {
    if [ -n "$TMUX" ]
    then
        title="SERVER:$*"
        if [ "$1" = -t ]
        then
            title="$2"
            shift 2
        fi
    tmux rename-window "$title"
    "$SSHEXEC" "$@"
    else
        "$SSHEXEC" "$@"
fi
}
export -f conn

# Make a directory and cd into it
mcd () {
    mkdir -p "$1"
    cd "$1" || exit
}

extract () {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in "$@"
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
    grep "model name" /proc/cpuinfo | head -1 | awk '{ for (i = 4; i <= NF; i++) printf "%s ", $i }'
    printf "\n"a
    awk '{ printf "OS: %s %s %s %s | " , $1 , $2 , $3 , $4 }' /etc/issue
    uname -a | awk '{ printf "Kernel: %s " , $3 }'
    uname -m | awk '{ printf "%s | " , $1 }'
    printf "\n"
    uptime | awk '{ printf "Uptime: %s %s %s", $3, $4, $5 }' | sed 's/,//g'
    printf "\n"
    printf "MEMORY: "
    free -b | grep "Mem" | awk '{print $2, $3}' > /tmp/memdata
    while read -r total used
    do
        percent=$((200*used/total % 2 + 100*used/total))
        total_human=$(echo total | awk '{ byte = $1 /1024/1024**2 ; print byte "GB" }')
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
    process="$1"
    mypidfile="/tmp/killpidfile"
    pidof "$process" > "$mypidfile"
    mypid=$(head -1 /tmp/killpidfile)
    if [ "$mypid" != "" ]; then
        kill -9 "$mypid"
        kill_exit=$?
        if [[ "$kill_exit" == "0" ]]; then
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
    sudo dpkg -l | grep -i "$package"
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
    echo -n "$rawpass" | makepasswd --crypt-md5 --clearfrom - | awk '{print $2}'
}

# Put something on the clipboard
clip () {
    target=$1
    echo "$target" | xclip -sel clipboard
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

# KEYCHAIN
if [ -f $HOME/.mykeychain ]; then
        . $HOME/.mykeychain
fi
