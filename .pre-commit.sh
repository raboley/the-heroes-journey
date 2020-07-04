$SRC_PATTERN=./source/index.html.md
git diff --cached --name-only | if grep --quiet "$SRC_PATTERN"
then
    . ./scripts/embedme.sh
    git add ./source/index.html.md
fi
