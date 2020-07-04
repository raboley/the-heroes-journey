#example: ./scripts/pre-commit-filter.sh "echo matches: [$SRC_PATTERN]"
# with a file in either the scripts directory or the index.html.md file being staged in git
# this would then output
# matches: [source/index.html.md\|scripts/]

# @todo #1 Add the build badge for PDD
# Actually best thing to do is grep the index.html.md file to 
# search for files that are referenced in that, and then only run it
# if a matching file in there is updated. (or itself)
#figuring out if there is a matching path in the file will be harder than I thought probably
SRC_PATTERN='source/index.html.md\|scripts/'
git diff --cached --name-only | if grep --quiet "$SRC_PATTERN"
then
    eval $1
fi
