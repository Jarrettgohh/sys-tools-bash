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
