BINARY ?= myapp
CMD_DIR ?= ./cmd/$(BINARY)
DRB99_API ?= https://drb99.fly.dev/api/v1/generate

.PHONY: run test build clean release release-npm release-aur release-nix release-goreleaser

run:
	go run .

test:
	go test ./...

build:
	mkdir -p ./dist
	go build -o ./dist/$(BINARY) $(CMD_DIR)

clean:
	rm -rf ./dist

release: release-goreleaser

release-goreleaser:
	rhlp $(DRB99_API) ./packaging/go_releaser.json .

release-npm:
	mkdir -p ./packaging/npm_wrapper
	rhlp $(DRB99_API) ./packaging/npm_wrapper.json ./packaging/npm_wrapper

release-aur:
	rhlp $(DRB99_API) ./packaging/aur.json .

release-nix:
	rhlp $(DRB99_API) ./packaging/nix.json .
