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

alias d='cd ~/Downloads'

# nautilus 
alias fm='nautilus --no-desktop &'

# trayer
# function tr(){
#   nm-applet &
#   trayer &
# }
alias kt='killall trayer && killall nm-applet'

# dual monitor
alias dual="xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP2 --off --output DP1 --off --output VGA1 --mode 1440x900 --pos 1366x0 --rotate normal"
#single monitor
alias single="xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP2 --off --output DP1 --off --output VGA1 --off"

#php-tag-generator
alias phptags='~/php-tag-generator/tags.sh'

# gnone-open
alias go='gnome-open'

# apache root
alias w='cd /var/www/'
# dotfiles
alias df='cd ~/dotfiles'
alias ocned='cd /var/www/po-system/public_html/'
alias dr='cd /var/www/html/dronten/'
alias is='cd /var/www/html/leanstock/'
alias bio='cd /var/www/html/affiliateBO/'
alias ke='cd /var/www/html/keg/'
alias me='cd /var/www/html/measter/'

# git
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gp='git push origin master'
alias gc='git commit -m'

# youtube-dl, download 480p flv format 
alias yd='youtube-dl -t -f35'

# chrome work profile
alias cw='google-chrome --user-data-dir=/home/$(whoami)/Dropbox/Google-chrome-work-profile &'

# lock from commandline
alias lock='gnome-screensaver-command -l'

# path to vim bundle
alias vb='cd ~/.vim/bundle/'

# tail php errors
alias tphp='tail -f /var/log/apache2/error.log'

# tail mysql queries
alias tmysql='tail -f /var/log/mysql/mysql.log'

function rdb(){
  echo "Resetting database: $1 ..."
  mysql -uroot -ppassword -e "drop database $1; create database $1;"
  echo "Complete."
}

if [ -f ~/Dropbox/.bash_aliases ]; then
    . ~/Dropbox/.bash_aliases
fi
