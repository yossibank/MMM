PRODUCT_NAME := MMM

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) generate-xcodeproj
	$(MAKE) open

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: generate-xcodeproj
generate-xcodeproj:
	mint run xcodegen --project MMM

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcworkspace

.PHONY: clean
clean:
	find . -type d \( -name \*.xcodeproj \) | xargs rm -rf
	rm -rf $${HOME}/Library/Developer/Xcode/DerivedData