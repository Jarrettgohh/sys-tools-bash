#!/bin/bash

path_to_WSL_filesystem=/mnt/c/Users/gohja
path_to_bit_file=Desktop/mapitin-repository/sys # to replace in PROD

# combine the two path string variables to one variable
final_dir="${path_to_WSL_filesystem}/${path_to_bit_file}/test.js"


local_bit_dir=\"../../../mapitin-interfaces/index\"
cloud_bit_dir=\"@mapitin/mapitin-library.interfaces\"


# create the find and replace string 
find="import.*\{.+\}.*from.*\"../../../mapitin-interfaces/index\""
replace="import _ from \"@mapitin/mapitin-library.interfaces\""



########################################################################
# run the `sed` command to edit the files
# the `-i` flag indicates to edit the file rather than just outputting the results
# main syntax for the `sed` command seems to be: (sed "sed s|<find_pattern>|<replace_pattern>|" <path_directory>)

# helpful tip: the seperator used in the `sed` command argument separator; in this case is the vertical bar (|) symbol, can actually be any character, as long as it doesn't conflict with: hash (#) char works too
########################################################################

####################################
# Command to find all the files that contains text that matches the string pattern, and outputs the directories along with the pattern
####################################

dir_imports="$(grep -E -R $find ./)" # save `grep` command output to a variable


################################ TO WORK WITH extract_substr.py -- not working as expected #####################
# grep -E $find test.js | python3 extract_substr.py | { read message && sed -i -E "s|${find}|"$message"|" test.js; }
# grep -E $find test.js | python3 extract_substr.py 
#################################################################################################################


dir_imports="$(tr -d '[:space:]' <<< "$dir_imports")"  

# Set the IFS (Internal Field Separator) to be a semicolon instead: https://www.baeldung.com/linux/ifs-shell-variable
IFS=';'

for dir_import in $dir_imports
 do 
 
  shopt -s lastpipe

  # removes the semicolon (:) and extracts the dir
  echo $dir_import | grep -E -o ".*:" | { read data && dir="$(sed -E 's|':'||' <<< $data)"; } 
  
  # # removes the semicolon (:) and extracts the import statement
  # echo $dir_import | grep -E -o ":.*" | { read data && import="$(sed -E 's|':'||' <<< $data)"; }

  grep -E -o "\{.*\}" <<< $dir_import | { read data && import_replace="$(sed -E 's|_|'$data'|' <<< $replace)"; }

  echo $import_replace
  echo $dir

  # text="import { } from \"@mapitin/mapitin-library.interfaces\""
  # sed -E 's|"\{.*\}"|hello|' <<< $text
 
  # sed -i -E 's|"$import"||' $dir

  # sed -E "s|":"||"  <<< "helo:"
  # grep -E -o "hello" <<< "hello world" 

  # [[ $text =~ \{.*\} ]] && sed -i -E "s|${find}|${BASH_REMATCH[0]}|" ${}
done


###############################################################
# $BASH_REMATCH is the regex matched variable; in an array format
###############################################################


# sed -i -E "s|${find}|hello|" test.js

# sed -i -E "s|${find}|"import $1 from \"@mapitin/mapitin-library.interfaces\""|" test.js




####################################
# Command to replace a regex pattern with a string
####################################

# sed -i -E "s|${find}|${replace}|g" $final_dir 




