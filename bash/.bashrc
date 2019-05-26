set -o vi
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -n"

[ -d ~/dotfiles ] && for f in ~/dotfiles/bash/functions/*; do source $f; done

#############################
# Enable fzf cool stuff
#############################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# use ripgrep (default is find)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

_fzf_compgen_path() {
    rg -g "" "$1"
}

#####################
# GENERAL USE ALIASES
#####################
alias cp='cp -iv'  # copy a file with the verbose and warning flags
alias mv='mv -iv'  # move a file/dir with verbose and warning flags
alias mkdir='mkdir -pv'  # make directory with the path and verbose flags
alias cd..='cd ../'  # Go back 1 directory level
alias finder='open -a Finder ./'  # Open current directory in MacOS Finder
alias path='echo -e ${PATH//:/\\n}'  # Echo all executable Paths
alias numFiles='echo $(ls -1 | wc -l)'  # Count of non-hidden files in current dir
alias staticip='dig +short myip.opendns.com @resolver1.opendns.com' # get the static ip of the current network

# lr is a full recursive directory listing piped to less
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

###################
# QUICK NAV Aliases
###################
export GOCODE=$GOPATH/src/github.com/mistahchris/

#######################
# GENERAL USE FUNCTIONS
#######################
# Always list directory contents after 'cd'
cd () {
    builtin cd "$@"; ls -a;
}

# moves a file to the macOS Trash
trash () {
    command mv "$@" ~/.Trash ;
}

# opens a file in the macOS preview
preview () {
    qlmanage -p "$*" >& /dev/null;
}

# creates a zip archive folder
zipf () {
zip -r "$1".zip "$1" ;
}

# make a directory and change into it
mcd () {
        mkdir -p $1;
        cd $1;
}

# cdfinder changes the directory to the frontmost open finder window
cdfinder () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

# sets the contents of a file to the macOS clipboard
copy () {
        cat $1 | pbcopy
}

# kill a process by name
die () {
    name=$1
    firstChar=${name:0:1}
    rest=${name:1:${#name}}
    pid=`ps aux | grep "[$firstChar]$rest" | awk '{print $2}'`
    kill $pid
}

# extracts the git branch name
parseBranch() {
    git branch | grep "^\* " | sed "s/\* //g"
}

# useful for extracting compressed folders
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

PATH=$HOME/dotfiles/bin:$PATH
