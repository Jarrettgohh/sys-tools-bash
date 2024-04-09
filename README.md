## file_search_replace

> To find and replace string patterns within specified files in a folder list provided

- This script works on the folders as specified in the `folders_data.txt`

> Script usage
Input flags
 - `[-f]` Regex pattern for string to find
 - `[-r]` Replace pattern for found string
 - `[-p]` To only print the files found by the [-f] regex pattern, without replacing found string with the [-r] string specified
 - `[-b]` To specify the base directory to run this script on; default would be: /mnt/c/Users/gohja/Desktop
 - ~`[-s]` To specify the sub directory; default would be:~
 - `[-h]` prints help message
 - 
```
user@linux:sys-tools-bash/file_search_replace$ ./fsr.sh -<flags>
```

> To take note:
- For the `[-b]` flag, single or double quotes should be omitted when using absolute path, to prevent Bash from reading it as a string literal

For example:
```
user@linux:sys-tools-bash/file_search_replace$ ls ~/example_folder
... results

user@linux:sys-tools-bash/file_search_replace$ ./fsr.sh -<other_relevant_flags> -b '~/example_folder'
... error message: failed to open file: No such file or directory

user@linux:sys-tools-bash/file_search_replace$ ./fsr.sh -<other_relevant_flags> -b ~/example_folder
... desired results
```


