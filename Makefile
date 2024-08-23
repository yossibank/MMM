PRODUCT_NAME := MMM

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) generate-mock
	$(MAKE) open

.PHONY: pre-commit
pre-commit:
	$(MAKE) setup-pre-commit
	$(MAKE) install-pre-commit

.PHONY: setup-pre-commit
setup-pre-commit:
	brew install pre-commit

.PHONY: install-pre-commit
install-pre-commit:
	pre-commit install

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-mock
generate-mock:
	sh Script/mockolo.sh

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

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
