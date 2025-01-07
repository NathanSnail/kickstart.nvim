# vim
# silly script no more
alias nvim_term=nvim
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
alias wina='sudo lxc console win11 --type=vga'
alias wins='sudo lxc start win11 --console=vga'
alias wink='sudo lxc stop win11'
alias cls=clear # criminal offense but idc
alias py=python3
alias rgf='find . | rg' $1
alias fd='z $(find . -type d | fzf)'
alias files='nautilus --browser .'
alias bye='shutdown now'
alias chx='chmod +x' $1
alias kbar='killall -q polybar'
alias get='sudo apt install -y'
alias asrc='apt search'
alias home='xrandr --output HDMI-0 --mode 1920x1080 --primary -r 144 --right-of DP-2 --output DisplayPort-1-2 --mode 3840x2160 --right-of HDMI-0 & xrandr --output HDMI-0 --mode 1920x1080 --primary -r 144 --right-of DP-2 --output DP-0 --mode 3840x2160 --right-of HDMI-0'
alias standard='home ; xrandr --output DP-2 --right-of DisplayPort-1-2 ; killall -q picom ; ~/.config/bspwm/bspwmrc ; kbar ; xrandr --output DisplayPort-2-2 --mode 3840x2160 --right-of HDMI-0 ; xrandr --output DP-2 --right-of DisplayPort-2-2 ; feh --bg-fill /home/nathan/Documents/bg.png ; picom --backend glx & disown'
alias uni='bspc monitor DP-2 -d I II III IV V'
alias hist='git log --graph --oneline --decorate'
for_each_line() {
	while IFS= read -r line; do
		printf '%s\n' "$line"
		line=$line "$@"
	done
}
alias night='xrandr --output DisplayPort-1-2 --gamma 1.0:0.88:0.66 --brightness 0.55 & xrandr --output HDMI-0 --gamma 1.0:0.88:0.76 --brightness 1'
alias day='xrandr --output DisplayPort-1-2 --gamma 1.0:1.0:1.0 --brightness 1 & xrandr --output HDMI-0 --gamma 1.0:1.0:1.0 --brightness 1'
alias doptr='bspc config pointer_follows_focus true && bspc config pointer_follows_monitor true && bspc config focus_follows_pointer true'
alias noptr='bspc config pointer_follows_focus false && bspc config pointer_follows_monitor false && bspc config focus_follows_pointer false'
unic() {
	gcc -Wall -Wextra -Werror -Wpedantic -pedantic-errors -std=c99 $1 -o out && ./out
}
valc() {
	gcc -Wall -Wextra -Wpedantic -g $1 -o out && valgrind --leak-check=full --track-origins=yes -s ./out
}
alias ctest='py /home/nathan/Documents/code/uni_c_tester/check_c.py' $1
alias yy='xclip -sel clip'
alias p='xclip -o'
alias what='echo $?'
alias matlab='/home/nathan/MATLAB/R2024a/bin/matlab'
cgr() {
	convert $1 -colorspace RGB -format %c -depth 8 histogram:info:- | rg $2
}

# noita stuff
alias ghidra='~/Documents/ghidra/ghidra_11.1.1_PUBLIC/ghidraRun'
alias mods='cd /home/nathan/.local/share/Steam/steamapps/common/Noita/mods/'
alias data='cd ~/Documents/code/noitadata/data/'
alias noita='z /home/nathan/.local/share/Steam/steamapps/common/Noita'
alias fmods="mods && find . -maxdepth 1 -type d -exec sh -c '(cd {} && git fetch && git pull)' ';'"
alias ecdoc='e ~/.local/share/Steam/steamapps/common/Noita/tools_modding/component_documentation.txt'
alias eldoc='e ~/.local/share/Steam/steamapps/common/Noita/tools_modding/lua_api_documentation.txt'
alias nqc='qalc -i -f ~/Documents/code/kickstart.nvim/noita_qalc'
function wmod() {
	cd /home/nathan/.local/share/Steam/steamapps/workshop/content/881100 &&
	cd $(find . -maxdepth 2 | rg mod_id.txt | xargs -I {} sh -c 'rg -i $1 < {} > /dev/null && echo $(echo {} | sed "s/mod_id.txt//g")' -- "$1") &&
	cat mod_id.txt
}

# config editing
alias evim='e ~/.config/nvim/init.lua'
alias epl='cd ~/.config/nvim/lua/custom/; e'
alias ebash='e ~/.bash_aliases'
alias conf='cd ~/.config/nvim/; e'
alias rrc='source ~/.zshrc'

# cds
alias cod='z ~/Documents/code/'
alias ..='z ..'
alias ~='z ~'
alias r='z /'
alias b='z -'
