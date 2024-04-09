## file_search_replace

> To find and replace string patterns within specified files in a folder list provided

- This script works on the folders as specified in the `folders_data.txt`

> Script usage
 - `[-f]` Regex pattern for string to find
 - `[-r]` Replace pattern for found string
 - `[-p]` To only print the files found by the [-f] regex pattern, without replacing found string with the [-r] string specified
 - `[-b]` To specify the base directory to run this script on; default would be: /mnt/c/Users/gohja/Desktop
 - `[-s]` To specify the sub directory; default would be:
 - `[-h]` prints help message

```
user@linux:sys-tools-bash/file_search_replace$ ./fsr.sh -<flags>
```
