# bash completion support for ssh.
#
# It provide support for completing hostname from your ~/.ssh/known_hosts file
#
# To use these routines:
#
#    1) Copy this file to somewhere (e.g. ~/.ssh-completion.sh).
#    2) Add the following line to your .bashrc:
#        source ~/.ssh-completion.sh

function __ssh_HUB() {
    local hosts_path=~/.ssh/known_hosts
    local word="${COMP_WORDS[COMP_CWORD]}"
    local last=@`echo ${word} | cut -d@ -f 1`
    local cur=@`echo ${word} | cut -d@ -f 2`
    local options=`cat ${hosts_path} | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`
    if [ $cur = $last ]
    then
        local cur=${word}
    else
        local options= `echo "${options}" | awk 'h="@" {print h$1}'`
    fi
    COMPREPLY=( $(compgen -W "${options}" -- ${cur}) )
}

complete -F __ssh_HUB ssh
