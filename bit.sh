#!/bin/bash


dev_find_regex="import.*\{.+\}.*from.*\"../../../mapitin-interfaces/index\""
dev_replace_str="import _ from \"../../../mapitin-interfaces/index\""

prod_find_regex="import.*\{.+\}.*from.*\"@mapitin/mapitin-library.interfaces\""
prod_replace_str="import _ from \"@mapitin/mapitin-library.interfaces\""

################## PROCESSING OF THE FLAGS ARGS ###############################
# d (dev): development - to change the bit imports to be local
# p (prod): production - to change the bit imports to be production
# f (files) - display the files with string match

while getopts 'dpf' OPTION; do
  case "$OPTION" in
    d) 
      find=$prod_find_regex
      replace=$dev_replace_str
      ;;
    p)
      find=$dev_find_regex
      replace=$prod_replace_str
      ;;
    
    f)
      display_files_only=true
     ;;
    ?)
      echo "script usage: "$0" [-d] [-p] [-f]" >&2 # >&2 means output stdout to stderr
      exit 1
      ;;
  esac
done


path_to_WSL_filesystem=/mnt/c/Users/gohja
path_to_bit_file=Desktop/mapitin-repository/sys/ # to replace in PROD

# combine the two path string variables to one variable
final_dir="${path_to_WSL_filesystem}/${path_to_bit_file}"


local_bit_dir=\"../../../mapitin-interfaces/index\"
cloud_bit_dir=\"@mapitin/mapitin-library.interfaces\"



####################################
# Command to find all the files that contains text that matches the string pattern, and outputs the directories along with the pattern
####################################
dir_imports="$(grep -E -r $find $final_dir)" # save `grep` command output to a variable

#####################################
# use the transform (tr) command along with the delete flag (-d) -- removes spaces, nextline, tabs, etc.
#####################################
dir_imports="$(tr -d '[:space:]' <<< "$dir_imports")"  




if [ "$display_files_only" = true ] ; then
 printf '\n\n############################\n\n'
 printf 'Printing file directories'
 printf '\n\n############################\n\n'
fi

# Set the IFS (Internal Field Separator) to be a semicolon (;) instead: https://www.baeldung.com/linux/ifs-shell-variable
# this is needed because the $dir_imports (from the `grep` command with the -r flag) string separates each item with a semicolon
IFS=';'

for dir_import in $dir_imports
 do 
 

 # setting the lastpipe option would make the last part of the pipeline run in the current environment
 # `shopt` is used to update the settings of the shell terminal
  shopt -s lastpipe

  # removes the semicolon (:) and extracts the dir
  echo $dir_import | grep -E -o ".*:" | { read data && dir="$(sed -E 's|':'||' <<< $data)"; } 

  if [ "$display_files_only" = true ] ; then
     printf "$dir\n"
     continue
  fi


 ################# LOGGING ####################
  printf "Processing file at directory:  "$dir"\n"
 ##############################################


  
  # # removes the semicolon (:) and extracts the import statement
  # echo $dir_import | grep -E -o ":.*" | { read data && import="$(sed -E 's|':'||' <<< $data)"; }
  grep -E -o "\{.*\}" <<< $dir_import | { read data && data="$(sed -E 's|\{|{ |' <<< $data)" && data="$(sed -E 's|\}| }|' <<< $data)" && import_replace="$(sed -E 's|_|'$data'|' <<< $replace)"; }


  # command to update the file according to the directory given in $dir
  sed -i -E "s|"$find"|"$import_replace"|" $dir

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




