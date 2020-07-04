init:
	ln -s -f ../../.pre-commit.sh .git/hooks/pre-commit
docs:
	. ./scripts/embedme.sh
host-docs:
	bundle exec middleman server