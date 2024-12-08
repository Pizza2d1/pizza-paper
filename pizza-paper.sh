#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#To get instructions on how to run this you can just execute it or look on github for "How to use"

VERSION=$"pizzapaper 1.1.5"				#Tells the user the version
user=$(whoami)							      #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						      #Needed so that that user can have custom wallpapers
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done
#I like these ones better ^^^^^ so they get to be at the top

#Necessary checks needed for redundancy and being more user-friendly
if [ -d "/home/pizza2d1" ]; then				            #I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
  IAMGOD=true
else
  IAMGOD=false
fi
if test -f /usr/local/bin/pizzapaper; then			    #ProgName will be used to swap between "pizza-paper.sh" and "pizzapaper" depending on what the user has installed for convenience
  ProgName="pizzapaper"                             
elif test -f ./pizza-paper.sh; then
  ProgName="./pizza-paper.sh"
fi
if test -f /home/$user/Pictures/pizza-papers/TRAINS.jpg; then                               #Checks to see if the user decided to download the included wallpapers (pizzapaper --feature)
  SampleWallpaperStatus=""                                                                  #Will NOT say something if the user has sample images
  YesYouHaveIt="(You already have the sample images)"                                       #Will tell the user if they have the sample images if it detects them
  WallpaperAccess=true                                                                      #Will allow the user to access the sample images now that they're downloaded
else
  SampleWallpaperStatus=" (Must use --feature argument to install sample wallpapers)"       #The double spacing is needed to make sure that the variable doesn't touch the text in the help command
  YesYouHaveIt=""                                                                           #No they don't have it
  WallpaperAccess=false                                                                     #Will prevent the user from triggering the sample wallpaper functions because they haven't been downloaded
fi
###########################################


#Adds the neccessary directories and files in case the user doesn't have them
if [ ! -d "/home/$user/Documents" ]; then			            #Makes a Documents directory in case you are a weird little idiot that feels like they're better than everyone else, along with making a text file for listing custom wallpapers
  echo "wtf why don't you have a Documents folder, making one now to store a list of your wallpapers..."
  mkdir /home/$user/Documents
fi
if ! test -f /home/$user/Documents/pizzapapers.txt; then  #Will make a pizzapapers text file to list all the custom wallpapers (in path/to/image style) that the user adds
  touch /home/$user/Documents/pizzapapers.txt
fi
if [ ! -d "/home/$user/Pictures" ]; then                  #Makes a Pictures directory in case you are a little weird idiot that feels like they're better than everyone else, along with making a directory for custom wallpapers
  echo "wtf why don't you have a Pictures folder, making one now to store your custom wallpapers..."
  mkdir /home/$user/Pictures
fi
if [ ! -d "/home/$user/Pictures/pizza-papers" ]; then     #Will make a pizzapapers directory that will store you custom wallpapers
  mkdir /home/$user/Pictures/pizza-papers
fi
###########################################


#Main functions
function Help_Options (){		                  #Gives the user instructions on how to use the program
  echo -e "This is my first attempt at making a help thing so Im going to try to make it as helpful for you as it can be to me\n"
  echo -e "$ProgName is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "To use this command you must do:\n  $ProgName [ARG]"
  echo -e "  E.G. \"$ProgName -h\", \"$ProgName --feature\", or \"$ProgName --add\"\n\n"
  echo -e "   -h                 Gives the user a simple idea of what options to choose\n"
  echo -e "   -m | -mountain     Switches wallpaper to a mountainside           $SampleWallpaperStatus\n"
  echo -e "   -a | -astolfo      Switches wallpaper to Astolfo                  $SampleWallpaperStatus\n"
  echo -e "   -s | -sunglasses   Switches wallpaper to sunglasses on a beach    $SampleWallpaperStatus\n"
  echo -e "   -t | -train        Switches wallpaper to a picture of a train     $SampleWallpaperStatus\n"
  echo -e "  --feature           Will download sample images (Recommended if you are wanting to see how well this thing works)\n"
  echo -e "  --add               Lets you add custom wallpapers to a text file that you can select from (in the future)\n"
  echo -e "  --select            Lets you select what wallpaper you want to use out of your custom wallpapers that you have added, USAGE: --select | --select [wallpaper number]\n"
  echo -e "  --version           Echos the current $ProgName version\n"
  echo -e "  --help              Will display this, a much more detailed explanation on how to use this program and its arguments\n\n"
}

function Less_Help (){			                  #Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  if $WallpaperAccess; then                   #Checks to see that the user has downloaded the sample images
    echo -e "\nPick which argument you want to use with \"$ProgName [-h|m|a|s|t | --help|add|select|feature|version]\"\n (The --help option may be more helpful)\n"
  else
    echo -e "\nPick which argument you want to use with \"$ProgName [-h | --help|add|select|feature|version]\"\n (The --help option may be more helpful)\n"
  fi
  if [[ ! $ProgName == *"pizzapaper"* ]]; then
    echo -e "This program DOES NOT automatically work as \"pizzapaper [ARG]\" you will need to run it as \"./pizza-paper.sh [ARG]\"\n"
    echo -e "If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
    echo -e "To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
    echo -e "After you run it, you can delete pizza-paper.sh :3\n"
  fi
}

function AddWallpaper (){                     #Will let the user add a wallpaper from their computer files
  fileL=$(zenity --file-selection)				                                                          #Opens file selection to choose a image file
  echo $fileL
  if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]]; then						        #Makes sure that the user's file choice was a image file (jpg, jpeg, or png)
    if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
      #feh $fileL -E 128 -y 128								                                                      #Show the new wallpaper in a -E (height) 128 px and -y (width) 128 px (yes they made -y be width)
      echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
    else
      echo "That wallpaper is already in your list of wallpapers"
    fi
  else
    echo "You did not make a selection or chose a invalid file type"
  fi
}

function SelectWallpaper (){								  #The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
  if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
    echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add\n"
    exit;
  fi
  echo "  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list #########################
  Num=1
  for LINE in ${WallpaperList[@]}; do           #A loop that encompasses ALL items in the WallpaperList array
    ImageName="$(basename $LINE)"               #Takes the substring value of the image by removing the parent directories from the string
    echo "  $Num   $ImageName"								  #Displays the wallpaper FILE name and its number selection choice
    ((Num+=1))
  done
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal #REFERENCE#
  re='^[0-9]+$'
  if [[ $uinput == "0" ]]; then                 #Will check that the user wanted to delete a wallpaper
    echo "  0   Exit"
    Num=1
    for LINE in ${WallpaperList[@]}; do
      ImageName="$(basename $LINE)"
      echo "  $Num   $ImageName"
      ((Num+=1))
    done
    read -p "Which wallpaper would you like to remove?: " uinput  #Takes user input
    if [[ $uinput == "0" || $uinput == "" ]]; then
      echo "No wallpaper was deleted, exiting"
    elif [[ $uinput =~ $re ]]; then           #Checks to see that the user's input is a number (except 0) to remove a custom wallpaper
      echo -e "\nRemoved ${WallpaperList[ (($uinput-1)) ]} from your list of wallpapers\n(note that this does not delete the actual image file in your system)\n"
      unset -v WallpaperList[$uinput-1]                         #Gets rid of the wallpaper the user chose
      rm /home/$user/Documents/pizzapapers.txt                  #Resets the wallpaper list
      for LINE in ${WallpaperList[@]}; do
        echo $LINE >> /home/$user/Documents/pizzapapers.txt     #Creates and writes the new array to the new pizzapapers.txt
      done
    fi
    exit;
  fi
  if [[ $uinput =~ $re ]]; then								#Checks to see that the user's input is a number
    echo "${WallpaperList[ (( $uinput-1 )) ]} is now your new wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($uinput-1)) ]}
  else
    echo "Invalid input"
  fi
}
###########################################


#For setting the wallpapers, the user might either have "picture-uri-dark" or "picture-uri" being displayed, so its best to just set both of them.-
#-Think of them like layers, where on one system picture-uri is on top of picture-uri-dark and vice versa, we just change both so we dont deal with it
function Mountain_Wallpaper (){		  #Sets the wallpaper to a cool mountainside
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/mountains.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/mountains.jpg
}
function Astolfo_Wallpaper (){		  #Sets the wallpaper to astolfo because I have a feeling my friends will open it
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/astolfo.jpg
}
function Sunglasses_Wallpaper (){		#Sets the wallpaper to a beach photo with some sunglasses
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
}
function Trains_Wallpaper (){	      #Sets the wallpaper to the inside of a autist's mind
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
}
###########################################


#Lists the different options that the user can choose from, "aAcdhr" is for individual letters btw
options=$(getopt -o hmast,mountain,astolfo,sunglasses,train --long "add,select,feature,help,version" -- "$@")
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
      -h)				            #Will activate when pizzapaper -h is used)
         Less_Help
         exit;;
      -m | -mountain)       #Will make the desktop background a mountainside)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Mountain_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -a | -astolfo)       #Will make the desktop background astolfo)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Astolfo_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -s | -sunglasses)       #Will make the desktop background some sunglasses)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Sunglasses_Wallpaper
         else
           echo -e "You must run \"$ProgName --feature\" to download these files"
         fi
         exit;;
      -t | -train)       #Will make the desktop background a picture of a train)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
           Trains_Wallpaper
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
        if [[ $2 == *"https"* ]] && [[ $2 == *".jpg"* || $2 == *".jpeg"* || $2 == *".png"* ]]; then   #Will only accept files that are https AND image links
          if [[  ${WallpaperList[@]} != *"$2"* ]]; then					                                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
            feh $2 -E 128 -y 128								                                                      #Show the new wallpaper in a -E (height) 128 px and -y (width) 128 px (yes they made -y be width)
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O "$2" ; cd -; }                      #Downloads the URL image to the pizza-papers directory
            echo "$2" >> /home/$user/Documents/pizzapapers.txt
          else
            echo "That wallpaper is already in your list of wallpapers"
          fi
        elif [[ $2 != "" ]]; then
          echo -e "\nMake sure your URL is valid:\n  Usage:  $ProgName --add https-------------.image_extention   (specifically: *.png, *.jpg, and *.jpeg)\n"
        else
          AddWallpaper
        fi
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
        #Requests images from different website links (they are extracted in incoherant names)
          urls="https://i.etsystatic.com/43678560/r/il/e318c5/5095674952/il_1140xN.5095674952_4itq.jpg https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D https://scontent-sjc3-1.xx.fbcdn.net/v/t1.6435-9/50703090_1022241357960569_4488694694989004800_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=2285d6&_nc_ohc=FQmA5AvhfWgQ7kNvgGAGI9B&_nc_zt=23&_nc_ht=scontent-sjc3-1.xx&_nc_gid=AoJ6F11aMxPxT55pFB6pABH&oh=00_AYDhLj9seoSCsewoSTppZUn0C7pljtw-GxJV_a4xbSdl5A&oe=677C98AC https://images.wallpaperscraft.com/image/single/train_railway_forest_169685_1920x1080.jpg"
          for links in $urls; do
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $links ; cd -; }
          done
          #This part will make them readable (and in the case of sunglasses, usable), they are in order of links above
          mv /home/$user/Pictures/pizza-papers/il_1140xN.5095674952_4itq.jpg /home/$user/Pictures/pizza-papers/mountains.jpg
          mv /home/$user/Pictures/pizza-papers/50703090_1022241357960569_4488694694989004800_n.jpg /home/$user/Pictures/pizza-papers/astolfo.jpg
          mv /home/$user/Pictures/pizza-papers/photo-1473496169904-658ba7c44d8a /home/$user/Pictures/pizza-papers/sunglasses.jpeg #There was no image extension so I had to add it to make it work
          mv /home/$user/Pictures/pizza-papers/train_railway_forest_169685_1920x1080.jpg /home/$user/Pictures/pizza-papers/TRAINS.jpg
        else
          echo "Exiting"
        fi
        exit;;
    --help)				          #Will activate when pizzapaper --help is used, the BETTER option for getting info)
        shift;	            #I don't know why shift is used tbh, but I'm afraid it will break if I remove it
        Help_Options
        exit;;
    --version)
        shift;
        echo $VERSION
        exit;;
    --)					            #No idea whatsoever, I don't want to remove it though)
        shift
        break
        ;;
    esac
    shift
done

Less_Help   #Will run when the user does not provide an argument to give them options
