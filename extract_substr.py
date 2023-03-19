import sys
import re

str = sys.argv[1]

print(str)
pattern = ".+\{.*\w+.*}.+"
match = re.search(pattern, "test { hello } ")
print(match)
