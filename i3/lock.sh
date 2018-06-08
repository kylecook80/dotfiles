#!/usr/bin/env sh
#The first image is the screenshot, the second gets resized to a pixel
image_file=/tmp/screen_lock.png
image_file_2=/tmp/screen_lock_1.png

#Get the resolution of your desktop
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')

#Note: To adjust the resoltion, change the two scale values
#The script works by scaling the image down and back up
#So  make sure your scale values invert: i.e. 1/25 = 0.04
filters='noise=alls=10,scale=iw*.04:-1,scale=iw*25:-1:flags=neighbor'

scrot -m /tmp/screen_lock.png

#Get the screenshot and blur it
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
  -vf "$filters" "$image_file"

#Make it so we can actually use the image
chmod 777 $image_file

#Remove any old image2's
rm $image_file_2

#Make the second one a pixel - scale it down to 1x1 image
ffmpeg -i $image_file -vf scale=1:1 $image_file_2

#Get the inverted color
color="$(convert -negate /tmp/screen_lock_1.png txt:- | grep -oP '(?<=#)(\w{6}\W)' | sed '/^$/d')"
echo Color: $color

#And boom!
$HOME/.i3/i3_clock -e -i "$image_file" -l $color
