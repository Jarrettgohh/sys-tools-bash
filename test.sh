
# pcregrep -M "import.*\{(.|\n)+\}.*from.*\"../../../mapitin-interfaces/index\"" ./overdrive1/test.js

find="import[[:space:]]{1,40}\{(.|\n)+\}[[:space:]]{1,40}from[[:space:]]{1,40}\"../../../mapitin-interfaces/index\""
pcregrep -M $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/overdrive1/test.js 


# find="import(.|\n)+\{(.|\n)+\}(.|\n)+from(.|\n)+\"../../../mapitin-interfaces/index\""
# grep -P $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/overdrive1/test.js
