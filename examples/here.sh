############
# here strings (<<<)
############
################################################
## BOTH commands are the same
# the here string (<<<) command basically used for input redirection from text or variable 
# basic syntax: command <<< 'string'
################################################


echo "here" | tr -d 'e' 
tr -d 'e' <<< "here" 



############
# here documents (<<)
############

###### BASIC SYNTAX ########
# [COMMAND] << 'DELIMITER'
#   HERE-DOCUMENT
# 'DELIMITER'
######################

################################
# used to pass a multiline block of text or code to an interactive command
#################################


cat << END
THIS BUNCH OF TEXT WOULD BE SHOWN
END



#################################
# here file (<) (idk if thats what its really called)
#################################


dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/here.txt"
cat < $dir