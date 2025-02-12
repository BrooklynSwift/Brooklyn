# Credits ⇝ https://github.com/twostraws/Ignite/blob/main/Makefile

PREFIX_DIR := /usr/local/bin

build:
	@echo "Building the Brooklyn CLI...\\n"
	@swift build -c release --product BrooklynCLI

install:
	@echo "Installing the Brooklyn CLI...\\n"
	@mkdir -p $(PREFIX_DIR) 2> /dev/null || (echo "❌ Unable to create install directory \`$(PREFIX_DIR)\`. You might need to run \`sudo make\`\\n"; exit 126)
	@(install .build/release/BrooklynCLI $(PREFIX_DIR)/brooklyn 2> /dev/null && (echo \\n✅ Success! Run \`brooklyn\` to get started.)) || (echo \\n❌ Installation failed. You might need to run \`sudo make\` instead.\\n)

clean:
	@echo "Cleaning the Brooklyn build folder...\\n"
	@rm -rf .build/
