# prints out the input through the pipe
echo "hello" | cat

# echo hello -> pipe to output which is read with the `read` command before echoing the value
echo "hello" | { read message ; echo $message; } 
# same as above just that the `&&` indicates that the previous command (in this case: `read message`) needs to succeed
echo "hello" | { read message && echo $message; }
