# pizza-paper 1.2.7
A GNOME wallpaper switching bash script that I made to try and learn some bash (because I think Ill use it in future careers) and because I wanted to make a quick wallpaper switcher that I can use in both cli and gui, I use linux btw


Most likely the last version that I work on unless I care enough

# How to use
### Prerequisites
You must be on a _GNOME_ version of linux, as this uses the gsettings command

List of some GNOME pre-installed distros:
- Ubuntu
- Linux Mint
- Fedora
- Debian

### Download
Either download the zip file and extract it, or you can clone it with:
```
git clone https://github.com/Pizza2d1/pizza-paper.git
```
Then, all you have to do is run the `pizza-paper.sh` program:
```
./pizza-paper.sh
```

### Usage
All functionality can be done with pizza-paper.sh and does not require any additional packages to be downloaded (if you are on main linux distros)
# Image Here
___
### Error Cases
1. __Make sure you are not running it as root (sudo)__
    - Unless you want to use path-adder.sh, which is completely optional for small QOL changes
2. __If you are in a non-ubuntu version of linux you may need to install packages from this list: [feh, zenity, gsettings]__
3. __Right now it only works for gnome versions of linux, to find out if yours is gnome, run "echo $XDG_CURRENT_DESKTOP" in terminal__
4. __If your download still doesn't work, try older releases and please tell me by writing an issue on what went wrong__
## Will add these necessary directories and files needed to run
(These will NOT delete your current directory folders or files, it will only create them if they are not there, don't worry)


- DIRECTORY `/home/USERNAME/Pictures`
    - Storing pizza-papers directory
- DIRECTORY `/home/USERNAME/Pictures/pizza-papers`
    - Storing wallpaper image files and log file
- FILE      `/home/USERNAME/Pictures/pizza-papers/settings.log`
    - Storing settings for when you close the terminal
- DIRECTORY `/home/USERNAME/Documents`
    - Storing pizza-papers.txt for record of wallpaper names and paths
- FILE      `/home/USERNAME/Documents/pizza-papers.txt`
    - Storing custom wallpaper paths and names