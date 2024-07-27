#!/bin/bash

#------------------------------------------
#
# EXAMPLE 1: ITERATE THROUGH FOLDER DIRECTORY
# https://stackoverflow.com/questions/20796200/how-to-loop-over-files-in-directory-and-change-path-and-add-suffix-to-filename

folder="dir_name"

for file in "$dir_name"/*;
do
  echo "$file"
  ...
done
#------------------------------------------
#
# EXAMPLE 2: CONDITONAL STRING TERNARY 
# 

# NOTE: -eq operator is for numerical comparison

value=1
conditional_str=$([ "$value" -eq 0 ] && echo "value_zero" || echo "value_1")

#------------------------------------------
#
# EXAMPLE 3: CHECK IF STRING CONTAINS SUBSTRING
# https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash

# NOTE: == is for string comparison

main_str="main_sub"
substr_to_check="sub"

if [[ $main_str == *"sub"* ]]; then
  ...
fi


#------------------------------------------
#
# EXAMPLE 4: ITERATE THROUGH LINES FROM 
# 1 ~ VALUE FROM FILE INPUT
# 2 ~ VALUE FROM VARIABLE INPUT


# 1 ~ FILE INPUT
file="..."

# eg. ``` (on separate terminal)
# cat "$file"
# line 1
# line 2
# ...
#```


while IFS= read -r line;
do
  echo "$line"
  ...
done < "$file" # one left caret


# 2 ~ VARIABLE INPUT

# eg. ``` (on separate terminal)
# echo "$variable_str"
# line 1
# line 2
# ...
#```

while IFS= read -r line;
do
  echo "$line"
  ...
done <<< "$variable_str" # three left caret


#------------------------------------------











