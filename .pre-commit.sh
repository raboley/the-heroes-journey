source ~/.bash_profile
# embedme pre-commit hook so that if some script or documentation 
# was updated to include more scripts the documentation pages get updated
. ./scripts/pre-commit-filter.sh ". scripts/embedme.sh; git add ./source/index.html.md"
# Pdd pre-commit hook so that if there is going to a pdd issue it is caught prior to commit.
. ./scripts/pdd-commit-hook.sh