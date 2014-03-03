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
    if [ $cur = $last ]
    then
        local options=`awk '{print $1}' ${hosts_path} | tr ',' '\n'`
        local cur=${word}
    else
        local options=`awk '{print $1}' ${hosts_path} | tr ',' '\n' | awk 'h="@" {print h$1}'`
    fi
    COMPREPLY=( $(compgen -W "${options}" -- ${cur}) )
}

complete -F __ssh_HUB ssh
