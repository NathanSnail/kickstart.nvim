# vim
alias e='nvim_term'
alias v=nvim
alias vi=nvim
alias vim=nvim
alias fv='fd && e'

# general command line
alias ga='git add *'
function camp() {
	ga
	git commit -am "$1"
	git push
}
alias t='tree -L 2'
alias cat=bat
alias wina='lxc console windows --type=vga'
alias wins='lxc start windows --console=vga'
alias wink='lxc stop windows'
alias cls=clear # criminal offense but idc
alias py=python3
alias rgf='find . | rg' $1
alias fd='cd $(find . -type d | fzf)'
alias files='nautilus --browser .'
alias ghidra='~/Documents/ghidra/ghidra_11.0.1_PUBLIC/ghidraRun'
alias bye='shutdown now'
alias chx='chmod +x' $1

# config editing
alias evim='e ~/.config/nvim/init.lua'
alias epl='cd ~/.config/nvim/lua/custom/; e'
alias ebash='e ~/.bash_aliases'
alias conf='cd ~/.config/nvim/; e'
alias rrc='source ~/.bashrc'

# cds
alias cod='cd ~/Documents/code/'
alias mods='cd /home/nathan/.local/share/Steam/steamapps/common/Noita/mods/'
alias data='cd ~/Documents/code/noitadata/data/'
alias ..='cd ..'
alias ~='cd ~'
alias r='cd /'
