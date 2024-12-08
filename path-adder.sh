#Can be used to copy pizza-paper.sh to one of your PATH folders, mainly so that you don't have to be in a specific directory to use it and I don't like it ending with .sh (github requires it)
#YOU DO NOT NEED TO RUN THIS, IT IS COMPLETELY **OPTIONAL** AND IS ONLY FOR MILD CONVENIENCE

RemoveFile (){
  if test -f /usr/local/bin/pizzapaper; then		#If pizzapaper is found in the path file, then it will delete it
    rm /usr/local/bin/pizzapaper
  else
    echo "pizzapaper was not found in that directory, it may have already been removed"
  fi
}

AddFile (){
  if ! test -f /usr/local/bin/pizzapaper; then		#If pizzapaper is NOT found in the path file, it will add it
    if test -f */pizzapaper; then
      cp ./pizza-paper.sh /usr/local/bin/pizzapaper
    else
      cp ./pizzapaper_testing.sh /usr/local/bin/pizzapaper
    fi
  else
    echo "pizzapaper is already in the path directory: /usr/local/bin/"
  fi
}
options=$(getopt -o ar,add,remove --long "add,remove" -- "$@")
[ $? -eq 0 ] || { 
    echo "Incorrect options provided"
    exit 1
}
eval set -- "$options"
while true; do
    case "$1" in
      -a)
         AddFile
         exit;;
      -r)
         RemoveFile
         exit;;
      \?)				#Doesn't fucking work for some reason, its supposed to detect gibberish like "-klaneofbaog")
         echo "Invalid option"
         exit;;
    --add)
        shift;
        AddFile
        exit;;
    --remove)
        shift;
        RemoveFile
        exit;;
    --)					#No idea whatsoever, I don't want to remove it though)
        shift
        break
        ;;
    esac
    shift
done

echo -e "\nThis lets you add or remove the pizza-paper.sh file to your \$PATH folder, specifically the /usr/local/bin/ folder (which is generally empty so it's easy to find)"
echo -e "To run this file, you have to provide an argument as either\n"
echo -e " ./pizza_path_partner -add   		Add the pizza-paper.sh file to /usr/local/bin/ to be able to execute it as \"pizzapaper [ARG]\" instead"
echo -e " ./pizza_path_partner -remove		Removes the pizzapaper file from your \$PATH folder\n"
echo -e "Make sure you are doing this in sudo, as it was made to modify your machine folders which are locked behind admin perms"
