# apt-get packages
alias install='sudo apt-get install'
alias update='sudo apt-get update'

# bash 
alias c='clear'
alias q='exit'
function so(){
	echo 'Reloading bash config'
	source ~/.bashrc
}
alias h='cd ~'

# nautilus 
alias fm='nautilus --no-desktop &'

# trayer
function tr(){
	nm-applet &
	trayer &
}
alias kt='killall trayer'

# gnone-open
alias go='gnome-open'

# apache root
alias w='cd /var/www/'
# dotfiles
alias df='cd ~/dotfiles'

# git
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gp='git push origin master'
alias gc='git commit -m'

# youtube-dl, download 480p flv format 
alias yd='youtube-dl -f35'
