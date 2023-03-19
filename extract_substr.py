import sys
##################################
# Initial plan for this script was to extract the imported variable from the import statement, before returning the value back to bash
# however, there seems to be no way to receive and return args within a python script from bash
##################################


import re
import sys

# str = sys.stdin.read()
str = '{ hello }'

pattern = "\{.*\w+.*}"
match = re.findall(pattern, "import { hello } from \"..\"")[0]

# exit(match)
# sys.stdout.write(match)
