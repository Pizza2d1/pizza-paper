#This is my own little thing that I made to switch up desktop wallpapers, it sucks but I think it works best for me
#To get instructions on how to run this you can just execute it or look on github for "How to use"

VERSION=$"pizzapaper 1.2.2"	          			#Tells the user the version
user=$(whoami)							                #Gets the username of the person calling the program so that it only affects that user's desktop
WallpaperList=()						                #Needed so that that user can have custom wallpapers
PAPERS=/home/$user/Documents/pizzapapers.txt
for LINE in $(cat "$PAPERS"); do
  WallpaperList+=($LINE)
done                   
#I like these ones better ^^^^^ so they get to be at the top

#Necessary checks needed for redundancy and being more user-friendly
if [ -d "/home/pizza2d1" ]; then				                                              #I AM THE ADMIN I GET SPECIAL PRIVILEGES BITCHES
  IAMGOD=true
else
  IAMGOD=false
fi
if [ -f /usr/local/bin/pizzapaper ]; then			                                        #ProgName will be used to swap between "pizza-paper.sh" and "pizzapaper" depending on what the user has installed for convenience
  ProgName="pizzapaper"                             
elif [ -f ./pizza-paper.sh ]; then
  ProgName="./pizza-paper.sh"
fi
if [ -f /home/$user/Pictures/pizza-papers/TRAINS.jpg ]; then                          #Checks to see if the user decided to download the included wallpapers (pizzapaper --feature)
  ShortHelpFlag="|m|a|s|t"                                                            #Will display sample wallpaper options if the user has them downloaded
  SampleWallpaperStatus=""                                                            #Will NOT say something if the user has sample images
  YesYouHaveIt="(If you would like to delete them, use \"--sample remove\")"          #Will tell the user if they have the sample images if it detects them
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
if [ ! -d "/home/$user/Pictures" ]; then                              #Makes a Pictures directory in case you are a little weird idiot that feels like they're better than everyone else, along with making a directory for custom wallpapers
  echo "wtf why don't you have a Pictures folder, making one now to store your custom wallpapers..."
  mkdir /home/$user/Pictures
fi
if [ ! -d "/home/$user/Pictures/pizza-papers" ]; then                 #Will make a pizzapapers directory that will store you custom wallpapers
  mkdir /home/$user/Pictures/pizza-papers
fi
if [ ! -f "/home/$user/Pictures/pizza-papers/settings.log" ]; then    #Creates a settings.log file if the user does not have it to store settings such as "show cli" or "open with selector"
  touch /home/$user/Pictures/pizza-papers/settings.log
  echo "Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
  echo "Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
fi
###########################################


#Main functions
function Less_Help (){			                  #Runs when there are no arguments and whent the user inputs "pizzapaper -h"
  echo -e "\nPick which argument you want to use with \"$ProgName [-h$ShortHelpFlag | --help|add|select|sample|remove|settings|version]\"\n (The --help option may be more helpful)\n"
  if [[ ! $ProgName == *"pizzapaper"* ]]; then
    echo -e "OPTIONAL:"
    echo -e "   If you would like to run the program as \"pizzapaper [ARG]\" (as I recommend) you will have to run \"sudo ./pizza_path_partner -add\" to add pizzapaper to your \$PATH files"
    echo -e "   To remove the pizzapaper file in your \$PATH directory, use \"sudo path-adder.sh -remove\" OR \"sudo rm /usr/local/bin/pizzapaper\""
    echo -e "   After you run it, you can delete pizza-paper.sh :3\n"
  fi
}

function Help_Options (){		                  #Gives the user instructions on how to use the program
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
  echo -e "  --version           Echos the current $ProgName version\n"
  echo -e "  --help              Will display this, a much more detailed explanation on how to use this program and its arguments\n\n"
}

function AddWallpaper (){                     #Will let the user add a wallpaper from their computer files
  echo -e "How would you like to add your custom wallpaper?:\n"
  echo -e "  1. File selection        Will add a wallpaper from your local computer storage"
  echo -e "  2. Web image URL         Will take a image URL and download it to your /Pictures/pizza-papers/ directory\n"
  read -p "[1/2]: " uinput
  if [[ $uinput == "1" || $uinput == *"ile"* ]]; then                                   #Checks to see if the user chose 1 or file/File
    echo "Select which file(s) you would like to add"                                   #Yes, you can select multiple files
    Files=$(zenity --file-selection --multiple)                                         #Opens file selection to choose image files
    IFS='|'                                                                             #Sets the splice modifier so that "read -ra" splits the $Files string after every "|"
    read -ra IndividualImages <<< "$Files" #Appends each file name into an array name IndividualImages
    for fileL in "${IndividualImages[@]}"; do   #For each image that the user selected...
      if [[ $fileL == *".jpg"* || $fileL == *".jpeg"* || $fileL == *".png"* ]]; then  #Will only accept URLs with https and valid image file extensions
        if [[  ${WallpaperList[@]} != *"$fileL"* ]]; then					                      #Checks to make sure that PART of $fileL is nowhere in the WallpaperList array
          echo "$fileL" >> /home/$user/Documents/pizzapapers.txt
          cp $fileL /home/$user/Pictures/pizza-papers/                                  #Copies wallpaper file to pizza-papers so it can be selected in gui
          echo "$(basename $fileL) has been added to your wallpapers"
        else
          echo "That wallpaper is already in your list of wallpapers"
        fi
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
      else
        echo "That wallpaper is already in your list of wallpapers"
      fi
    elif [[ $URL == "" ]]; then
      echo "No link provided, exiting"
    else
      echo -e "Invalid link, make sure it contains an image extension type, E.G. \"IMAGE-NAME.[png | jpg | jpeg]\""  
    fi
  else
    echo -e "\nInvalid input\n"
  fi
}

function SelectWallpaper (){								  #The user chooses a wallpaper that they they have stored in a directory that they added using AddWallpaper
  if [[ $WallpaperList == "" ]]; then           #Will check to make sure that the user has entered any wallpapers yet
    echo -e "\nYou do not have any custom wallpapers, you can add some buy using $ProgName --add\n"
    exit;
  fi
  echo -e "\n  0   Remove A Wallpaper"							  #A new option that will be made useful later to remove custom wallpapers from the list #########################
  Num=1
  for LINE in ${WallpaperList[@]}; do           #A loop that encompasses ALL items in the WallpaperList array
    ImageName="$(basename $LINE)"               #Takes the substring value of the image by removing the parent directories from the string
    echo "  $Num   $ImageName"								  #Displays the wallpaper FILE name and its number selection choice
    ((Num+=1))
  done
  echo "" #Just a spacer
  read -p "Which wallpaper would you like to choose?: " uinput				#Has the user input a selection in the terminal #REFERENCE#
  re='^[0-9]+$'
  if [[ $uinput == "0" ]]; then                 #Will check that the user wanted to delete a wallpaper
    echo -e "\n  0   Exit"
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
  if [[ $uinput =~ $re ]]; then								#Checks to see that the user's input is a number
    echo "$(basename ${WallpaperList[$uinput-1]}) is now your new wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($uinput-1)) ]}
    gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($uinput-1)) ]}
  else
    echo "Invalid input"
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
      read -p "Are you sure you want to delete $SingleImage? [y/N]: " UserConfimation  #If the user selects a wallpaper, it will ask for confirmation that they want to delete it and store the input as $UserConfirmation
      if [[ $UserConfimation == *"y"* ]]; then
        rm /home/$user/Pictures/pizza-papers/$SingleImage
        echo "Deleted $SingleImage"
      else
        echo "Did not delete $SingleImage"
      fi
    done
    rm ./TEMPLIST.txt
    exit;
  else
    echo "You do not have any custom wallpapers"
    exit;
  fi
}

function Settings (){                        #Will allow the user to change settings in the CLI to let them determine default function that runs when the user does not provide an argument (current: LessHelp)
  #read uinput   #Takes the argument the user inputted and makes it a variable called uinput
  DisplayCurrentDefault
  GetSettings
  echo "" #adds a spacer
  read -p "What setting do you want to change? [1/2]: " uinput
  while [[ $uinput != "" ]]; do
    if [[ $uinput == "1" ]]; then
      Setting1
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    elif [[ $uinput == "2" ]]; then
      Setting2
      DisplayCurrentDefault
      GetSettings
      echo "" #adds a spacer
    else
      echo "Invalid input"
      exit
    fi
    read -p "What setting do you want to change? [1/2]: " uinput
  done
  echo "Exiting"
  exit;

}
##########################################


#Smaller functions that are only for clean code and ease of development
function GetSettings() {  #Super annoying, I had to look up quite a bit just to figure it out
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
    while read -r LINE; do
      printf "%s\n" "${LINE:0:24}" #{parameter:startingposition:offset}  Variable name, starts at 0, how many letters you want to encompass/read
    done < $EchoSettings    #Will use the settings.log file as the input for the read -r operation
    return
  fi

  read PipedValue #Since there WAS a piped value we can read it without the program getting softlocked and get a return value :3
  if [[ $PipedValue == "WantCLI" ]]; then
    echo ${SettingsArray[0]}
  elif [[ $PipedValue == "Default" ]]; then
    echo ${SettingsArray[1]}
  else
    echo "How did this happen"
  fi
}
function Setting1 (){     #Will change the value of the first setting as a bit value 0/1
  SETTING_NUMBER=1 #Use this to determine what setting is being changed

  SettingsArray=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsArray+=($LINE)
    fi
  done
  SettingValue=${SettingsArray[ (($SETTING_NUMBER-1)) ]}
  if [[ $SettingValue == "1" ]]; then
    echo "Enable CLI Selection:  0     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
    echo "Default Function:      ${SettingsArray[1]}     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  else
    echo "Enable CLI Selection:  1     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
    echo "Default Function:      ${SettingsArray[1]}     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  fi
}
function Setting2 (){     #Will change the value as an iterable value 1>2>3>4>1>2>3>4...
  SETTING_NUMBER=2 #Use this to determine what setting is being changed

  SettingsArray=()
  re='^[0-9]+$'
  for LINE in $(cat /home/$user/Pictures/pizza-papers/settings.log); do #Gets all number values in settings files (numbers are the data being used)
    if [[ $LINE =~ $re ]]; then
      SettingsArray+=($LINE)
    fi
  done
  SettingValue=${SettingsArray[ (($SETTING_NUMBER-1)) ]}
  if [[ $SettingValue == "4" ]]; then
    echo "Enable CLI Selection:  ${SettingsArray[0]}     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
    echo "Default Function:      1     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  else
    echo "Enable CLI Selection:  ${SettingsArray[0]}     #Lets the user use CLI instead of the default GUI selectors" > /home/$user/Pictures/pizza-papers/settings.log
    echo "Default Function:      $[$SettingValue+1]     #Decides what main function will run when pizza-paper is executed without arguments (LessHelp, Help_Options, AddWallpaper, SelectWallpaper)" >> /home/$user/Pictures/pizza-papers/settings.log
  fi
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
##########################################


#For setting the SAMPLE wallpapers, the user might either have "picture-uri-dark" or "picture-uri" being displayed, so its best to just set both of them.-
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


#Lists the different options that the user can choose from, "hmast" is for individual letters options like "-h" and "-m"
options=$(getopt -o hmast,help,mountain,astolfo,sunglasses,train --long "add,select,remove,sample,settings,help,version" -- "$@")
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
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
         exit;;
      -s | -sunglasses)     #Will make the desktop background some sunglasses)
         if $WallpaperAccess; then
           Sunglasses_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      -t | -train)          #Will make the desktop background a picture of a train)
         if $WallpaperAccess; then
           Trains_Wallpaper
         else
           echo -e "You must run \"$ProgName --sample\" to download these files"
         fi
         exit;;
      \?)                   #Does something, I don't know what, but if I remove it then it breaks so I'll keep it around)
         echo "Invalid option"
         exit;;
    --add)                  #Has the user select a image file's name to add to a text file which lists all custom wallpapers)
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
        if [[ $(echo "WantCLI" | GetSettings) == "0" ]]; then #If the user chose to have a CLI instead of GUI in settings, it will do that instead
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
        fi
        re='^[0-9]+$'
        if [[ $2 =~ $re ]]; then	#Checks to see that the users second argument is a number (if there even IS and argument)
          INFILE=/home/$user/Documents/pizzapapers.txt
          echo "$(basename ${WallpaperList[$2-1]}) is now your new wallpaper"
          gsettings set org.gnome.desktop.background picture-uri-dark ${WallpaperList[ (($2-1)) ]}
          gsettings set org.gnome.desktop.background picture-uri ${WallpaperList[ (($2-1)) ]}
        else
          SelectWallpaper
        fi
        exit;;
    --remove)               #Opens a feh GUI in "thumbnail" mode so that that user can delete selected wallpapers in /Pictures/pizza-papers/ directory)
        shift;
        RemoveWallpaper
        exit;;
    --sample)               #Downloads 4 example image files for the user to be able to use)
        shift;
        echo -e ""
        if [[ $2 == *"remove"* ]]; then       #Lets the user delete the sample wallpapers in case they want to
          if test -f /home/$user/Pictures/pizza-papers/TRAINS.jpg; then
            echo -e "Deleted sample wallpapers\n"
            rm /home/$user/Pictures/pizza-papers/mountains.jpg
            rm /home/$user/Pictures/pizza-papers/astolfo.jpg
            rm /home/$user/Pictures/pizza-papers/sunglasses.jpeg
            rm /home/$user/Pictures/pizza-papers/TRAINS.jpg
          else
            echo -e "\nYou do not have any of the sample wallpapers downloaded\n"
          fi
          exit;
        fi
        read -p "This will add 4 image files to your /Pictures/pizza-papers directory, do you still want to continue? [y/N]: " uinput
        if [[ $uinput == *"y"* ]]; then
        #Requests images from different website links (they are extracted in incoherant names)
          urls="https://i.etsystatic.com/43678560/r/il/e318c5/5095674952/il_1140xN.5095674952_4itq.jpg https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D https://scontent-sjc3-1.xx.fbcdn.net/v/t1.6435-9/50703090_1022241357960569_4488694694989004800_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=2285d6&_nc_ohc=FQmA5AvhfWgQ7kNvgGAGI9B&_nc_zt=23&_nc_ht=scontent-sjc3-1.xx&_nc_gid=AoJ6F11aMxPxT55pFB6pABH&oh=00_AYDhLj9seoSCsewoSTppZUn0C7pljtw-GxJV_a4xbSdl5A&oe=677C98AC https://images.wallpaperscraft.com/image/single/train_railway_forest_169685_1920x1080.jpg"
          for links in $urls; do
            cd /home/pizza2d1/Pictures/pizza-papers/ && { curl -O $links ; cd -; }
          done
          #This part will make them readable (and in the case of sunglasses, usable), they are in order of links above
          mv /home/$user/Pictures/pizza-papers/il_1140xN.5095674952_4itq.jpg /home/$user/Pictures/pizza-papers/mountains.jpg
          mv /home/$user/Pictures/pizza-papers/photo-1473496169904-658ba7c44d8a /home/$user/Pictures/pizza-papers/sunglasses.jpeg #There was no image extension so I had to add it to make it work
          mv /home/$user/Pictures/pizza-papers/50703090_1022241357960569_4488694694989004800_n.jpg /home/$user/Pictures/pizza-papers/astolfo.jpg
          mv /home/$user/Pictures/pizza-papers/train_railway_forest_169685_1920x1080.jpg /home/$user/Pictures/pizza-papers/TRAINS.jpg
          #############################################################################################SETTINGS
        else
          echo "Exiting"
        fi
        exit;;
    --settings)
        shift;
        echo "Default functions: (1: LessHelp, 2: MoreHelp, 3: AddWallpaper, 4: SelectWallpaper)"
        Settings
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

if $IAMGOD; then
  echo -e "Dev commands:\n"
  echo "./path-partner --retard"
fi

#Will decide what function will be used when the user only does "./pizza-paper.sh" or "pizzapaper", the default is Less_Help
DefaultFunction=$(echo "Default" | GetSettings) #Will pipe (insert) a string containing "Default" into the GetSettings function, which will identify the string and return a certain value as a variable
case "$DefaultFunction" in  #case will check to see if $DefaultFunction fits the same value of any of the options
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
