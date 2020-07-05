init:
	ln -s -f ../../.pre-commit.sh .git/hooks/pre-commit
	. ./scripts/install-pdd.sh
docs:
	. ./scripts/embedme.sh
host-docs:
	bundle exec middleman server