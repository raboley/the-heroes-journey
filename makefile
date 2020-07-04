init:
	chmod +x .pre-commit.sh
	ln -s -f ../../pre.-commit.sh .git/hooks/pre-commit
docs:
	. ./scripts/embedme.sh
