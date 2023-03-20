###############
# Greedy regex search pattern - matches multiple lines
###############
# find="import.*\{(.|\n)+\}.*from.*\"../../../mapitin-interfaces/index\""


###############
# Non-greedy regex search pattern
###############
find="import[[:space:]]+?\{([a-zA-Z]|[[:space:]]|,)+?\}[[:space:]]+?from[[:space:]]+?\"../../../mapitin-interfaces/index\""

pcregrep -M $find /mnt/c/Users/gohja/Desktop/mapitin-repository/sys/learnings/regex-segmentation-fault.txt


