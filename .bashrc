#
# ~/.bashrc
#

shopt -s extglob
shopt -s dotglob

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=2000
PS1='[\u@\h \W]\$ '

# ALIASES
alias ls='ls --color=auto'
alias ll='ls -Fl --group-directories-first'
alias llm='ls -lFtr'
alias lla='ls -Fla --group-directories-first'
alias grep='grep --color=auto'
alias nano='vim'

# Privileged access aliases
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias poweroff='sudo shutdown -h 0'
fi

# EXTRACT function
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c='bsdtar xvf';;
            *.7z)  c='7z x';;
            *.Z)   c='uncompress';;
            *.bz2) c='bunzip2';;
            *.exe) c='cabextract';;
            *.gz)  c='gunzip';;
            *.rar) c='unrar x';;
            *.xz)  c='unxz';;
            *.zip) c='unzip';;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}

# OPEN DOC funtion
docview () {
    if [ -f $1 ] ; then
        case $1 in
            *.pdf)       evince $1    ;;
            *.odt)       lowriter $1     ;;
            *.txt)       less $1       ;;
            *.doc)       lowriter $1      ;;
            *)           echo "don't know how to open '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#myip - finds your current IP if your connected to the internet
myip ()
{
    lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
}

#screenshot - takes a screenshot of your current window
screenshot ()
{
    import -frame -strip -quality 85 "$HOME/screenshots/screen_$(date +%Y%m%d_%H%M%S).png"
}

#bu - Back Up a file. Usage "bu filename.txt" 
bu () { cp $1 ${1}-`date +%Y%m%d%H%M`.backup ; }

