
# pcregrep -M "import.*\{(.|\n)+\}.*from.*\"../../../mapitin-interfaces/index\"" ./overdrive1/test.js

find="import[[:space:]]+?\{([a-zA-Z]|[[:space:]]|,)+?\}[[:space:]]+?from[[:space:]]+?\"@mapitin/mapitin-library.interfaces\""
pcregrep -M -r $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/bit-cloud/test.js 


# find="import(.|\n)+\{(.|\n)+\}(.|\n)+from(.|\n)+\"../../../mapitin-interfaces/index\""
# grep -P $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/overdrive1/test.js
