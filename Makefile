install:
	cargo install mdbook

serve:
	mdbook serve -p 8000 -n 127.0.0.1

build:
	mdbook build

deploy:
	mdbook build
	git worktree add gh-pages gh-pages
	git config user.name "Deploy from CI"
	git config user.email ""
	cd gh-pages
	# Delete the ref to avoid keeping history.
	git update-ref -d refs/heads/gh-pages
	rm -rf contrib
	mv ../book contrib
	git add contrib
	git commit -m "Deploy $GITHUB_SHA to gh-pages"
	git push --force

all: format lint test run


