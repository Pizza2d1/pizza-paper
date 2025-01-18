#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#To get instructions on how to run this you can just execute it or look on github for "How to use"

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
VERSION=$"pizzapaper 1.2.7"	                #Tells the user the current version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers               
AMOUNT_OF_SETTINGS=5                        #Will be used to know how many lines to look for in settings (while loops amiright?)
ROTATION_SPEED=3 #Seconds                 #Will determine how fast wallpapers will rotate with the rotatewallaper function
=======
VERSION=$"pizzapaper 1.2.6"	                #Tells the user the current version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers               
AMOUNT_OF_SETTINGS=5                        #Will be used to know how many lines to look for in settings (while loops amiright?)
ROTATION_SPEED=2 #Seconds                 #Will determine how fast wallpapers will rotate with the rotatewallaper function
>>>>>>> 61b68b7 (Added wallpaper rotation)
#I like these variables better ^^^^^ so they get to be at the top

<<<<<<< HEAD
<<<<<<< HEAD
#Necessary checks needed for redundancy and being more user-friendly
if [ -d /home/pizza2d1 ]; then				                                                #I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
<<<<<<< HEAD
  IAMGOD=true
=======
VERSION=$"pizzapaper 1.1.0"			#Tells the user the version
user=$(whoami)					#Gets the username of the person calling the program so that it only affects that user's desktop
=======
VERSION=$"pizzapaper 1.1.2"					#Tells the user the version
=======

VERSION=$"pizzapaper 1.1.4"					#Tells the user the version
>>>>>>> 4657cf0 (Removed clutter and fixed user options)
user=$(whoami)							#Gets the username of the person calling the program so that it only affects that user's desktop
>>>>>>> 9e21837 (Updated to help with redundancy)

if [ -d "/home/pizza2d1" ]; then				#I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
=======
>>>>>>> 61b68b7 (Added wallpaper rotation)
  IAMGOD=true
else
  IAMGOD=false
fi

if [ ! -d "/home/$user/Documents" ]; then			#Makes a Documents directory in case you are a weird little idiot that feels like they're better than everyone else
  echo "wtf why don't you have a Documents folder, making one now to store a list of your wallpapers..."
  mkdir /home/$user/Documents
fi

if ! test -f /home/$user/Documents/pizzapapers.txt; then	#Will make a pizzapapers text file to list all the custom wallpapers (in path/to/image style) that the user adds
  touch /home/$user/Documents/pizzapapers.txt
fi

if test -f /usr/local/bin/pizzapaper; then			#Sets variable to describe how the user should execute the program, the name of the program
  ProgName="pizzapaper"
elif test -f ./pizza-paper.sh; then
  ProgName="./pizza-paper.sh"
>>>>>>> 5b06502 (Updated file)
else
<<<<<<< HEAD
  IAMGOD=false
fi
if [ -f /usr/custom_paths/pizzapaper ]; then			                                        #ProgName will be used to swap between "pizza-paper.sh" and "pizzapaper" depending on what the user has installed for convenience
  ProgName="pizzapaper"                             
elif [ -f ./pizza-paper.sh ]; then
  ProgName="./pizza-paper.sh"
fi
#Checks to see if the user decided to download all the included wallpapers (pizzapaper --sample)
if [ -f /home/$user/Pictures/pizza-papers/mountains.jpg ] && [ -f /home/$user/Pictures/pizza-papers/astolfo.jpg ] && [ -f /home/$user/Pictures/pizza-papers/sunglasses.jpeg ] && [ -f /home/$user/Pictures/pizza-papers/TRAINS.jpg ]; then
  ShortHelpFlag="|m|a|s|t"                                                            #Will display sample wallpaper options if the user has them downloaded
  SampleWallpaperStatus=""                                                            #Will NOT say something if the user has sample images
  YesYouHaveIt="(If you would like to delete them, use \"$ProgName --sample remove\")"          #Will tell the user if they have the sample images if it detects them
  WallpaperAccess=true                                                                #Will allow the user to access the sample images now that they're downloaded
else
  ShortHelpFlag=""                                                                    #Will display sample wallpaper options if the user has them downloaded (they dont)
  SampleWallpaperStatus=" (Must use --sample argument to install sample wallpapers)"  #The double spacing is needed to make sure that the variable doesn't touch the text in the help command
  YesYouHaveIt="(I recommend that you do)"                                            #No they don't have it
  WallpaperAccess=false                                                               #Will prevent the user from triggering the sample wallpaper functions because they haven't been downloaded
fi
###########################################


#Adds the neccessary directories and files in case the user doesn't have them
if [ ! -d "/home/$user/Documents" ]; then			                        #Makes a Documents directory in case you are a weird little idiot that feels like they're better than everyone else, along with making a text file for listing custom wallpapers
  echo "wtf why don't you have a Documents folder, making one now to store a list of your wallpapers..."
  mkdir /home/$user/Documents
fi
if [ ! -f "/home/$user/Documents/pizzapapers.txt" ]; then             #Will make a pizzapapers text file to list all the custom wallpapers (in path/to/image style) that the user adds
  touch /home/$user/Documents/pizzapapers.txt
fi
while read -r LINE; do
  WallpaperList+=("$LINE")
done  < "/home/$user/Documents/pizzapapers.txt"

if [ ! -d "/home/$user/Pictures" ]; then                              #Makes a Pictures directory in case you are a little weird idiot that feels like they're better than everyone else, along with making a directory for custom wallpapers
  echo "wtf why don't you have a Pictures folder, making one now to store your custom wallpapers..."
  mkdir /home/$user/Pictures
fi
if [ ! -d "/home/$user/Pictures/pizza-papers" ]; then                 #Will make a pizzapapers directory that will store you custom wallpapers
  mkdir /home/$user/Pictures/pizza-papers
fi
if [ ! -f "/home/$user/Pictures/pizza-papers/settings.log" ]; then    #Creates a settings.log file if the user does not have it to store settings such as "show cli" or "open with selector"
  OriginalWallpaper=$(gsettings get org.gnome.desktop.background picture-uri)
  if [[ $OriginalWallpaper == *"file://"* ]]; then
    OWallpaperPath=${OriginalWallpaper:8:-1}
  else
    OWallpaperPath=$OriginalWallpaper
  fi
  touch /home/$user/Pictures/pizza-papers/settings.log
  echo "Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
  echo "Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "Select when adding:    1     #When the user adds a new wallpaper it will automatically make it their wallpaper" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "Set default wallpaper        #Will set the user's current wallpaper as the default wallpaper to fallback on when the current wallpaper is deleted" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "$OWallpaperPath" >> /home/$user/Pictures/pizza-papers/settings.log
=======
  echo "Bro how tf are you running this, you don't have the normal files"
>>>>>>> 4657cf0 (Removed clutter and fixed user options)
fi

<<<<<<< HEAD
###########################################
=======
WallpaperList=()						#Needed so that that user can have custom wallpapers
=======
VERSION=$"pizzapaper 1.1.5"				#Tells the user the version
=======
VERSION=$"pizzapaper 1.2.0"				#Tells the user the version
>>>>>>> 47c7cb9 (Update pizza-paper.sh)
user=$(whoami)							      #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						      #Needed so that that user can have custom wallpapers
>>>>>>> 3a0bfea (Major update)
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done
<<<<<<< HEAD
>>>>>>> 9e21837 (Updated to help with redundancy)
=======
=======
VERSION=$"pizzapaper 1.2.2"	          			#Tells the user the version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done                   
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
VERSION=$"pizzapaper 1.2.3"	     	          #Tells the user the version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers               
AMOUNT_OF_SETTINGS=3
>>>>>>> 4d4fc3f (New Settings)
#I like these ones better ^^^^^ so they get to be at the top
=======
VERSION=$"pizzapaper 1.2.5"	                #Tells the user the current version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers               
AMOUNT_OF_SETTINGS=5                        #Will be used to know how many lines to look for in settings (while loops amiright?)
#I like these variables better ^^^^^ so they get to be at the top
>>>>>>> e945341 (Added redundancy)

#Necessary checks needed for redundancy and being more user-friendly
if [ -d /home/pizza2d1 ]; then				                                              #I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
  IAMGOD=true
else
  IAMGOD=false
fi
if [ -f /usr/local/bin/pizzapaper ]; then			                                        #ProgName will be used to swap between "pizza-paper.sh" and "pizzapaper" depending on what the user has installed for convenience
  ProgName="pizzapaper"                             
elif [ -f ./pizza-paper.sh ]; then
  ProgName="./pizza-paper.sh"
fi
#Checks to see if the user decided to download all the included wallpapers (pizzapaper --sample)
if [ -f /home/$user/Pictures/pizza-papers/mountains.jpg ] && [ -f /home/$user/Pictures/pizza-papers/astolfo.jpg ] && [ -f /home/$user/Pictures/pizza-papers/sunglasses.jpeg ] && [ -f /home/$user/Pictures/pizza-papers/TRAINS.jpg ]; then
  ShortHelpFlag="|m|a|s|t"                                                            #Will display sample wallpaper options if the user has them downloaded
  SampleWallpaperStatus=""                                                            #Will NOT say something if the user has sample images
  YesYouHaveIt="(If you would like to delete them, use \"$ProgName --sample remove\")"          #Will tell the user if they have the sample images if it detects them
  WallpaperAccess=true                                                                #Will allow the user to access the sample images now that they're downloaded
else
  ShortHelpFlag=""                                                                    #Will display sample wallpaper options if the user has them downloaded (they dont)
  SampleWallpaperStatus=" (Must use --sample argument to install sample wallpapers)"  #The double spacing is needed to make sure that the variable doesn't touch the text in the help command
  YesYouHaveIt="(I recommend that you do)"                                            #No they don't have it
  WallpaperAccess=false                                                               #Will prevent the user from triggering the sample wallpaper functions because they haven't been downloaded
fi
###########################################
>>>>>>> 3a0bfea (Major update)

# curl
#MAIN FUNCTIONS

<<<<<<< HEAD
<<<<<<< HEAD
function Less_Help (){                        #Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-h$ShortHelpFlag | --help|add|select|sample|remove|settings|rotate|version]\"\n (The --help option may be more helpful)\n"
  if [[ ! $ProgName == *"pizzapaper"* ]]; then
    echo -e "OPTIONAL:"
    echo -e "   If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
    echo -e "   To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/custom_paths/pizzapaper\""
    echo -e "   After you run it, you can delete pizza-paper.sh :3\n"
=======
function Help_Options (){		#Gives the user instructions on how to use the program
=======
#Adds the neccessary directories and files in case the user doesn't have them
if [ ! -d "/home/$user/Documents" ]; then			                        #Makes a Documents directory in case you are a weird little idiot that feels like they're better than everyone else, along with making a text file for listing custom wallpapers
  echo "wtf why don't you have a Documents folder, making one now to store a list of your wallpapers..."
  mkdir /home/$user/Documents
fi
if [ ! -f "/home/$user/Documents/pizzapapers.txt" ]; then             #Will make a pizzapapers text file to list all the custom wallpapers (in path/to/image style) that the user adds
  touch /home/$user/Documents/pizzapapers.txt
fi
while read -r LINE; do
  WallpaperList+=("$LINE")
done  < "/home/$user/Documents/pizzapapers.txt"

if [ ! -d "/home/$user/Pictures" ]; then                              #Makes a Pictures directory in case you are a little weird idiot that feels like they're better than everyone else, along with making a directory for custom wallpapers
  echo "wtf why don't you have a Pictures folder, making one now to store your custom wallpapers..."
  mkdir /home/$user/Pictures
fi
if [ ! -d "/home/$user/Pictures/pizza-papers" ]; then                 #Will make a pizzapapers directory that will store you custom wallpapers
  mkdir /home/$user/Pictures/pizza-papers
fi
if [ ! -f "/home/$user/Pictures/pizza-papers/settings.log" ]; then    #Creates a settings.log file if the user does not have it to store settings such as "show cli" or "open with selector"
  OriginalWallpaper=$(gsettings get org.gnome.desktop.background picture-uri)
  if [[ $OriginalWallpaper == *"file://"* ]]; then
    OWallpaperPath=${OriginalWallpaper:8:-1}
  else
    OWallpaperPath=$OriginalWallpaper
  fi
  touch /home/$user/Pictures/pizza-papers/settings.log
  echo "Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
  echo "Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "Select when adding:    1     #When the user adds a new wallpaper it will automatically make it their wallpaper" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "Set default wallpaper        #Will set the user's current wallpaper as the default wallpaper to fallback on when the current wallpaper is deleted" >> /home/$user/Pictures/pizza-papers/settings.log
  echo "$OWallpaperPath" >> /home/$user/Pictures/pizza-papers/settings.log
fi

###########################################

# curl
#MAIN FUNCTIONS

function Less_Help (){                        #Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-h$ShortHelpFlag | --help|add|select|sample|remove|settings|version]\"\n (The --help option may be more helpful)\n"
  if [[ ! $ProgName == *"pizzapaper"* ]]; then
    echo -e "OPTIONAL:"
    echo -e "   If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
    echo -e "   To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
    echo -e "   After you run it, you can delete pizza-paper.sh :3\n"
  fi
}

<<<<<<< HEAD
function Help_Options (){		                  #Gives the user instructions on how to use the program
<<<<<<< HEAD
>>>>>>> 3a0bfea (Major update)
  echo -e "This is my first attempt at making a help thing so Im going to try to make it as helpful for you as it can be to me\n"
=======
=======
function Help_Options (){                     #Gives the user instructions on how to use the program
>>>>>>> e945341 (Added redundancy)
  echo -e "I hate most --help descriptors that normal commands have that are overly-confusing, so I'm going to try to make this simple enough that a younger me could understand it\n"
>>>>>>> 6d0c079 (MAJOR UPDATE)
  echo -e "$ProgName is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "To use this command you must do:\n  $ProgName [ARG]"
  echo -e "  E.G. \"$ProgName -h\", \"$ProgName --sample\", or \"$ProgName --add\"\n\n"
  echo -e "   -h                 Gives the user a simple idea of what options to choose\n"
  echo -e "   -m | -mountain     Switches wallpaper to a mountainside           $SampleWallpaperStatus\n"
  echo -e "   -a | -astolfo      Switches wallpaper to Astolfo                  $SampleWallpaperStatus\n"
  echo -e "   -s | -sunglasses   Switches wallpaper to sunglasses on a beach    $SampleWallpaperStatus\n"
  echo -e "   -t | -train        Switches wallpaper to a picture of a train     $SampleWallpaperStatus\n"
  echo -e "  --sample            Will download sample images $YesYouHaveIt\n"
  echo -e "  --add               Lets you add custom wallpapers to a text file that you can select from (in the future), USAGE: --add | --add [Image URL]\n"
  echo -e "  --select            Lets you select what wallpaper you want to use out of your custom wallpapers that you have added, USAGE: --select | --select [wallpaper number]\n"
  echo -e "  --remove            Lets you remove a single or multiple wallpapers from your pizzapapers list/folder\n"
  echo -e "  --settings          Lets you select different settings that might be more useful to you\n"
  echo -e "  --rotate            Will rotate through all of your saved wallpapers\n"
  echo -e "  --version           Echos the current $ProgName version\n"
  echo -e "  --help              Will display this, a much more detailed explanation on how to use this program and its arguments\n\n"
}

<<<<<<< HEAD
<<<<<<< HEAD
function Less_Help (){			#Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-a|A|c/cat|d/dog | --help|add|select|version]\"\n (The --help option may be more helpful)\n"
  echo -e "This program DOES NOT automatically work as \"pizzapaper [ARG]\" you will need to run it as \"./pizza-paper.sh [ARG]\"\n"
  echo -e "If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
  echo -e "To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
  echo -e "After you run it, you can delete pizza-paper.sh :3\n"
}

#Kinda useless rn, might use as a reference though
function UserInput (){
  name=$(zenity --entry --title="Please enter your name" --text="Enter your name:")	#Takes the name of the person using an "entry" input box
  if [ $? -eq 0 ]
  then
    zenity --info --text="Hello $name"
>>>>>>> 9e21837 (Updated to help with redundancy)
  fi
}

<<<<<<< HEAD
function Help_Options (){                     #Gives the user instructions on how to use the program
  echo -e "I hate most --help descriptors that normal commands have that are overly-confusing, so I'm going to try to make this simple enough that a younger me could understand it\n"
  echo -e "$ProgName is a custom program that I made as a passion project to learn how to switch wallpapers in terminal, which eventually turned into a full passion project on learning how a small area of display bash-scripting works. Im also attempting to learn git commands alongside this so that I might become a better programmer and because I think it's interesting\n"
  echo -e "To use this command you must do:\n  $ProgName [ARG]"
  echo -e "  E.G. \"$ProgName -h\", \"$ProgName --sample\", or \"$ProgName --add\"\n\n"
  echo -e "   -h                 Gives the user a simple idea of what options to choose\n"
  echo -e "   -m | -mountain     Switches wallpaper to a mountainside           $SampleWallpaperStatus\n"
  echo -e "   -a | -astolfo      Switches wallpaper to Astolfo                  $SampleWallpaperStatus\n"
  echo -e "   -s | -sunglasses   Switches wallpaper to sunglasses on a beach    $SampleWallpaperStatus\n"
  echo -e "   -t | -train        Switches wallpaper to a picture of a train     $SampleWallpaperStatus\n"
  echo -e "  --sample            Will download sample images $YesYouHaveIt\n"
  echo -e "  --add               Lets you add custom wallpapers to a text file that you can select from (in the future), USAGE: --add | --add [Image URL]\n"
  echo -e "  --select            Lets you select what wallpaper you want to use out of your custom wallpapers that you have added, USAGE: --select | --select [wallpaper number]\n"
  echo -e "  --remove            Lets you remove a single or multiple wallpapers from your pizzapapers list/folder\n"
  echo -e "  --settings          Lets you select different settings that might be more useful to you\n"
  echo -e "  --rotate            Will rotate through all of your saved wallpapers, USAGE: --rotate [seconds between switching]]\n"
  echo -e "  --version           Echos the current $ProgName version\n"
  echo -e "  --help              Will display this, a much more detailed explanation on how to use this program and its arguments\n\n"
}

function AddWallpaper (){                     #Will let the user add a wallpaper from their computer files

<<<<<<< HEAD
=======
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

=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
function AddWallpaper (){                     #Will let the user add a wallpaper from their computer files
>>>>>>> 3a0bfea (Major update)
=======
>>>>>>> e945341 (Added redundancy)
  echo -e "How would you like to add your custom wallpaper?:\n"
  echo -e "  1. File selection        Will add a wallpaper from your local computer storage"
  echo -e "  2. Web image URL         Will take a image URL and download it to your /Pictures/pizza-papers/ directory\n"
  read -p "[1/2]: " uinput
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  AddToSet=$(echo "AddToSet" | GetSettings)
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
  AddToSet=$(echo "AddToSet" | GetSettings)
>>>>>>> 4d4fc3f (New Settings)
  if [[ $uinput == "1" || $uinput == *"ile"* ]]; then                                   #Checks to see if the user chose 1 or file/File
    echo "Select which file(s) you would like to add"                                   #Yes, you can select multiple files
    Files=$(zenity --file-selection --multiple)                                         #Opens file selection to choose image files
    IFS='|'                                                                             #Sets the splice modifier so that "read -ra" splits the $Files string after every "|"
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> e945341 (Added redundancy)
    if [[ $Files == "" ]]; then
      echo "Exiting out"
      exit;
    fi
    read -ra IndividualImages <<< "$Files" #Appends each file name into an array name IndividualImages
    if [[ ${#IndividualImages[@]} == 1 ]] && [[ $AddToSet == "1" ]]; then
      gsettings set org.gnome.desktop.background picture-uri "$IndividualImages"
      gsettings set org.gnome.desktop.background picture-uri-dark "$IndividualImages"
    fi
    for fileL in "${IndividualImages[@]}"; do   #For each image that the user selected...
      if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]] && [[ $fileL != *" "* ]]; then  #Will only accept URLs with https and valid image file extensions
        if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
          printf "%s\n" "$fileL" >> /home/$user/Documents/pizzapapers.txt
          cp "$fileL" /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
=======
    read -ra IndividualImages <<< "$Files" #Appends each file name into an array name IndividualImages
    if [[ ${#IndividualImages[@]} == 1 ]] && [[ $AddToSet == "1" ]]; then
      gsettings set org.gnome.desktop.background picture-uri "$IndividualImages"
      gsettings set org.gnome.desktop.background picture-uri-dark "$IndividualImages"
    fi
    for fileL in "${IndividualImages[@]}"; do   #For each image that the user selected...
      if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]] && [[ $fileL != *" "* ]]; then  #Will only accept URLs with https and valid image file extensions
        if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
<<<<<<< HEAD
          echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
          cp $fileL /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
          printf "%s\n" "$fileL" >> /home/$user/Documents/pizzapapers.txt
          cp "$fileL" /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
>>>>>>> 4d4fc3f (New Settings)
          echo "$(basename $fileL) has been added to your wallpapers"
        else
          echo "That wallpaper is already in your list of wallpapers"
        fi
<<<<<<< HEAD
<<<<<<< HEAD
      elif [[ $fileL != "" ]]; then
        echo "$(basename $fileL) is not a valid image file type"
      else
        echo "You did not make a selection or chose a invalid file type"
      fi
    done
  elif [[ $uinput == "2" || $uinput == *"eb"* || $uinput == *"URL"* ]]; then           #Checks to see if the user chose 2 or web/Web/URL
    URL=$(zenity --entry --title="Please input a image URL")
    if [[ $URL == *".jpg"* || $URL == *".jpeg"* || $URL == *".png"* ]]; then           #Will only accept files that contain image extensions
      if [[  ${WallpaperList[@]} != *"$URL"* ]]; then					                         #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
        cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O "$URL" ; cd -; }            #Downloads the URL image to the pizza-papers directory
        cp $URL /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
        echo "$URL" >> /home/$user/Documents/pizzapapers.txt
        echo "$(basename $URL) has been added to your wallpapers"
        if [[ $AddToSet == "1" ]]; then
          gsettings set org.gnome.desktop.background picture-uri /home/$user/Pictures/pizza-papers/$URL
          gsettings set org.gnome.desktop.background picture-uri-dark /home/$user/Pictures/pizza-papers/$URL
        fi
      else
        echo "That wallpaper is already in your list of wallpapers"
      fi
    elif [[ $URL == "" ]]; then
      echo "No link provided, exiting"
=======
function AddWallpaper (){
  fileL=$(zenity --file-selection --file-filter="*.jpg")				#Opens file selection but only allows *.jpg options to be used
  if [[ $fileL == *".jpg"* ]]; then							#Makes sure that the user's file choice was a .jpg image
    if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					#Checks to make sure that PART of $fileL is nowhere in the WallpaperList array 
      feh $fileL -E 128 -y 128								#Show the new wallpaper in a -E (height) 128 px and -y (width) 128 px (yes they made -y be width)
      echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
>>>>>>> 5b06502 (Updated file)
    else
=======
  if [[ $uinput == "1" || $uinput == *"ile"* ]]; then                                  #Checks to see if the user chose 1 or file/File
    fileL=$(zenity --file-selection)				                                          #Opens file selection to choose a image file
    if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]]; then  #Will only accept URLs with https and valid image file extensions
      if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
        echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
        echo "$(basename $fileL) has been added to your wallpapers"
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
      elif [[ $fileL != "" ]]; then
        echo "$(basename $fileL) is not a valid image file type"
>>>>>>> e945341 (Added redundancy)
      else
        echo "You did not make a selection or chose a invalid file type"
      fi
    done
  elif [[ $uinput == "2" || $uinput == *"eb"* || $uinput == *"URL"* ]]; then           #Checks to see if the user chose 2 or web/Web/URL
    URL=$(zenity --entry --title="Please input a image URL")
    if [[ $URL == *".jpg"* || $URL == *".jpeg"* || $URL == *".png"* ]]; then           #Will only accept files that contain image extensions
      if [[  ${WallpaperList[@]} != *"$URL"* ]]; then					                         #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
        cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O "$URL" ; cd -; }            #Downloads the URL image to the pizza-papers directory
        cp $URL /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
        echo "$URL" >> /home/$user/Documents/pizzapapers.txt
        echo "$(basename $URL) has been added to your wallpapers"
        if [[ $AddToSet == "1" ]]; then
          gsettings set org.gnome.desktop.background picture-uri /home/$user/Pictures/pizza-papers/$URL
          gsettings set org.gnome.desktop.background picture-uri-dark /home/$user/Pictures/pizza-papers/$URL
        fi
      else
        echo "That wallpaper is already in your list of wallpapers"
      fi
    elif [[ $URL == "" ]]; then
      echo "No link provided, exiting"
    else
>>>>>>> 3a0bfea (Major update)
      echo -e "Invalid link, make sure it contains an image extension type, E.G. \"IMAGE-NAME.[png | jpg | jpeg]\""  
    fi
  else
    echo -e "\nInvalid input\n"
  fi
}

<<<<<<< HEAD
<<<<<<< HEAD
function SelectWallpaper (){                  #The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
=======
function SelectWallpaper (){								  #The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
>>>>>>> 3a0bfea (Major update)
=======
function SelectWallpaper (){                  #The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
>>>>>>> e945341 (Added redundancy)
  if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
    echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add\n"
    exit;
  fi
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  echo -e "\n  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list
=======
  echo "  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list #########################
>>>>>>> 3a0bfea (Major update)
=======
  echo -e "\n  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list #########################
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
  echo -e "\n  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list
>>>>>>> 4d4fc3f (New Settings)
  Num=1
  for LINE in ${WallpaperList[@]}; do           #A loop that encompasses ALL items in the WallpaperList array
    ImageName="$(basename $LINE)"               #Takes the substring value of the image by removing the parent directories from the string
    echo "  $Num   $ImageName"								  #Displays the wallpaper FILE name and its number selection choice
    ((Num+=1))
  done
<<<<<<< HEAD
<<<<<<< HEAD
  echo "" #Just a spacer
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal #REFERENCE#
  re='^[0-9]+$'
  if [[ $uinput == "0" ]]; then                 #Will check that the user wanted to delete a wallpaper
    echo -e "\n  0   Exit"
=======
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal #REFERENCE#
  re='^[0-9]+$'
  if [[ $uinput == "0" ]]; then                 #Will check that the user wanted to delete a wallpaper
    echo -e "\n\n  0   Exit"
>>>>>>> 3a0bfea (Major update)
=======
  echo "" #Just a spacer
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal #REFERENCE#
  re='^[0-9]+$'
  if [[ $uinput == "0" ]]; then                 #Will check that the user wanted to delete a wallpaper
    echo -e "\n  0   Exit"
>>>>>>> 6d0c079 (MAJOR UPDATE)
    Num=1
    for LINE in ${WallpaperList[@]}; do
      ImageName="$(basename $LINE)"
      echo "  $Num   $ImageName"
      ((Num+=1))
    done
    echo ""
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> e945341 (Added redundancy)
  if [[ $uinput =~ $re ]] && [[ $uinput -lt $((${#WallpaperList[@]}+1)) ]]; then								#Checks to see that the user's input is a number
    echo "$(basename ${WallpaperList[$uinput-1]}) is now your new wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
    gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($uinput-1)) ]}
    gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($uinput-1)) ]}
=======
  if [[ $uinput =~ $re ]]; then								#Checks to see that the user's input is a number
    echo "$(basename ${WallpaperList[$uinput-1]}) is now your new wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
    gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($uinput-1)) ]}
<<<<<<< HEAD
>>>>>>> 3a0bfea (Major update)
=======
    gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($uinput-1)) ]}
>>>>>>> 6d0c079 (MAJOR UPDATE)
  else
    echo "Invalid input"
  fi
}
<<<<<<< HEAD
<<<<<<< HEAD

function GUISelectWallpaper (){               #The user chooses a wallpaper out of their custom wallpapers from a feh gui image selector
  if test -e /home/$user/Pictures/pizza-papers/; then
    touch TEMPLIST.txt
    if [[ ${#WallpaperList[@]} -lt 8 ]]; then #If there are LESS THAN (-lt) 8 images in the WallpaperList array then feh will display the images larger for selection
      FehImageHeight=256
      FehImageWidth=216
    else
      FehImageHeight=128
      FehImageWidth=108
    fi
    feh -t /home/$user/Pictures/pizza-papers/ -E $FehImageHeight -y $FehImageWidth --action 'echo %n >> ./TEMPLIST.txt'  #Opens a feh GUI in "thumbnail" mode so that that user can select a wallpaper from their list that they can see/select from
    FirstImage=$(head -n 1 ./TEMPLIST.txt)
    if [[ $FirstImage == "" ]]; then
      echo "You did not select an image"
    else
      echo "$FirstImage is now your desktop wallpaper"
      gsettings set org.gnome.desktop.background picture-uri-dark /home/$user/Pictures/pizza-papers/$FirstImage
      gsettings set org.gnome.desktop.background picture-uri /home/$user/Pictures/pizza-papers/$FirstImage
    fi
    rm ./TEMPLIST.txt
    exit;
  else
    echo "You do not have any custom wallpapers"
    exit;
  fi
}
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)

function GUISelectWallpaper (){               #The user chooses a wallpaper out of their custom wallpapers from a feh gui image selector
  if test -e /home/$user/Pictures/pizza-papers/; then
    touch TEMPLIST.txt
    if [[ ${#WallpaperList[@]} -lt 8 ]]; then #If there are LESS THAN (-lt) 8 images in the WallpaperList array then feh will display the images larger for selection
      FehImageHeight=256
      FehImageWidth=216
    else
      FehImageHeight=128
      FehImageWidth=108
    fi
    feh -t /home/$user/Pictures/pizza-papers/ -E $FehImageHeight -y $FehImageWidth --action 'echo %n >> ./TEMPLIST.txt'  #Opens a feh GUI in "thumbnail" mode so that that user can select a wallpaper from their list that they can see/select from
    FirstImage=$(head -n 1 ./TEMPLIST.txt)
    if [[ $FirstImage == "" ]]; then
      echo "You did not select an image"
    else
      echo "$FirstImage is now your desktop wallpaper"
      gsettings set org.gnome.desktop.background picture-uri-dark /home/$user/Pictures/pizza-papers/$FirstImage
      gsettings set org.gnome.desktop.background picture-uri /home/$user/Pictures/pizza-papers/$FirstImage
    fi
    rm ./TEMPLIST.txt
    exit;
  else
    echo "You do not have any custom wallpapers"
    exit;
  fi
}

function RemoveWallpaper (){                  #The user can choose what wallpaper(s) they want to delete
  echo "Select the wallpaper(s) you would like to remove"
  if [ -e /home/$user/Pictures/pizza-papers/ ]; then  #Checks if there are any files in the pizza-papers directory
    touch TEMPLIST.txt   #Can't use zenity to choose what files to delete because I can't automatically make zenity open to the /Pictures/pizza-papers directory
    feh -t /home/$user/Pictures/pizza-papers/ -E 128 -y 128 -W 1024 --action 'echo %n >> ./TEMPLIST.txt; exit;' #Thumbnail mode displaying small previews of wallpapers that the user can select
    for SingleImage in $(cat ./TEMPLIST.txt); do
      if [[ $SingleImage == "" ]]; then
        echo "You did not select an image"
        exit;
      fi
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d4fc3f (New Settings)
      if [[ $SingleImage != *".jpg"* && $SingleImage != *".jpeg"* && $SingleImage != *".png"* ]]; then
        echo -e "\nyou have selected a invalid image, make sure it does not contain any white-spaces, to force remove invalid image you must have \"CLI Selection\" settings enabled and THEN delete it in $ProgName --selection\n"
        exit;
      fi
<<<<<<< HEAD
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
>>>>>>> 4d4fc3f (New Settings)
      read -p "Are you sure you want to delete $SingleImage? [y/N]: " UserConfimation  #If the user selects a wallpaper, it will ask for confirmation that they want to delete it and store the input as $UserConfirmation
      if [[ $UserConfimation == *"y"* ]]; then
        rm /home/$user/Pictures/pizza-papers/$SingleImage
        echo "Deleted $SingleImage"
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d4fc3f (New Settings)
        WallpaperList=( ${WallpaperList[@]/*"$SingleImage"*} )    #Will take out the wallpaper with the same name as what was selected so DONT HAVE IMAGES WITH SAME NAME, EVEN WITH DIFFERENT PATHS
        rm /home/$user/Documents/pizzapapers.txt                  #Resets the wallpaper list
        for LINE in ${WallpaperList[@]}; do
          echo $LINE >> /home/$user/Documents/pizzapapers.txt     #Creates and writes the new array to the new pizzapapers.txt
        done
<<<<<<< HEAD
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
>>>>>>> 4d4fc3f (New Settings)
      else
        echo "Did not delete $SingleImage"
      fi
    done
    rm ./TEMPLIST.txt
<<<<<<< HEAD
<<<<<<< HEAD
    FallbackWallpaper     #If the user deletes their current wallpaper (which is stored in the pizza-papers folder) the default wallpaper will be set
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
    FallbackWallpaper     #If the user deletes their current wallpaper (which is stored in the pizza-papers folder) the default wallpaper will be set
>>>>>>> e945341 (Added redundancy)
    exit;
  else
    echo "You do not have any custom wallpapers"
    exit;
  fi
}

<<<<<<< HEAD
<<<<<<< HEAD
function Settings (){                         #Will allow the user to change settings in the CLI to let them determine default function that runs when the user does not provide an argument (current: LessHelp)
  DisplayCurrentDefault
  GetSettings
  echo "" #adds a spacer
  read -p "What setting do you want to change? [1/2/3/4]: " uinput
<<<<<<< HEAD
  while [[ $uinput != "" ]]; do
    if [[ $uinput == "1" ]]; then
      Setting1        #Used for enabling CLI interface
=======
function Settings (){                        #Will allow the user to change settings in the CLI to let them determine default function that runs when the user does not provide an argument (current: LessHelp)
=======
function Settings (){                         #Will allow the user to change settings in the CLI to let them determine default function that runs when the user does not provide an argument (current: LessHelp)
>>>>>>> e945341 (Added redundancy)
  DisplayCurrentDefault
  GetSettings
  echo "" #adds a spacer
  read -p "What setting do you want to change? [1/2]: " uinput
  while [[ $uinput != "" ]]; do
    if [[ $uinput == "1" ]]; then
      Setting1
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
  while [[ $uinput != "" ]]; do
    if [[ $uinput == "1" ]]; then
      Setting1        #Used for enabling CLI interface
>>>>>>> 61b68b7 (Added wallpaper rotation)
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "2" ]]; then
<<<<<<< HEAD
<<<<<<< HEAD
      Setting2        #Used for changing the default function
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "3" ]]; then
      Setting3        #Used for if the user wants to set new wallpapers
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "4" ]]; then
      Setting4        #Used to set the default wallpaper
=======
      Setting2
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
      Setting2        #Used for changing the default function
>>>>>>> 61b68b7 (Added wallpaper rotation)
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "3" ]]; then
      Setting3        #Used for if the user wants to set new wallpapers
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "4" ]]; then
      Setting4        #Used to set the default wallpaper
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    else
      echo "Invalid input"
      exit
    fi
<<<<<<< HEAD
<<<<<<< HEAD
    read -p "What setting do you want to change? [1/2/3/4]: " uinput
=======
    read -p "What setting do you want to change? [1/2]: " uinput
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
    read -p "What setting do you want to change? [1/2/3/4]: " uinput
>>>>>>> 61b68b7 (Added wallpaper rotation)
  done
  echo "Exiting"
  exit;

}
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> e945341 (Added redundancy)

function FallbackWallpaper (){                #If the user deletes their current wallpaper, they can run pizzapaper again to set it back to their default wallpaper when they first ran the program
  CurrentWallpaper=$(gsettings get org.gnome.desktop.background picture-uri)
  CurrentWallpaperDark=$(gsettings get org.gnome.desktop.background picture-uri-dark)
  if [[ $CurrentWallpaper == *"file://"* ]]; then
    CurrentWallpaper=${CurrentWallpaper:8:-1}
  fi
  if [[ $CurrentWallpaperDark == *"file://"* ]]; then
    CurrentWallpaperDark=${CurrentWallpaperDark:8:-1}
  fi
  if [ ! -f ${CurrentWallpaper:1:-1} ] && [ ! -f ${CurrentWallpaperDark:1:-1} ]; then
    while read -r LINE; do
      SettingsText+=("$LINE")
    done  < "/home/$user/Pictures/pizza-papers/settings.log"
    echo -e "\nLooks like you deleted your current wallpaper, reverting back to your original wallpaper\n"
    gsettings set org.gnome.desktop.background picture-uri "${SettingsText[ (($AMOUNT_OF_SETTINGS-1)) ]}"
    gsettings set org.gnome.desktop.background picture-uri-dark "${SettingsText[ (($AMOUNT_OF_SETTINGS-1)) ]}"
  fi
}
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 61b68b7 (Added wallpaper rotation)

function RotateWallpaper (){
  CurrentWallpaper=$(gsettings get org.gnome.desktop.background picture-uri)
  if [[ ${WallpaperList[@]} == *${CurrentWallpaper:1:-1}* ]]; then
    for item in $(seq 0 ${#WallpaperList[@]}); do
      if [[ ${WallpaperList[$item]} == *${CurrentWallpaper:1:-1}* ]]; then
        Index=$item;
      fi
    done
    for i in $(seq $Index $((${#WallpaperList[@]}-1))); do
<<<<<<< HEAD
      if [[ ! ${WallpaperList[i]} == *"astolfo"* ]]; then
        if ! $FagFlag; then
          continue
        else
          gsettings set org.gnome.desktop.background picture-uri "${WallpaperList[i]}"
          gsettings set org.gnome.desktop.background picture-uri-dark "${WallpaperList[i]}"
          sleep $ROTATION_SPEED
          echo "Wump"
        fi
      fi
=======
      gsettings set org.gnome.desktop.background picture-uri "${WallpaperList[i]}"
      gsettings set org.gnome.desktop.background picture-uri-dark "${WallpaperList[i]}"
      sleep $ROTATION_SPEED
>>>>>>> 61b68b7 (Added wallpaper rotation)
    done
  fi
  while true; do
    CurrentWallpaper=$(gsettings get org.gnome.desktop.background picture-uri)
    CurrentWallpaperDark=$(gsettings get org.gnome.desktop.background picture-uri-dark)
    if [[ $CurrentWallpaper != $CurrentWallpaperDark ]]; then
      $CurrentWallpaperDark=$CurrentWallpaper
    fi
    for i in $(seq 0 $((${#WallpaperList[@]}-1))); do
<<<<<<< HEAD
      if [[ ! ${WallpaperList[i]} == *"astolfo"* ]]; then
        if ! $FagFlag; then
          continue
        else
          gsettings set org.gnome.desktop.background picture-uri "${WallpaperList[i]}"
          gsettings set org.gnome.desktop.background picture-uri-dark "${WallpaperList[i]}"
          sleep $ROTATION_SPEED
          echo "Wump"
        fi
      fi
    done
  done
}
##########################################


#Smaller functions that are only for clean code and ease of development

function GetSettings() {  #Will return number values depending on what was piped into it
  SettingsArray=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsArray+=($LINE)
    fi
  done

  #Will display settings and what value they are
  if [ -t 0 ]; then #Will check if a value has NOT been piped INTO the function, running [ -t 1 ] again will test if the function is being piped OUT of the function
    EchoSettings="/home/$user/Pictures/pizza-papers/settings.log" #Gets all number values in settings files (numbers are the data being used)
    SettingNumber=0
    while read -r LINE; do
      SettingNumber=$(( $SettingNumber+1 ))
      if [[ ! $LINE == *"/"* ]]; then
        printf "%s\n" "$SettingNumber. ${LINE:0:24}"    # {parameter:startingposition:offset}  Variable name, starts at 0, how many letters you want to encompass/read
      fi
    done < $EchoSettings    #Will use the settings.log file as the input for the read -r operation
    return
  fi

  read PipedValue #Since there WAS a piped value we can read it without the program getting softlocked and get a return value :3
  if [[ $PipedValue == "WantCLI" ]]; then
    echo ${SettingsArray[0]}
  elif [[ $PipedValue == "Default" ]]; then
    echo ${SettingsArray[1]}
  elif [[ $PipedValue == "AddToSet" ]]; then
    echo ${SettingsArray[2]}
  else
    echo "How did this happen"
  fi
}

function Setting1 (){     #Used for enabling CLI interface
  SETTING_NUMBER=1 #Use this to determine what setting is being changed
  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "1" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Enable CLI Selection:  1     #Lets the user use CLI instead of the default GUI selectors"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}
function DisplayCurrentDefault (){
  SettingValue=$(echo "Default" | GetSettings)
  if [[ $SettingValue == "1" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    LessHelp -----------> Will display a short amount of arguments the user can do\n"
  elif [[ $SettingValue == "2" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    MoreHelp -----------> Will display all arguments and descriptions that the user can do\n"
  elif [[ $SettingValue == "3" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    AddWallpaper -------> Will allow the user to add a wallpaper from their file system or image URL\n"
  else
    echo "###########################################"
    echo -e "\nCurrent Default Function:    SelectWallpaper ----> Will prompt the user to select a wallpaper from their pizza-papers folder\n"
  fi
}

function Setting2 (){     #Used for changing the default function...
  SETTING_NUMBER=2 #Use this to determine what setting is being changed

  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "4" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Default Function:      $((${SettingsValues[ (($SETTING_NUMBER-1)) ]}+1))     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}

function Setting3 (){     #Used for if the user wants to set new wallpapers
  SETTING_NUMBER=3 #Use this to determine what setting is being changed
  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "1" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Select when adding:    0     #When the user adds a new wallpaper it will automatically make it their wallpaper"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Select when adding:    1     #When the user adds a new wallpaper it will automatically make it their wallpaper"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}

function Setting4 (){     #Used to set the default wallpaper
  SETTING_NUMBER=4 #Use this to determine what setting/line is being changed
  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  NewDefaultWallpaper=$(gsettings get org.gnome.desktop.background picture-uri-dark)
  SettingsText[ (($SETTING_NUMBER-1)) ]="$NewDefaultWallpaper"
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
  echo -e "\n##########################\nSet $NewDefaultWallpaper as your new default wallpaper\n##########################\n"
}
##########################################
=======
###########################################
>>>>>>> 3a0bfea (Major update)


=======
=======
>>>>>>> e945341 (Added redundancy)
=======
      gsettings set org.gnome.desktop.background picture-uri "${WallpaperList[i]}"
      gsettings set org.gnome.desktop.background picture-uri-dark "${WallpaperList[i]}"
      sleep $ROTATION_SPEED
    done
  done
}
>>>>>>> 61b68b7 (Added wallpaper rotation)
##########################################


#Smaller functions that are only for clean code and ease of development

function GetSettings() {  #Will return number values depending on what was piped into it
  SettingsArray=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsArray+=($LINE)
    fi
  done

  #Will display settings and what value they are
  if [ -t 0 ]; then #Will check if a value has NOT been piped INTO the function, running [ -t 1 ] again will test if the function is being piped OUT of the function
    EchoSettings="/home/$user/Pictures/pizza-papers/settings.log" #Gets all number values in settings files (numbers are the data being used)
    SettingNumber=0
    while read -r LINE; do
      SettingNumber=$(( $SettingNumber+1 ))
      if [[ ! $LINE == *"/"* ]]; then
        printf "%s\n" "$SettingNumber. ${LINE:0:24}"    # {parameter:startingposition:offset}  Variable name, starts at 0, how many letters you want to encompass/read
      fi
    done < $EchoSettings    #Will use the settings.log file as the input for the read -r operation
    return
  fi

  read PipedValue #Since there WAS a piped value we can read it without the program getting softlocked and get a return value :3
  if [[ $PipedValue == "WantCLI" ]]; then
    echo ${SettingsArray[0]}
  elif [[ $PipedValue == "Default" ]]; then
    echo ${SettingsArray[1]}
  elif [[ $PipedValue == "AddToSet" ]]; then
    echo ${SettingsArray[2]}
  else
    echo "How did this happen"
  fi
}

function Setting1 (){     #Used for enabling CLI interface
  SETTING_NUMBER=1 #Use this to determine what setting is being changed
  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "1" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Enable CLI Selection:  1     #Lets the user use CLI instead of the default GUI selectors"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}
function DisplayCurrentDefault (){
  SettingValue=$(echo "Default" | GetSettings)
  if [[ $SettingValue == "1" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    LessHelp -----------> Will display a short amount of arguments the user can do\n"
  elif [[ $SettingValue == "2" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    MoreHelp -----------> Will display all arguments and descriptions that the user can do\n"
  elif [[ $SettingValue == "3" ]]; then
    echo "###########################################"
    echo -e "\nCurrent Default Function:    AddWallpaper -------> Will allow the user to add a wallpaper from their file system or image URL\n"
  else
    echo "###########################################"
    echo -e "\nCurrent Default Function:    SelectWallpaper ----> Will prompt the user to select a wallpaper from their pizza-papers folder\n"
  fi
}

function Setting2 (){     #Used for changing the default function...
  SETTING_NUMBER=2 #Use this to determine what setting is being changed

  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "4" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Default Function:      $((${SettingsValues[ (($SETTING_NUMBER-1)) ]}+1))     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}

function Setting3 (){     #Used for if the user wants to set new wallpapers
  SETTING_NUMBER=3 #Use this to determine what setting is being changed
  SettingsValues=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsValues+=($LINE)
    fi
  done

  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  #Switches the value of the first setting
  if [[ ${SettingsValues[ (($SETTING_NUMBER-1)) ]} == "1" ]]; then
    SettingsText[ (($SETTING_NUMBER-1)) ]="Select when adding:    0     #When the user adds a new wallpaper it will automatically make it their wallpaper"
  else
    SettingsText[ (($SETTING_NUMBER-1)) ]="Select when adding:    1     #When the user adds a new wallpaper it will automatically make it their wallpaper"
  fi
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
}

function Setting4 (){     #Used to set the default wallpaper
  SETTING_NUMBER=4 #Use this to determine what setting/line is being changed
  SettingsText=()
  #Reads the individual lines of settings.log and puts it into an array
  while read -r LINE; do
    SettingsText+=("$LINE")
  done  < "/home/$user/Pictures/pizza-papers/settings.log"
  
  NewDefaultWallpaper=$(gsettings get org.gnome.desktop.background picture-uri-dark)
  SettingsText[ (($SETTING_NUMBER-1)) ]="$NewDefaultWallpaper"
  
  rm /home/$user/Pictures/pizza-papers/settings.log #Resets settings.log in a simple way
  touch /home/$user/Pictures/pizza-papers/settings.log

  for i in $(seq 0 $[$AMOUNT_OF_SETTINGS-1]); do
    printf "%s\n" "${SettingsText[i]}" >> /home/$user/Pictures/pizza-papers/settings.log
  done
  echo -e "\n##########################\nSet $NewDefaultWallpaper as your new default wallpaper\n##########################\n"
}
##########################################


>>>>>>> 6d0c079 (MAJOR UPDATE)
#For setting the SAMPLE wallpapers, the user might either have "picture-uri-dark" or "picture-uri" being displayed, so its best to just set both of them.-
#-Think of them like layers, where on one system picture-uri is on top of picture-uri-dark and vice versa, we just change both so we dont deal with it
<<<<<<< HEAD
<<<<<<< HEAD
function Mountain_Wallpaper (){		  #Sets the wallpaper to a cool mountainside
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/mountains.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/mountains.jpg
}
function Astolfo_Wallpaper (){		  #Sets the wallpaper to astolfo because I have a feeling my friends will open it
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/astolfo.jpg
}
function Sunglasses_Wallpaper (){		#Sets the wallpaper to a beach photo with some sunglasses
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
}
function Trains_Wallpaper (){	      #Sets the wallpaper to the inside of a autist's mind
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
=======
function Astolfo_Wallpaper (){		#Sets the wallpaper to that one pink faggot			#Oh right, they won't have these downloaded, I should remove these
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/wallpapers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/wallpapers/astolfo.jpg
  echo Pink bitch has been deployed
=======
function Mountain_Wallpaper (){		  #Sets the wallpaper to a cool mountainside
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/mountains.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/mountains.jpg
>>>>>>> 3a0bfea (Major update)
}
function Astolfo_Wallpaper (){		  #Sets the wallpaper to astolfo because I have a feeling my friends will open it
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/astolfo.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/astolfo.jpg
}
function Sunglasses_Wallpaper (){		#Sets the wallpaper to a beach photo with some sunglasses
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/sunglasses.jpeg
}
<<<<<<< HEAD
function Springfield_Wallpaper (){	#Sets the wallpaper to the springfield meme
<<<<<<< HEAD
  echo "This don't work, I'm adding online link support now"
  #gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Downloads/dogs.jpg
  #gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Downloads/dogs.jpg
  #echo Dog was activated
>>>>>>> 9e21837 (Updated to help with redundancy)
=======
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Downloads/dogs.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Downloads/dogs.jpg
  echo Dog was activated
>>>>>>> 4657cf0 (Removed clutter and fixed user options)
=======
function Trains_Wallpaper (){	      #Sets the wallpaper to the inside of a autist's mind
  gsettings set org.gnome.desktop.background picture-uri-dark / #Resets wallpaper to prevent the selected wallpaper from not refreshing
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
  gsettings set org.gnome.desktop.background picture-uri file:///home/$user/Pictures/pizza-papers/TRAINS.jpg
>>>>>>> 3a0bfea (Major update)
}
###########################################


<<<<<<< HEAD
<<<<<<< HEAD
#Lists the different options that the user can choose from, "hmast" is for individual letters options like "-h" and "-m"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
options=$(getopt -o hmast,help,mountain,astolfo,sunglasses,train --long "add,select,remove,sample,settings,help,version,normal,rotate" -- "$@")
=======
#Lists the different options that the user can choose from, "aAcdhr" is for individual letters btw
=======
#Lists the different options that the user can choose from, "hmast" is for individual letters options like "-h" and "-m"
>>>>>>> b0c5079 (Update pizza-paper.sh)
options=$(getopt -o hmast,mountain,astolfo,sunglasses,train --long "add,select,feature,help,version" -- "$@")
>>>>>>> 3a0bfea (Major update)
=======
options=$(getopt -o hmast,help,mountain,astolfo,sunglasses,train --long "add,select,remove,sample,settings,help,version" -- "$@")
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
options=$(getopt -o hmast,help,mountain,astolfo,sunglasses,train --long "add,select,remove,sample,settings,help,version,normal" -- "$@")
>>>>>>> e945341 (Added redundancy)
=======
options=$(getopt -o hmast,help,mountain,astolfo,sunglasses,train --long "add,select,remove,sample,settings,help,version,normal,rotate" -- "$@")
>>>>>>> 61b68b7 (Added wallpaper rotation)
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      -h | -help)                   #Will activate when pizzapaper -h is used)
         Less_Help
         exit;;
      -m | -mountain)       #Will make the desktop background a mountainside)
         if $WallpaperAccess; then
           Mountain_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      -a | -astolfo)        #Will make the desktop background astolfo)
         if $WallpaperAccess; then
           Astolfo_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
=======
       a)				#Will activate if the user is dumb and only does "a" for an "argument"
         echo "Yeah, ah to you too"
         exit;;
      -a)				#(NOT WORKING)Will activate when pizzapaper -a is used
         if $IAMGOD; then
           Astolfo_Wallpaper
         else
           echo "This don't work, I'm adding online link support now"
         fi
         exit;;
      -A)				#(NOT WORKING)Qill activate when pizzapaper -A is used
         if $IAMGOD; then
           Astolfo2_Wallpaper
         else
           echo "This don't work, I'm adding online link support now"
         fi
         exit;;
      -h)				#Will activate when pizzapaper -h is used
=======
      -h)				            #Will activate when pizzapaper -h is used)
>>>>>>> 3a0bfea (Major update)
=======
      -h | -help)                   #Will activate when pizzapaper -h is used)
>>>>>>> 6d0c079 (MAJOR UPDATE)
         Less_Help
         exit;;
      -m | -mountain)       #Will make the desktop background a mountainside)
         if $WallpaperAccess; then
           Mountain_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
<<<<<<< HEAD
<<<<<<< HEAD
      -d | -dog)			#(NOT WORKING)Will activate when pizzapaper -d or -dog is used
<<<<<<< HEAD
         Springfield_Wallpaper
>>>>>>> 9e21837 (Updated to help with redundancy)
=======
         if $IAMGOD; then
           Springfield_Wallpaper
=======
      -a | -astolfo)       #Will make the desktop background astolfo)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
=======
      -a | -astolfo)        #Will make the desktop background astolfo)
         if $WallpaperAccess; then
>>>>>>> 6d0c079 (MAJOR UPDATE)
           Astolfo_Wallpaper
>>>>>>> 3a0bfea (Major update)
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
>>>>>>> 4657cf0 (Removed clutter and fixed user options)
         exit;;
<<<<<<< HEAD
<<<<<<< HEAD
      -s | -sunglasses)     #Will make the desktop background some sunglasses)
         if $WallpaperAccess; then
           Sunglasses_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      -t | -train)          #Will make the desktop background a picture of a train)
         if [[  ${WallpaperList[@]} == *"TRAINS.jpg"* ]]; then	
<<<<<<< HEAD
           Trains_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      \?)                   #Does something, I don't know what, but if I remove it then it breaks so I'll keep it around)
         echo "Invalid option"
         exit;;
    --add)                  #Has the user select a image file's name to add to a text file which lists all custom wallpapers)
=======
      -s | -sunglasses)       #Will make the desktop background some sunglasses)
         if [[ $IAMGOD || $WallpaperAccess ]]; then
=======
      -s | -sunglasses)     #Will make the desktop background some sunglasses)
         if $WallpaperAccess; then
>>>>>>> 6d0c079 (MAJOR UPDATE)
           Sunglasses_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      -t | -train)          #Will make the desktop background a picture of a train)
         if $WallpaperAccess; then
=======
>>>>>>> 61b68b7 (Added wallpaper rotation)
           Trains_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      \?)                   #Does something, I don't know what, but if I remove it then it breaks so I'll keep it around)
         echo "Invalid option"
         exit;;
<<<<<<< HEAD
    --add)				          #Has the user select a image file's name to add to a text file which lists all custom wallpapers)
>>>>>>> 3a0bfea (Major update)
=======
    --add)                  #Has the user select a image file's name to add to a text file which lists all custom wallpapers)
>>>>>>> 6d0c079 (MAJOR UPDATE)
        shift;
        if [[ $2 == *"https"* ]] && [[ $2 == *".jpg"* || $2 == *".jpeg"* || $2 == *".png"* ]]; then   #Will only accept URLs with https and valid image file extensions
          if [[  ${WallpaperList[@]} != *"$2"* ]]; then					                                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
            feh $2 -E 128 -y 128								                                                      #Show the new wallpaper in a -E (height) 128 px and -y (width) 128 px (yes they made -y be width)
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O "$2" ; cd -; }                      #Downloads the URL image to the pizza-papers directory
            echo "$2" >> /home/$user/Documents/pizzapapers.txt
          else
            echo "That wallpaper is already in your list of wallpapers"
          fi
        elif [[ $2 != "" ]]; then
          echo -e "\nInvalid download link, make sure your URL is valid:\n  Usage:  $ProgName --add https-------------.image_extention   (specifically: *.png, *.jpg, and *.jpeg)\n"
        else
          AddWallpaper
        fi
        exit;;
    --select)				        #Lets the user select one of their custom wallpapers in a numbered list along with displaying the choice's names)
        shift;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
          echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add OR $ProgName --sample\n"
          exit;
=======
        if [[ $(echo "WantCLI" | GetSettings) == "0" ]]; then #If the user chose to have a CLI instead of GUI in settings, it will do that instead
=======
        if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
          echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add\n"
          exit;
        fi
        re='^[0-9]+$'
        if [[ $2 =~ $re ]] && [[ $2 -lt $((${#WallpaperList[@]}+1)) ]]; then	#Checks to see that the users second argument is a number (if there even IS and argument)
          INFILE=/home/$user/Documents/pizzapapers.txt
          echo "$(basename ${WallpaperList[$2-1]}) is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($2-1)) ]}
          gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($2-1)) ]}
        elif [[ $(echo "WantCLI" | GetSettings) == "0" ]]; then #If the user chose to have a CLI instead of GUI in settings, it will do that instead
<<<<<<< HEAD
>>>>>>> 4d4fc3f (New Settings)
          if test -e /home/$user/Pictures/pizza-papers/; then
            touch TEMPLIST.txt
            feh -t /home/$user/Pictures/pizza-papers/ -E 256 -y 216 --action 'echo %n >> ./TEMPLIST.txt'  #Opens a feh GUI in "thumbnail" mode so that that user can select a wallpaper from their list that they can see/select from
            FirstImage=$(head -n 1 ./TEMPLIST.txt)
            if [[ $FirstImage == "" ]]; then
              echo "You did not select an image"
            else
              echo "$FirstImage is now your desktop wallpaper"
              gsettings set org.gnome.desktop.background picture-uri-dark /home/$user/Pictures/pizza-papers/$FirstImage
              gsettings set org.gnome.desktop.background picture-uri /home/$user/Pictures/pizza-papers/$FirstImage
            fi
            rm ./TEMPLIST.txt
            exit;
          else
            echo "You do not have any custom wallpapers"
            exit;
          fi
<<<<<<< HEAD
>>>>>>> 6d0c079 (MAJOR UPDATE)
        fi
        re='^[0-9]+$'
        if [[ $2 =~ $re ]] && [[ $2 -lt $((${#WallpaperList[@]}+1)) ]]; then	#Checks to see that the users second argument is a number (if there even IS and argument)
          INFILE=/home/$user/Documents/pizzapapers.txt
          echo "$(basename ${WallpaperList[$2-1]}) is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($2-1)) ]}
          gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($2-1)) ]}
<<<<<<< HEAD
        elif [[ $(echo "WantCLI" | GetSettings) == "0" ]]; then #If the user chose to have a CLI instead of GUI in settings, it will do that instead
          GUISelectWallpaper
=======
        re='^[0-9]+$'
        if [[ $2 =~ $re ]]; then	#Checks to see that the users second argument is a number (if there even IS and argument)
          INFILE=/home/$user/Documents/pizzapapers.txt
<<<<<<< HEAD
          SelectionArray=()
          for LINE in $(cat "$INFILE"); do
            Picture="$(basename $LINE)"
            SelectionArray+=($LINE)
          done
          echo "${SelectionArray[ (($2-1)) ]} is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${SelectionArray[ (($2-1)) ]}
>>>>>>> 4657cf0 (Removed clutter and fixed user options)
=======
          echo "$(basename ${WallpaperList[$2-1]}) is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($2-1)) ]}
>>>>>>> 3a0bfea (Major update)
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
>>>>>>> 4d4fc3f (New Settings)
=======
          GUISelectWallpaper
>>>>>>> e945341 (Added redundancy)
        else
          SelectWallpaper
        fi
        exit;;
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
    --remove)               #Opens a feh GUI in "thumbnail" mode so that that user can delete selected wallpapers in /Pictures/pizza-papers/ directory)
        shift;
        RemoveWallpaper
        exit;;
    --sample)               #Downloads 4 example image files for the user to be able to use)
<<<<<<< HEAD
        shift;
        echo -e ""
        if [[ $2 == *"remove"* ]]; then       #Lets the user delete the sample wallpapers in case they want to
          if test -f /home/$user/Pictures/pizza-papers/TRAINS.jpg; then
            echo -e "Deleted sample wallpapers\n"
            rm /home/$user/Pictures/pizza-papers/mountains.jpg
            rm /home/$user/Pictures/pizza-papers/astolfo.jpg
            rm /home/$user/Pictures/pizza-papers/sunglasses.jpeg
            rm /home/$user/Pictures/pizza-papers/TRAINS.jpg
            FallbackWallpaper
          else
            echo -e "\nYou do not have any of the sample wallpapers downloaded\n"
          fi
          exit;
        fi
        if [[ ! $2 == *"y"* ]]; then      #Ineffecient way of auto selecting yes, but whatever
          read -p "This will add 4 image files to your /Pictures/pizza-papers directory, do you still want to continue? [y/N]: " uinput
        fi
        if [[ $uinput == *"y"* || $2 == *"y"* ]]; then
        #Requests images from different website links (they are extracted in incoherant names)
          urls="https://images.unsplash.com/photo-1510711789248-087061cda288?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D https://images4.alphacoders.com/906/thumb-1920-906149.png https://images.wallpaperscraft.com/image/single/train_railway_forest_169685_1920x1080.jpg"
          for links in $urls; do
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $links ; cd -; }
          done
          #This part will make them readable (and in the case of sunglasses, usable), they are in order of links above
          mv /home/$user/Pictures/pizza-papers/photo-1510711789248-087061cda288 /home/$user/Pictures/pizza-papers/mountains.jpg
          mv /home/$user/Pictures/pizza-papers/photo-1473496169904-658ba7c44d8a /home/$user/Pictures/pizza-papers/sunglasses.jpeg #There was no image extension so I had to add it to make it work
          mv /home/$user/Pictures/pizza-papers/thumb-1920-906149.png /home/$user/Pictures/pizza-papers/astolfo.jpg
          if [ $? -ne 0 ]; then #Makes sure that the train wallpaper is still in the pizza-papers dir as a sign that the user still has all sample wallpapers
            echo -e "\nThird download failed; Make sure you are not on school wifi"
          fi
          mv /home/$user/Pictures/pizza-papers/train_railway_forest_169685_1920x1080.jpg /home/$user/Pictures/pizza-papers/TRAINS.jpg
          #Will add the sample wallpapers to pizzapapers.txt so they can be selected in the selection interface
          if [[  ${WallpaperList[@]} != *"mountains.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/mountains.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"astolfo.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/astolfo.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"sunglasses.jpeg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/sunglasses.jpeg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"TRAINS.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/TRAINS.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
        else
          echo "Exiting"
        fi
        exit;;
    --settings)             #Will allow the user to change their settings for a more personal selection format)
        shift;
        echo "Default functions: (1: LessHelp, 2: MoreHelp, 3: AddWallpaper, 4: SelectWallpaper)"
        Settings
        exit;;
    --rotate)
        shift;
        if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
          echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add OR $ProgName --sample\n"
          exit;
        fi
        re="^[0-9]*.[0-9]*$"
        if [[ $2 =~ $re ]]; then
          ROTATION_SPEED=$2
        fi
        if [[ $3 == *"y"* ]]; then
          FagFlag=(true)
        else
          FagFlag=(false)
        fi
        echo $3
        echo $FagFlag
        RotateWallpaper
        exit;;
=======
    --feature)              #Downloads 4 example image files for the user to be able to use)
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
        shift;
        echo -e ""
        if [[ $2 == *"remove"* ]]; then       #Lets the user delete the sample wallpapers in case they want to
          if test -f /home/$user/Pictures/pizza-papers/TRAINS.jpg; then
            echo -e "Deleted sample wallpapers\n"
            rm /home/$user/Pictures/pizza-papers/mountains.jpg
            rm /home/$user/Pictures/pizza-papers/astolfo.jpg
            rm /home/$user/Pictures/pizza-papers/sunglasses.jpeg
            rm /home/$user/Pictures/pizza-papers/TRAINS.jpg
            FallbackWallpaper
          else
            echo -e "\nYou do not have any of the sample wallpapers downloaded\n"
          fi
          exit;
        fi
        if [[ ! $2 == *"y"* ]]; then      #Ineffecient way of auto selecting yes, but whatever
          read -p "This will add 4 image files to your /Pictures/pizza-papers directory, do you still want to continue? [y/N]: " uinput
        fi
        if [[ $uinput == *"y"* || $2 == *"y"* ]]; then
        #Requests images from different website links (they are extracted in incoherant names)
          urls="https://i.etsystatic.com/43678560/r/il/e318c5/5095674952/il_1140xN.5095674952_4itq.jpg https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D https://scontent-sjc3-1.xx.fbcdn.net/v/t1.6435-9/50703090_1022241357960569_4488694694989004800_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=2285d6&_nc_ohc=FQmA5AvhfWgQ7kNvgGAGI9B&_nc_zt=23&_nc_ht=scontent-sjc3-1.xx&_nc_gid=AoJ6F11aMxPxT55pFB6pABH&oh=00_AYDhLj9seoSCsewoSTppZUn0C7pljtw-GxJV_a4xbSdl5A&oe=677C98AC https://images.wallpaperscraft.com/image/single/train_railway_forest_169685_1920x1080.jpg"
          for links in $urls; do
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $links ; cd -; }
          done
          #This part will make them readable (and in the case of sunglasses, usable), they are in order of links above
          mv /home/$user/Pictures/pizza-papers/il_1140xN.5095674952_4itq.jpg /home/$user/Pictures/pizza-papers/mountains.jpg
          mv /home/$user/Pictures/pizza-papers/photo-1473496169904-658ba7c44d8a /home/$user/Pictures/pizza-papers/sunglasses.jpeg #There was no image extension so I had to add it to make it work
          mv /home/$user/Pictures/pizza-papers/50703090_1022241357960569_4488694694989004800_n.jpg /home/$user/Pictures/pizza-papers/astolfo.jpg
          if [ $? -ne 0 ]; then #Makes sure that the train wallpaper is still in the pizza-papers dir as a sign that the user still has all sample wallpapers
            echo -e "\nThird download failed; Make sure you are not on school wifi"
          fi
          mv /home/$user/Pictures/pizza-papers/train_railway_forest_169685_1920x1080.jpg /home/$user/Pictures/pizza-papers/TRAINS.jpg
          #Will add the sample wallpapers to pizzapapers.txt so they can be selected in the selection interface
          if [[  ${WallpaperList[@]} != *"mountains.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/mountains.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"astolfo.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/astolfo.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"sunglasses.jpeg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/sunglasses.jpeg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
          if [[  ${WallpaperList[@]} != *"TRAINS.jpg"* ]]; then	
            echo "/home/$user/Pictures/pizza-papers/TRAINS.jpg" >> /home/$user/Documents/pizzapapers.txt   #If there is not already this sample image name put into the wallpaper list, it will add it
          fi
        else
          echo "Exiting"
        fi
        exit;;
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 3a0bfea (Major update)
=======
    --settings)
=======
    --settings)             #Will allow the user to change their settings for a more personal selection format)
>>>>>>> e945341 (Added redundancy)
        shift;
        echo "Default functions: (1: LessHelp, 2: MoreHelp, 3: AddWallpaper, 4: SelectWallpaper)"
        Settings
        exit;;
<<<<<<< HEAD
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
    --rotate)
        shift;
        RotateWallpaper
        exit;;
>>>>>>> 61b68b7 (Added wallpaper rotation)
    --help)				          #Will activate when pizzapaper --help is used, the BETTER option for getting info)
        shift;	            #I don't know why shift is used tbh, but I'm afraid it will break if I remove it
        Help_Options
        exit;;
    --version)              #Will display current version)
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

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> e945341 (Added redundancy)

#I am the one and only
if $IAMGOD; then
  echo -e "Dev commands:\n"
  echo "./path-partner --retard.............Resets all pizza-paper files and directories"
  echo "./path-partner --copy...............Can be used to add -a and remove -r pizzapaper-testing to PATH"
<<<<<<< HEAD
fi


#Will decide what function will be used when the user only does "./pizza-paper.sh" or "pizzapaper", the default is Less_Help
DefaultFunction=$(echo "Default" | GetSettings) #Will pipe (insert) a string containing "Default" into the GetSettings function, which will identify the string and return a certain value as a variable
case "$DefaultFunction" in                      #case will check to see if $DefaultFunction fits the same value of any of the options
=======
=======
#I am the one and only
>>>>>>> 4d4fc3f (New Settings)
if $IAMGOD; then
  echo -e "Dev commands:\n"
  echo "./path-partner --retard"
  echo "./path-partner --copy"
  echo "./pizzapaper_testing.sh --normal"
=======
>>>>>>> 61b68b7 (Added wallpaper rotation)
fi


#Will decide what function will be used when the user only does "./pizza-paper.sh" or "pizzapaper", the default is Less_Help
DefaultFunction=$(echo "Default" | GetSettings) #Will pipe (insert) a string containing "Default" into the GetSettings function, which will identify the string and return a certain value as a variable
<<<<<<< HEAD
case "$DefaultFunction" in  #case will check to see if $DefaultFunction fits the same value of any of the options
>>>>>>> 6d0c079 (MAJOR UPDATE)
=======
case "$DefaultFunction" in                      #case will check to see if $DefaultFunction fits the same value of any of the options
>>>>>>> e945341 (Added redundancy)
    1)
        Less_Help
        exit;;
    2)
        Help_Options
        exit;;
    3)
        AddWallpaper
        exit;;
    4)
        SelectWallpaper
        exit;;
esac
<<<<<<< HEAD
=======
Less_Help   #Will run when the user does not provide an argument to give them options
>>>>>>> 3a0bfea (Major update)
=======
>>>>>>> 6d0c079 (MAJOR UPDATE)
