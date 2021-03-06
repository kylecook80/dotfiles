#export LANG=en_US.UTF-8
#ulimit -c unlimited

xdg-user-dirs-update

xset -b
xset s on
xset +dpms

xrandr --output DP-2 --mode 2560x1440 --primary --rotate normal
xrandr --output DP-0 --mode 2560x1440 --left-of DP-2 --rotate left
xrandr --output DP-0 --pos 0x-600
xrandr --output DP-4 --mode 2560x1440 --right-of DP-2 --rotate normal

numlockx
#xautolock -time 5 -locker i3lock
setxkbmap -option terminate:ctrl_alt_bksp
xrdb -merge ~/.Xresources

eval `ssh-agent` && ssh-add

sh ~/.fehbg
xmodmap ~/.xmodmaprc
xinput --set-prop 12 'libinput Accel Speed' -0.3

#exec /usr/local/bin/i3 -V >> ~/.i3/logfile
#exec /usr/bin/i3 -V >> ~/.i3/logfile
exec /usr/sbin/i3 -V >> ~/.i3/logfile
