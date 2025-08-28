#!/bin/bash
set -euo pipefail

# This script is for ubuntu-22.04.5-live-server-amd64

cd "$(dirname -- "${BASH_SOURCE[0]}")"

fetch() {
	local file="$1" url="$2"

	if [[ -f $file ]]; then
		echo "Already exists, skipping: $file"
		return
	fi

    echo "Downloading ${url} -> ${file}" >&2
	curl -L --fail -o "$file.tmp" "$url"
	mv "$file.tmp" "$file"
}

fetch initrd https://releases.ubuntu.com/22.04.5/netboot/amd64/initrd
fetch vmlinuz https://releases.ubuntu.com/22.04.5/netboot/amd64/linux
fetch ubuntu-22.04.5-live-server-amd64.iso https://releases.ubuntu.com/releases/22.04/ubuntu-22.04.5-live-server-amd64.iso

echo "Done." >&2
