#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#Im adding git to this to hopefully try to learn a bit more about it, so if this commit has more line than the master one then it worked

#Current plans: Adding a way to select custom wallpapers with just one command rather then having to go through a function such as [...] --select 1

VERSION=$"pizzapaper 1.1.0"			#Tells the user the version
user=$(whoami)					#Gets the username of the person calling the program so that it only affects that user's desktop

if test -f /usr/local/bin/pizzapaper; then	#Sets variable to describe how the user should execute the program
  ProgName="pizzapaper"
elif test -f ./pizza-paper.sh; then
  ProgName="./pizza-paper.sh"
else
  echo "Bro you don't got files, download that shit again bozo"
fi

WallpaperList=()				#Needed so that that user can have custom wallpapers
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done


function Help_Options (){		#Gives the user instructions on how to use the program
  echo -e "This is my first attempt at making a help thing so Im going to try to make it as helpful for you as it can be to me\n"
  echo -e "$ProgName is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "To use this command you must do:\n$ProgName [ARG]"
  echo -e "E.G. \"$ProgName -a\", \"$ProgName -cat\", or \"$ProgName --add\"\n\n"
  echo -e "  --version  		Echos the current $ProgName version\n"
  echo -e "  --help     		Will display this, a much more detailed explanation on how to use this program and its arguments\n"
  echo -e "   -h        		Gives the user a simple idea of what options to choose\n"
  echo -e "   -a        		Makes your wallpaper astolfo\n"
  echo -e "   -A        		Makes your wallpaper astolfo, again, BUT IN 3D!\n"
  echo -e "   -c | -cat 		Makes your wallpaper a bunger cat\n"
  echo -e "   -d | -dog 		Makes your wallpaper the springfield meme, I know its dumb...\n"
  echo -e "  --add      		Lets you add wallpapers to a text file that you can select from (in the future)\n"
  echo -e "  --select   		Lets you select what wallpaper you want to use our of your custom wallpapers that you have added\n\n"
}

function Less_Help (){			#Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-a|A|c/cat|d/dog | --help|add|select|version]\"\n (The --help option may be more helpful)\n"
  echo -e "This program DOES NOT automatically work as \"pizzapaper [ARG]\" you will need to run it as \"./pizza-paper.sh [ARG]\"\n"
  echo -e "If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
  echo -e "To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
  echo -e "After you run it, you can delete pizza-paper.sh :3\n"
}

#Kinda useless rn
function UserInput (){
  name=$(zenity --entry --title="Please enter your name" --text="Enter your name:")	#Takes the name of the person using an "entry" input box
  if [ $? -eq 0 ]
  then
    zenity --info --text="Hello $name"
  fi
}

function AddWallpaper (){
  fileL=$(zenity --file-selection --file-filter="*.jpg")				#Opens file selection but only allows *.jpg options to be used
  if [[ $fileL == *".jpg"* ]]; then							#Makes sure that the user's file choice was a .jpg image
    if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					#Checks to make sure that PART of $fileL is nowhere in the WallpaperList array 
      feh $fileL
      echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
    else
      echo "That wallpaper is already in your list of wallpapers"
    fi
  else
    echo "You did not make a selection"
  fi
}

function SelectWallpaper (){								#The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
  INFILE=/home/$user/Documents/pizzapapers.txt
#  echo "  0   Remove Wallpaper"							#A new option that will be made useful in ver 1.0.4 to remove custom wallpapers from the list
  Num=1
  SelectionArray=()
  for LINE in $(cat "$INFILE"); do
    Picture="$(basename $LINE)"
    echo "  $Num   $Picture"								#Displays the wallpaper FILE name and its number selection choice
    ((Num+=1))
    SelectionArray+=($LINE)
  done
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal  
  re='^[0-9]+$'
  if [[ $uinput =~ $re ]]; then								#Checks to see that the user's input is a number
    echo "${SelectionArray[ (($uinput-1)) ]} is now your new wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark ${SelectionArray[ (($uinput-1)) ]}
  else
    echo "Invalid input"
  fi
}

#I hate this function, its stupid and bad so it's not included
function RotateWallpaper (){
  INFILE=/home/$user/Documents/pizzapapers.txt
  for LINE in $(cat "$INFILE"); do
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
function Astolfo_Wallpaper (){		#Sets the wallpaper to that one pink faggot
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/wallpapers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/wallpapers/astolfo.jpg
  echo Pink bitch has been deployed
}
function Astolfo2_Wallpaper (){		#Sets the wallpaper to the homo-bro-mo
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/wallpapers/astolfo2.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/wallpapers/astolfo2.jpg
  echo The fag has hit the second tower
}
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

 
options=$(getopt -o aAcdhr,cat,dog --long "add,select,help,version,remove,color" -- "$@")
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
         Less_Help
         exit;;
      -c | -cat)			#Will activate when pizzapaper -c or -cat is used
         Bunger_Wallpaper
         exit;;
      -d | -dog)			#Will activate when pizzapaper -d or -dog is used
         Springfield_Wallpaper
         exit;;
      -r)				#Stupid fucking function, DONT USE THIS, it ruined my life and gave me AIDS
         RotateWallpaper
         exit;;
      \?)				#Doesn't fucking work for some reason, its supposed to detect gibberish like "-klaneofbaog"
         echo "Invalid option"
         exit;;
    --add)				#Has the user select a .jpg file to add to a text file which lists all custom wallpapers
        shift;
        AddWallpaper
        exit;;
    --select)				#Lets the user select one of their custom wallpapers in a numbered list along with displaying the choice's names
        shift;
        if [[ $2 == *"--"* ]]; then
          echo "--select cannot support extra arguments yet"
        else
          SelectWallpaper
        fi
        exit;;
    --remove)
        shift;
        echo "NOT IMPLEMENTED YET"
        exit;;
    --help)				#Will activate when pizzapaper --help is used, the BETTER option for getting info
        shift;	#I don't know why shift is used tbh, but I'm afraid it will break if I remove it
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

#Feelin cute, might delete later
###gsettings set org.gnome.desktop.background picture-uri-dark $new_wallpaper	#Sets the wallpaper that was listed in past wallpaper file
###echo $save_wallpaper > /home/$user/Documents/previous_wallpapers.txt		#Saves the path of the previous wallpaper to the past wallpaper file
Less_Help	Will run when the user does not provide an argument
