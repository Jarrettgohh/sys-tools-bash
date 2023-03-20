
# pcregrep -M "import.*\{(.|\n)+\}.*from.*\"../../../mapitin-interfaces/index\"" ./overdrive1/test.js

find="import.*\{(.|\n)+\}.*from.*\"../../../mapitin-interfaces/index\""
pcregrep -M $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/overdrive1/test.js 


