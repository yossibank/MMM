PRODUCT_NAME := MMM

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) generate-folder
	$(MAKE) generate-mock
	$(MAKE) open

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-folder
generate-folder:
	mkdir -p Package/Sources/Mock/Generated

.PHONY: generate-mock
generate-mock:
	make generate-sample-test-mock

.PHONY: generate-sample-test-mock
generate-sample-test-mock:
	mint run mockolo mockolo --sourcedirs Package/Sources/Sample \
		--destination Package/Sources/Mock/Generated/SampleMockResults.swift \
		--testable-imports Sample \
		--mock-final \
		--macro "DEBUG"

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

.PHONY: run-gitHooks
run-gitHooks:
	chmod +x GitHooks/pre-commit
	git config --local core.hooksPath GitHooks

.PHONY: upload-deploygate
upload-deploygate:
	bundle exec fastlane upload_adhoc_deploygate

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcworkspace

.PHONY: clean
clean:
	find . -type d \( -name \*.xcodeproj \) | xargs rm -rf
	rm -rf $${HOME}/Library/Developer/Xcode/DerivedData
