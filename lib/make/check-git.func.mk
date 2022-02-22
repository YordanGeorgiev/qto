.PHONY: check_git  ## @-> checks if your branch is ahead of origin/master branc
check_git:
	@echo "Checking if your branch is ahead of origin/master branch..."
	@if [ "$(shell git rev-list --left-right --count origin/master..HEAD | cut -f1|xargs)" != "0" ]; then \
		echo "You current branch is behind origin/master branch. Please merge/rebase your branch and try again!"; \
		exit 1; \
	fi
