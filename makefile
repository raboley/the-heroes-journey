init:
	ln -s -f ../../.pre-commit.sh .git/hooks/pre-commit
	. ./scripts/install-pdd.sh
	# install all the gems needed for slate
	bundle install
docs:
	. ./scripts/embedme.sh
serve-docs:
	bundle exec middleman server