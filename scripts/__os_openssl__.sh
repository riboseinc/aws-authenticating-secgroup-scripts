#!/bin/bash
#
# macOS provides an outdated OpenSSL so you need to use a later one installed from Homebrew

# assume openssl is in PATH on Linux systems
OPENSSL_BIN="openssl"

# only run on macOS:
uname | grep -q ^Darwin
if [ $? -eq 0 ]; then
	which brew >/dev/null
	if [ $? -ne 0 ]; then
		echo "Homebrew is a prerequisite to install the latest OpenSSL on macOS (hint: install brew via 'https://brew.sh/')" >&2
		exit 1
	fi	

	OPENSSL_BIN="$(brew list openssl | awk '/\/bin\/openssl/')"
	if [[ -z "${OPENSSL_BIN}" ]]; then
		echo "Homebrew OpenSSL not installed (hint: 'brew install openssl')" >&2
		exit 1
	fi
fi
