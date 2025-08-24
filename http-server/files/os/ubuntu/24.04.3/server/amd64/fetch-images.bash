#!/bin/bash
set -euo pipefail

# This script is for ubuntu-24.04.3-live-server-amd64

cd "$(dirname -- "${BASH_SOURCE[0]}")"

need() {
	local file="$1" url="$2"

	if [[ -f $file ]]; then
		echo "Already exists, skipping: $file"
		return
	fi

    echo "Downloading ${url} -> ${file}" >&2
	curl -L --fail -o "$file.tmp" "$url"
	mv "$file.tmp" "$file"
}

need initrd https://releases.ubuntu.com/24.04.3/netboot/amd64/initrd
need vmlinuz https://releases.ubuntu.com/24.04.3/netboot/amd64/linux
need ubuntu-24.04.3-live-server-amd64.iso https://releases.ubuntu.com/releases/24.04/ubuntu-24.04.3-live-server-amd64.iso

echo "Done." >&2
