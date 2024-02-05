.PHONY:build
build:
	GOOS=linux GOARCH=arm64 go build -tags lambda.norpc -o bootstrap main.go

zip: build
	zip function.zip bootstrap

# Semantic Release
.PHONY: semantic-release-dependencies
semantic-release-dependencies:
	@npm install --save-dev semantic-release
	@npm install @semantic-release/exec conventional-changelog-conventionalcommits -D

.PHONY: semantic-release
semantic-release: semantic-release-dependencies
	@npm ci
	@npx semantic-release

.PHONY: semantic-release-ci
semantic-release-ci: semantic-release-dependencies
	@npx semantic-release

.PHONY: semantic-release-dry-run
semantic-release-dry-run: semantic-release-dependencies
	@npm ci
	@npx semantic-release -d