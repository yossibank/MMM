PRODUCT_NAME := MMM

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) open

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

.PHONY: run-gitHooks
run-gitHooks:
	chmod +x GitHooks/pre-commit
	git config --local core.hooksPath GitHooks

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcworkspace

.PHONY: clean
clean:
	find . -type d \( -name \*.xcodeproj \) | xargs rm -rf
	rm -rf $${HOME}/Library/Developer/Xcode/DerivedData
