alias t='tree -L 2'
alias e='nvim "+vsp +term" "+wincmd h" "+Ntree"'
alias vi=nvim
alias vim=nvim
alias ..='cd ..'
alias ~='cd ~'
alias r='cd /'
alias rgf='find . | rg' $1
alias fd='cd $(find . -type d -print | fzf)'
alias rrc='source ~/.bashrc'
alias e='nvim_term'
alias fv='fd && e'

