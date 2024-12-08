#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#To get instructions on how to run this you can just execute it or look on github for "How to use"

VERSION=$"pizzapaper 1.1.5 unstable"				#Tells the user the version
user=$(whoami)							#Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						#Needed so that that user can have custom wallpapers
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done

if [ -d "/home/pizza2d1" ]; then				            #I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
  IAMGOD=true
else
  IAMGOD=false
fi

if test -f /usr/local/bin/pizzapaper; then			    #Sets variable to describe how the user should execute the program, the name of the program
  ProgName="pizzapaper"
elif test -f ./pizza-paper.sh; then
  ProgName="./pizza-paper.sh"
fi

#Adds the neccessary directories and files
if [ ! -d "/home/$user/Documents" ]; then			            #Makes a Documents directory in case you are a weird little idiot that feels like they're better than everyone else, along with making a text file for listing custom wallpapers
  echo "wtf why don't you have a Documents folder, making one now to store a list of your wallpapers..."
  mkdir /home/$user/Documents
fi
if ! test -f /home/$user/Documents/pizzapapers.txt; then  #Will make a pizzapapers text file to list all the custom wallpapers (in path/to/image style) that the user adds
  touch /home/$user/Documents/pizzapapers.txt
fi
if [ ! -d "/home/$user/Pictures" ]; then                   #Makes a Pictures directory in case you are a little weird idiot that feels like they're better than everyone else, along with making a directory for custom wallpapers
  echo "wtf why don't you have a Pictures folder, making one now to store your custom wallpapers..."
  mkdir /home/$user/Pictures
fi
if [ ! -d "/home/$user/Pictures/pizza-papers" ]; then      #Will make a pizzapapers directory that will store you custom wallpapers
  mkdir /home/$user/Pictures/pizza-papers
fi

if test -f /home/$user/Pictures/pizza-papers/Bunger%202.jpg; then  #Checks to see if the user decided to download the included wallpapers when using ./pizza-paper.sh --include ############################
  ProprietaryWallpaperStatus=""
  WallpaperAccess=true
else
  ProprietaryWallpaperStatus=" (Must use --feature argument to install sample wallpapers)"  #The double spacing is needed to make sure that the variable doesn't touch the text in the help command
  WallpaperAccess=false
fi

function Help_Options (){		#Gives the user instructions on how to use the program
  echo -e "This is my first attempt at making a help thing so Im going to try to make it as helpful for you as it can be to me\n"
  echo -e "$ProgName is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "To use this command you must do:\n  $ProgName [ARG]"
  echo -e "  E.G. \"$ProgName -h\", \"$ProgName --feature\", or \"$ProgName --add\"\n\n"
  echo -e "  --version           Echos the current $ProgName version\n"
  echo -e "  --help              Will display this, a much more detailed explanation on how to use this program and its arguments\n"
  echo -e "   -h                 Gives the user a simple idea of what options to choose\n"
  echo -e "   -m | mountain      Will make your wallpaper a mountainside$ProprietaryWallpaperStatus\n"
#  echo -e "   -null              SAMPLE2_WALLPAPER$ProprietaryWallpaperStatus\n"
#  echo -e "   -null              SAMPLE3_WALLPAPER$ProprietaryWallpaperStatus\n"
#  echo -e "   -null              SAMPLE4_WALLPAPER$ProprietaryWallpaperStatus\n"
  echo -e "  --add               Lets you add wallpapers to a text file that you can select from (in the future)\n"
  echo -e "  --select            Lets you select what wallpaper you want to use our of your custom wallpapers that you have added, USAGE: --select | --select [wallpaper number]\n"
  echo -e "  --feature           Will download sample images\n\n"
}

function Less_Help (){			#Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-h|m | --help|add|select|feature|version]\"\n (The --help option may be more helpful)\n"
  if [[ ! $ProgName == *"pizzapaper"* ]]; then
    echo -e "This program DOES NOT automatically work as \"pizzapaper [ARG]\" you will need to run it as \"./pizza-paper.sh [ARG]\"\n"
    echo -e "If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
    echo -e "To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
    echo -e "After you run it, you can delete pizza-paper.sh :3\n"
  fi
}


function AddWallpaper (){
  fileL=$(zenity --file-selection)				                                                          #Opens file selection to choose a image file
  echo $fileL
  if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]]; then						#Makes sure that the user's file choice was a image file (jpg, jpeg, or png)
    if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
      feh $fileL -E 128 -y 128								                                                      #Show the new wallpaper in a -E (height) 128 px and -y (width) 128 px (yes they made -y be width)
      echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
    else
      echo "That wallpaper is already in your list of wallpapers"
    fi
  else
    echo "You did not make a selection or chose a invalid file type"
  fi
}

function SelectWallpaper (){								#The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
  INFILE=/home/$user/Documents/pizzapapers.txt
#  echo "  0   Remove Wallpaper"							#A new option that will be made useful later to remove custom wallpapers from the list #########################
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
function Mountain_Wallpaper (){		#Sets the wallpaper to the bunger cat
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/il_1140xN.5095674952_4itq.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/il_1140xN.5095674952_4itq.jpg
  #gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/astolfo.jpg  
  echo Cat was activated
}
function Custom1_Wallpaper (){		#Sets the wallpaper to astolfo, it was funny when I first included it
  #gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/
  #gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/
  echo Pink bitch has been deployed
}
function Custom2_Wallpaper (){		#Sets the wallpaper to 3D astolfo
  #gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/
  #gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/
  echo The fag has hit the second tower
}
function Custom3_Wallpaper (){	#Sets the wallpaper to the dumb trump meme
  #gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/
  #gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/
  echo Dog was activated
}


#Lists the different options that the user can choose from, "aAcdhr" is for individual letters btw
options=$(getopt -o aAmdhr,mountain --long "add,select,help,version,feature,remove,color" -- "$@")
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
      -a)				            #Will activate when pizzapaper -a is used)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Custom1_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -A)				            #Will activate when pizzapaper -A is used)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Custom2_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -h)				            #Will activate when pizzapaper -h is used)
         Less_Help
         exit;;
      -d | -dog)		        #Will activate when pizzapaper -d or -dog is used)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Custom3_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -m | -mountain)       #Will make the desktop background a mountainside
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Mountain_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -r)				            #Stupid fucking function, DONT USE THIS, it ruined my life and gave me AIDS)
         RotateWallpaper
         exit;;
      \?)				            #Doesn't fucking work for some reason, its supposed to detect gibberish like "-klaneofbaog")
         echo "Invalid option"
         exit;;
    --add)				          #Has the user select a image file's name to add to a text file which lists all custom wallpapers)
        shift;
        if [[ $2 == *"https"* ]]; then
          cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $2 ; cd -; }
        fi
        AddWallpaper
        exit;;
    --select)				        #Lets the user select one of their custom wallpapers in a numbered list along with displaying the choice's names)
        shift;
        re='^[0-9]+$'
        if [[ $2 =~ $re ]]; then	#Checks to see that the users second argument is a number (if there even IS and argument)
          INFILE=/home/$user/Documents/pizzapapers.txt
          SelectionArray=()
          for LINE in $(cat "$INFILE"); do
            Picture="$(basename $LINE)"
            SelectionArray+=($LINE)
          done
          echo "${SelectionArray[ (($2-1)) ]} is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${SelectionArray[ (($2-1)) ]}
        else
          SelectWallpaper
        fi
        exit;;
    --feature)              #Downloads 4 example image files for the user to be able to use)
        shift;
        echo -e ""
        read -p "This will add 4 image files to your /Pictures/pizza-papers directory, do you still want to continue? [y/N]: " uinput
        if [[ $uinput == *"y"* ]]; then
          urls="https://i.etsystatic.com/43678560/r/il/e318c5/5095674952/il_1140xN.5095674952_4itq.jpg" #################################ADD MORE
          for links in $urls; do
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $links ; cd -; }
          done
        else
          echo "Exiting"
        fi
        exit;;
    --remove)               #Lets the user remove a custom wallpaper from the list, might just add to be an option only in --select ########################)
        shift;
        echo "NOT IMPLEMENTED YET"
        exit;;
    --help)				          #Will activate when pizzapaper --help is used, the BETTER option for getting info)
        shift;	            #I don't know why shift is used tbh, but I'm afraid it will break if I remove it
        Help_Options
        exit;;
    --version)
        shift;
        echo $VERSION
        exit;;
    --color)				        #Part of the tutorial I was working on when adding --long arguments, its sentimental)
        shift;
        echo from when I was testing the long argument options
        exit;;
    --)					            #No idea whatsoever, I don't want to remove it though)
        shift
        break
        ;;
    esac
    shift
done

Less_Help   #Will run when the user does not provide an argument to give them options
