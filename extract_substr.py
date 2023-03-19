import sys
import re

str = sys.stdin.read()

pattern = "\{.*\w+.*}"
match = re.findall(pattern, "import { hello } from \"..\"")[0]

exit(match)
