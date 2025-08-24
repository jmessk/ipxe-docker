#!/bin/bash
set -euo pipefail

# This script is for ubuntu-24.04.3-desktop-arm64

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

need initrd https://cdimage.ubuntu.com/releases/24.04.3/release/netboot/arm64/initrd
need vmlinuz https://cdimage.ubuntu.com/releases/24.04.3/release/netboot/arm64/linux
need ubuntu-24.04.3-desktop-arm64.iso https://cdimage.ubuntu.com/releases/24.04.3/release/ubuntu-24.04.3-desktop-arm64.iso

echo "Done." >&2
