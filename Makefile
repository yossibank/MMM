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
	mkdir -p Package/Sources/AppMock/Generated

.PHONY: generate-mock
generate-mock:
	sh Script/mockolo.sh

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

.PHONY: run-gitHooks
run-gitHooks:
	chmod +x GitHooks/pre-commit
	git config --local core.hooksPath GitHooks

.PHONY: update-package
update-package:
	sh Script/update-package.sh

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
