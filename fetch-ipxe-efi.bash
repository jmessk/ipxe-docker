#!/bin/bash
set -euo pipefail

# This script fetch iPXE EFI binaries and places them in tftp-server/files/.
# current implementation:
#  1. https://boot.ipxe.org/ipxe.efi -> ipxe-arm64.efi
#  2. https://boot.ipxe.org/arm64-efi/ipxe.efi -> ipxe-x86_64.efi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${ROOT_DIR}/tftp-server/files"

mkdir -p "${DEST_DIR}"

fetch() {
	local url="$1"; shift
	local out="$1"; shift
	echo "Downloading ${url} -> ${out}" >&2
	curl -fSL "${url}" -o "${out}.tmp"
	mv "${out}.tmp" "${out}"
}

fetch "https://boot.ipxe.org/ipxe.efi" "${DEST_DIR}/ipxe-x86_64.efi"
fetch "https://boot.ipxe.org/arm64-efi/ipxe.efi" "${DEST_DIR}/ipxe-arm64.efi"

echo "Done." >&2
