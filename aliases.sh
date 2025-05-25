# Self made aliases for zsh

alias gs='git status'
alias gsu='git submodule update --init --recursive'
alias gp='git pull'
alias gool='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --stat --date=short'
alias tm='tmux'
alias tm_layout='tmuxp load /home/user/path/to/file.yml -d'


follow () {
        /home/user/scripts/follow.sh $@
}

search () {
        /home/user/scripts/search.sh $@
}

alias dp='docker ps'
alias dcu='docker compose up -d'
alias c='cd /mnt/c/Users/user/Downloads'
alias cde='conda deactivate'
alias valias='vim /home/user/scripts/aliases.sh'
alias src='exec zsh'
alias dockerclean='docker image rm $(docker images | grep "<none>" | awk '{print $3}' | tr '\n' ' ' | awk -F'%' '{print $1}')'

compare() {
        cmp --silent "$3/$1" "$3/$2" || echo "files are different"
}


lf() {
        list=$(ls | grep $1)
        echo $list
}

rlf() {
        rm $(ls | grep $1 | tr '\n' ' ')
}



# Suffix Aliases

# This will launch the specified file type in vscode when typing their directory
alias -s txt=code
alias -s py=code
alias -s cpp=code
alias -s c=code
alias -s hpp=code
# alias -s sh=code
alias -s md=code
alias -s json=code
