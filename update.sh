#!/bin/bash
set -eo pipefail

current="$(
	git ls-remote --tags https://github.com/idno/known.git \
		| awk -F 'refs/tags/' '
			$2 ~ /^v?[0-9]/ {
				gsub(/^v|\^.*/, "", $2);
				print $2;
			}
		' \
		| sort -uV \
		| tail -1
)"

set -x
sed -ri 's/^(ENV KNOWN_VERSION) .*/\1 '"$current"'/;' ./Dockerfile
