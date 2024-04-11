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
alias bye='shutdown now'
alias chx='chmod +x' $1
alias kbar='killall -q polybar'
alias get='sudo apt install -y'
alias asrc='apt search'
alias home='xrandr --output HDMI-0 --mode 1920x1080 --primary -r 144 --right-of DP-2 --output DisplayPort-1-2 --mode 3840x2160 --right-of HDMI-0'

# noita stuff
alias ghidra='~/Documents/ghidra/ghidra_11.0.1_PUBLIC/ghidraRun'
alias mods='cd /home/nathan/.local/share/Steam/steamapps/common/Noita/mods/'
alias data='cd ~/Documents/code/noitadata/data/'
alias fmods="mods && find . -maxdepth 1 -type d -exec sh -c '(cd {} && git fetch && git pull)' ';'"

# config editing
alias evim='e ~/.config/nvim/init.lua'
alias epl='cd ~/.config/nvim/lua/custom/; e'
alias ebash='e ~/.bash_aliases'
alias conf='cd ~/.config/nvim/; e'
alias rrc='source ~/.bashrc'

# cds
alias cod='cd ~/Documents/code/'
alias ..='cd ..'
alias ~='cd ~'
alias r='cd /'
alias b='cd -'
