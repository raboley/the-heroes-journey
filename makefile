init:
	ln -s -f ../../.pre-commit.sh .git/hooks/pre-commit
	. ./scripts/install-pdd.sh
	# install all the gems needed for slate
	bundle install
serve-docs:
	bundle exec middleman server
embedme:
	. ./scripts/embedme.sh
