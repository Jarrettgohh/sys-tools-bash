#!/bin/bash



###################### PURPOSE OF THIS SCRIPT #################################
# To convert bit import statements from dev to prod 
###############################################################################

#######################################################
# [[:space:]] matches an empty space; [a-zA-Z] matches all the alphabets, both upper and lowercase
# within the \{ \} ({}) match, with escape char (\); there are 4 test cases
# 1. [a-zA-Z]
# 2. [[:space:]]
# 3. ,
# 4. \n
# even though the dot char (.) can match all of these (except \n), essentially allowing (.|\n) to be used instead. But its not used as it causes greedy searching which can give segmentation faults (unlimited loops that causes the engine that searches using the regex to flow out of memory); so its better to limit the test cases to prevent over-matching

# after the plus (+) symbol, which are used to match a pattern one or more times, a question mark symbol (?) is used to prevent greedy matching
#######################################################


find_regex=""
replace_str=""
print_files_only=false

base_path_to_WSL_filesystem=/mnt/c/Users/gohja/Desktop
sub_path_dir=""



# &> syntax is used to redirect all stdout and stderr to a file
# /dev/null is a null device file that discards anything written to it
# &> /dev/null is used to redirect all stdout and stderr to a null device file - basically just throws all output to a 'vacuum' that discards anything written to it

script_dir=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
path_to_folders_data="${script_dir}/folders_data.txt"



##################
# Updating of folders array - to be read from `folders_data.txt`
##################

IFS=$'\r\n'; command; eval "FOLDERS_DATA=($(cat "$path_to_folders_data"))"

for folder in "${FOLDERS_DATA[@]}";
do
 folders+=($folder) 
done

while getopts 'f:r:b:s:p' OPTION; do
  case "$OPTION" in
    f) 
    find_regex=$OPTARG
    ;;
    r)
    replace_str=$OPTARG
    ;;
    b)
    # the argument passed in to the -b flag will be stored by default in $OPTARG
    base_path_to_WSL_filesystem="$OPTARG"
    ;;
    s)
    # the argument passed in to the -s flag will be stored by default in $OPTARG
    sub_path_dir="$OPTARG"
    ;;
    p)
    print_files_only=true
    ;;
    ?)
      echo "script usage: "$0" [-d] [-p] [-f]" >&2 # >&2 means output stdout to stderr
      exit 1
      ;;
    h)
     printf "\n [-f] Regex pattern for string to find"
     printf "\n [-r] Replace pattern for found string"
     printf "\n [-p] To only print the files found by the [-f] regex pattern, without replacing found string with the [-r] string specified"
     printf "\n [-b] To specify the base directory to run this script on; default would be: "$base_path_to_WSL_filesystem""
     printf "\n [-s] To specify the sub directory; default would be: "$sub_path_dir""
     printf "\n [-h] prints help message"
     printf "\n\n"
     ;;
  esac
done


# If the [-p] flag is NOT set (print files only), require the [-r] flag (replace_str) to be set

if [[ "$print_files_only" = false  && -z "$replace_str"  ]];
  then 
      printf '\n------------------------- ERROR ---------------------------------\n'
      printf '\nAs the [-p] flag is not provided, the [-r] flag needs to be set.\n'
      printf '\n-----------------------------------------------------------------\n\n'
      exit 1
  fi


# -z operator checks if the variable is unset
if [ -z "$folders" ] || [ -z "$find_regex" ];
 then 
  printf '\n------------------------- ERROR ---------------------------------\n'
  printf '\nThere is an error with either:'
  printf '\n-----------------------------------------------------------------\n'
  printf "1. -f flag is not provided\n"
  printf "2. \"folders_data.txt\" file is empty\n\n"
  exit 1;
fi


for folder in ${folders[@]}; do

  final_dir="${base_path_to_WSL_filesystem}${sub_path_dir}${folder}"


  if [ "$print_files_only" = true ] ; 

  then
   printf '\n\n--------------------------------------\n\n'
   printf 'Printing files under folder dir: '$folder''
   printf '\n\n--------------------------------------\n\n'

  else
   printf '\n\n--------------------------------------\n\n'
   printf 'Processing files under folder dir: '$folder''
   printf '\n\n--------------------------------------\n\n'

  fi
  
  ####################################
  # Command to find all the files that contains text that matches the string pattern, and outputs the directories along with the pattern

  # pcregrep with -M flag allows multiline searching
  # -r flag is recursive search and -l flag is print only file names
  ####################################

#  { dirs="$(pcregrep -M -rl $full_find $final_dir &> /dev/null)"; } || { printf "\n\nDirectory not found, check the folders data defined in "$path_to_folders_data"\n\n"; continue; }

 dirs="$(pcregrep -M -rl $find_regex $final_dir)"


  #####################################
  # use the transform (tr) command along with the delete flag (-d) -- removes spaces, nextline, tabs, etc.
  #####################################
  # dirs="$(tr -d '[:space:]' <<< "$dirs")"  


  # # Set the IFS (Internal Field Separator) to be a semicolon (;) instead: https://www.baeldung.com/linux/ifs-shell-variable
  # # this is needed because the $dir_imports (from the `grep` command with the -r flag) string separates each item with a semicolon
  # IFS=';'

  for dir in $dirs
   do 

   # # setting the lastpipe option would make the last part of the pipeline run in the current environment
   # # `shopt` is used to update the settings of the shell terminal
   #  shopt -s lastpipe

   #  # removes the semicolon (:) and extracts the dir
   #  echo $dir_import | grep -E -o ".*:" | { read data && dir="$(sed -E 's|':'||' <<< $data)"; } 

   #  # # removes the semicolon (:) and extracts the import statement
   #  # echo $dir_import | grep -E -o ":.*" | { read data && import="$(sed -E 's|':'||' <<< $data)"; }
   #  grep -E -o "\{.*\}" <<< $dir_import | { read data && data="$(sed -E 's|\{|{ |' <<< $data)" && data="$(sed -E 's|\}| }|' <<< $data)" && import_replace="$(sed -E 's|_|'$data'|' <<< $replace)"; }

 

    if [ "$print_files_only" = true ] ; then
       printf "$dir\n"
       continue
    fi


   ################# LOGGING ####################
    printf "Processing file at directory:  "$dir"\n"
   ##############################################

   
    # command to update the file according to the directory given in $dir
    sed -i -E "s|"$find_regex"|"$replace_str"|" $dir
  
  done

  printf "\n\n"
 
done




########################## END OF FILE -- FURTHER BELOW ARE NOTES #################################################   


########################################################################
# run the `sed` command to edit the files
# the `-i` flag indicates to edit the file rather than just outputting the results
# main syntax for the `sed` command seems to be: (sed "sed s|<find_pattern>|<replace_pattern>|" <path_directory>)

# helpful tip: the seperator used in the `sed` command argument separator; in this case is the vertical bar (|) symbol, can actually be any character, as long as it doesn't conflict with: hash (#) char works too
########################################################################


################################ TO WORK WITH extract_substr.py -- not working as expected #####################
# grep -E $find test.js | python3 extract_substr.py | { read message && sed -i -E "s|${find}|"$message"|" test.js; }
# grep -E $find test.js | python3 extract_substr.py 
#################################################################################################################



###############################################################
# $BASH_REMATCH is the regex matched variable; in an array format
###############################################################
# [[ $text =~ \{.*\} ]] && sed -i -E "s|${find}|${BASH_REMATCH[0]}|" ${}

# sed -i -E "s|${find}|hello|" test.js

# sed -i -E "s|${find}|"import $1 from \"@mapitin/mapitin-library.interfaces\""|" test.js




####################################
# Command to replace a regex pattern with a string
####################################

# sed -i -E "s|${find}|${replace}|g" $final_dir 




