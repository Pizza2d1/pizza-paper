# pizza-paper version 1.2.2
A wallpaper switching bash script that I made to try and learn some bash (because I think Ill use it in future careers) and because I wanted it to be customizable to me, I use linux btw

# How to use
All functionality can be done with pizza-paper.sh and does not require any additional packages to be downloaded (I don't think)
If you are in a weird version of linux (looking at you Ethan) you may need to install something from this list: [zenity, gsettings]
Right now it only works for gnome versions of linux, to find out if yours is gnome, run "echo $XDG_CURRENT_DESKTOP" in terminal

# Make sure you are not running it as root (sudo)
Unless you want to use path-adder.sh, which is completely optional for small QOL changes

# Will add these necessary directories and files needed to run
(These will NOT delete your current directory files, if you already have these directories, don't worry)

DIRECTORY /home/USERNAME/Pictures--------------------------------#Storing pizza-papers

DIRECTORY /home/USERNAME/Pictures/pizza-papers-------------#Storing custom and sample wallpaper image files

FILE /home/$USERNAME/Pictures/pizza-papers/settings.log----#Stores settings for when you close the terminal

DIRECTORY /home/USERNAME/Documents----------------------------#Storing pizza-papers.txt

FILE /home/USERNAME/Documents/pizza-papers.txt--------------#Storing custom wallpaper paths and names
