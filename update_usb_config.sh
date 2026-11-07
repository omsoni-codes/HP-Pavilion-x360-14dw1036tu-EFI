#!/bin/bash
# ==============================================================================
# HP Pavilion x360 Convertible 14-dw1036tu - Quick USB EFI Sync Utility
# Author: linuxkid473 (Vihaan Nathan)
# Project: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EFI_SOURCE="$SCRIPT_DIR/EFI"

echo "======================================================================"
echo "      HP Pavilion x360 14-dw1036tu - Quick USB EFI Synchronizer       "
echo "======================================================================"

echo "[*] Scanning for connected external USB EFI partitions..."
EFI_DEV=$(diskutil list external | grep "EFI" | head -n 1 | awk '{print $NF}')

if [ -z "$EFI_DEV" ]; then
    echo "[-] Could not automatically identify an external USB EFI partition."
    echo "[*] Available disks:"
    diskutil list external
    echo ""
    read -p "Please enter the USB EFI partition (e.g. disk4s1): " EFI_DEV
    EFI_DEV=$(echo "$EFI_DEV" | sed 's#/dev/##')
fi

if [ -z "$EFI_DEV" ]; then
    echo "[-] No valid device provided. Exiting."
    exit 1
fi

echo "[*] Mounting /dev/$EFI_DEV..."
MOUNT_DIR="/Volumes/USB_EFI"
mkdir -p "$MOUNT_DIR"
sudo diskutil mount -mountPoint "$MOUNT_DIR" "/dev/$EFI_DEV" 2>/dev/null || sudo mount -t msdos "/dev/$EFI_DEV" "$MOUNT_DIR"

if [ -d "$MOUNT_DIR/EFI" ]; then
    echo "[*] Synchronizing Master EFI..."
    rm -rf "$MOUNT_DIR/EFI"
    cp -R "$EFI_SOURCE" "$MOUNT_DIR/"
    cp -f "$SCRIPT_DIR/startup.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_on.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_off.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    find "$MOUNT_DIR" -name "._*" -delete 2>/dev/null || true
    sync
    echo "[+] SUCCESS! USB EFI partition (/dev/$EFI_DEV) has been synchronized with the latest Master EFI!"
    sudo diskutil unmount "$MOUNT_DIR" 2>/dev/null || true
    rmdir "$MOUNT_DIR" 2>/dev/null || true
else
    echo "[-] Destination mount does not look like an EFI filesystem. Aborting."
    sudo diskutil unmount "$MOUNT_DIR" 2>/dev/null || true
    rmdir "$MOUNT_DIR" 2>/dev/null || true
    exit 1
fi
