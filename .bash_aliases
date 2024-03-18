alias t='tree -L 2'
alias e='nvim "+vsp +term" "+wincmd h" "+Ntree"'
alias v=nvim
alias vi=nvim
alias vim=nvim
alias ..='cd ..'
alias ~='cd ~'
alias r='cd /'
alias rgf='find . | rg' $1
alias fd='cd $(find . -type d | fzf)'
alias rrc='source ~/.bashrc'
alias e='nvim_term'
alias fv='fd && e'
alias evim='e ~/.config/nvim/init.lua'
alias ebash='e ~/.bash_aliases'
alias conf='cd ~/.config/nvim/; e'
alias cod='cd ~/Documents/code/'
alias cat=bat
alias ga='git add *'
function camp() {
	git commit -am "$1"
	git push
}
alias wina='lxc console windows --type=vga'
alias wins='lxc start windows --console=vga'
alias wink='lxc stop windows'

