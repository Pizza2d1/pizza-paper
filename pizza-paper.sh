
#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#Im adding git to this to hopefully try to learn a bit more about it, so if this commit has more line than the master one then it worked

VERSION=$"pizzapaper 1.0.2"
user=$(whoami)									#Gets the username of the person calling the program so that it only affects that user's desktop
save_wallpaper=$(gsettings get org.gnome.desktop.background picture-uri-dark)	#Will prepare to put the previous wallpaper's file location (before running the program) in a text file
new_wallpaper=$(cat /home/$user/Documents/previous_wallpapers.txt)		#Will pull the data from the wallpaper text file so that it can become the new wallpaper in rotation
#WallpaperList=$

#INFILE=/home/$user/Documents/pizzapapers.txt
#  for LINE in $(cat "$INFILE")
#for t in ${WallpaperList[@]}; do

#done

function Help_Options (){		#Gives the user instructions on how to use the program
  echo "This is my first attempt at making a help thing so Im going to try to make it as helpful for you as it can be to me"
  echo -e "\npizzapaper is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "\nTo use this command you must do:\npizzapaper [ARG]"
  echo -e "E.G. "pizzapaper -a" or "pizzapaper -c"\n\n"
  echo -e "   -h			Gives the user a simple idea of what options to choose\n"
  echo -e "  --help		Will display this, a much more detailed explanation on how to use this program and its arguments\n"
  echo -e "   -a			Makes your wallpaper astolfo\n"
  echo -e "   -A			Makes your wallpaper astolfo, again, BUT IN 3D!\n"
  echo -e "   -c | -cat		Makes your wallpaper a bunger cat\n"
  echo -e "   -d | -dog		Makes your wallpaper the springfield meme, I know its dumb...\n"
  echo -e "  --add			Lets you add wallpapers to a text file that you can select from (in the future)\n\n"
}


function UserInput (){
  name=$(zenity --entry --title="Please enter your name" --text="Enter your name:")	#Takes the name of the person using an "entry" input box
  if [ $? -eq 0 ]
  then
    zenity --info --text="Hello $name"
  fi
}

function AddWallpaper (){
  fileL=$(zenity --file-selection --file-filter="*.jpg")				#Opens file selection but only allows *.jpg options to be used
  
  if [[ $fileL == *".jpg"* ]]; then
    if [[  $WallpaperList != $fileL ]]; then
      eog $fileL
      echo "'file://$fileL'" >> /home/$user/Documents/pizzapapers.txt
    else
      echo "That wallpaper is already in your list of wallpapers"
    fi
  else
    echo "You did not make a selection"
  fi
}

function RotateWallpaper (){
  INFILE=/home/$user/Documents/pizzapapers.txt
  for LINE in $(cat "$INFILE")
  do
    echo -e "LINE $LINE"
    echo -e "SAVE_WALL $save_wallpaper"
    if [[ $LINE == *"$save_wallpaper"* ]]; then
      echo -e "OH MY FUCKING GOD DIE DIE DIE"
    else
      PLINE=$LINE
    fi
  echo -e "LAST PLINE: $PLINE"
  done
}



#For setting the wallpapers, the user might either have "picture-uri-dark" or "picture-uri" being displayed, so its best to just set both of them.-
#-Think of them like layers, where on one system picture-uri is on top of picture-uri-dark and vice versa, we just change both so we dont deal with it
function Bunger_Wallpaper (){		#Sets the wallpaper to the bunger cat
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Downloads/bunger1.png
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Downloads/bunger1.png
  echo Cat was activated
}
function Springfield_Wallpaper (){	#Sets the wallpaper to the springfield meme
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Downloads/dogs.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Downloads/dogs.jpg
  echo Dog was activated
}
function Astolfo_Wallpaper (){		#Sets the wallpaper to the springfield meme
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/wallpapers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/wallpapers/astolfo.jpg
  echo Pink bitch has been deployed
}
function Astolfo2_Wallpaper (){		#Sets the wallpaper to that one pink faggot
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/wallpapers/astolfo2.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/wallpapers/astolfo2.jpg
  echo The fag has hit the second tower
}

#OLD CODE THAT I REFERENCE OFF OF
#while getopts ":aAcdh" option; do
#   case $option in
#      a)
#         Astolfo_Wallpaper
#         exit;;
#      A)
#         Astolfo2_Wallpaper
#         exit;;
#      h)
#         echo Pick either dog wallpaper or cat wallpaper with "pizzapaper -c/d"
#         exit;;
#      c) # display Help
#         Bunger_Wallpaper
#         exit;;
#      d)
#         Springfield_Wallpaper
#         exit;;
#      \?)
#         echo "Invalid option"
#         exit;;
#   esac
#done

 
options=$(getopt -o aAcdhr,cat,dog --long "add,help,version,color" -- "$@")
[ $? -eq 0 ] || { 
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
       a)				#Will activate if the user is dumb and only does "a" for an "argument"
         echo "Yeah, ah to you too"
         exit;;
      -a)				#Will activate when pizzapaper -a is used
         Astolfo_Wallpaper
         exit;;
      -A)				#Will activate when pizzapaper -A is used
         Astolfo2_Wallpaper
         exit;;
      -h)				#Will activate when pizzapaper -h is used
         echo -e "\nPick which argument you want to use with \"pizzapaper [-a | -A | -c/-cat | -d/-dog | --help]\"\n (The --help option may be more helpful)\n"
         exit;;
      -c | -cat)			#Will activate when pizzapaper -c or -cat is used
         Bunger_Wallpaper
         exit;;
      -d | -dog)			#Will activate when pizzapaper -d or -dog is used
         Springfield_Wallpaper
         exit;;
      -r)
         RotateWallpaper
         exit;;
      \?)				#Doesn't fucking work for some reason, its supposed to detect gibberish like "-klaneofbaog"
         echo "Invalid option"
         exit;;
    --add)
        shift;
        AddWallpaper
        exit;;
    --help)				#Will activate when pizzapaper --help is used, the BETTER option for getting info
        shift;
        Help_Options
        exit;;
    --version)
        shift;
        echo $VERSION
        exit;;
    --color)				#Part of the tutorial I was working on when adding --long arguments, its sentimental
        shift;
        echo from when I was testing the long argument options
        exit;;        
    --)					#No idea whatsoever, I don't want to remove it though
        shift
        break
        ;;
    esac
    shift
done

#Will run if there were INVALID ARGUMENTS or NO ARGUMENTS at all
#Add these two back once done testing
###gsettings set org.gnome.desktop.background picture-uri-dark $new_wallpaper	#Sets the wallpaper that was listed in past wallpaper file
###echo $save_wallpaper > /home/$user/Documents/previous_wallpapers.txt		#Saves the path of the previous wallpaper to the past wallpaper file
