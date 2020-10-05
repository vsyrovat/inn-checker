.PHONY: help
help:
	@echo "Targets: setup, clean, test"

.PHONY: setup
setup:
	mix deps.clean --unused
	mix deps.get
	mix deps.compile
	npm i --prefix assets

.PHONY: clean
clean:
	rm -rf _build .elixir_ls deps priv/plts priv/static

.PHONY: test
test:
	mix format --check-formatted --dry-run
	mix test
	mix credo --strict
