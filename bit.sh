#!/bin/bash

path_to_WSL_filesystem=/mnt/c/Users/gohja
path_to_bit_file=Desktop/mapitin-repository/sys

# combine the two path string variables to one variable
final_dir="${path_to_WSL_filesystem}/${path_to_bit_file}/test.js"


local_bit_dir=\"../../../mapitin-interfaces/index\"
cloud_bit_dir=\"@mapitin/mapitin-library.interfaces\"


# create the find and replace string 
find="import.*\{.+\}.*from.*\"../../../mapitin-interfaces/index\""
replace="import {} from \"@mapitin/mapitin-library.interfaces\""



########################################################################
# run the `sed` command to edit the files
# the `-i` flag indicates to edit the file rather than just outputting the results
# main syntax for the `sed` command seems to be: (sed "sed s|<find_pattern>|<replace_pattern>|" <path_directory>)

# helpful tip: the seperator used in the `sed` command argument separator; in this case is the vertical bar (|) symbol, can actually be any character, as long as it doesn't conflict with: hash (#) char works too
########################################################################



# grep -E -R -H $find ./
grep -E $find test.js | echo $1


# sed -i -E "s|${find}|${replace}|g" $final_dir 




