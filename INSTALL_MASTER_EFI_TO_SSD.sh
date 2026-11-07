#!/bin/bash
# ==============================================================================
# HP Pavilion x360 Convertible 14-dw1036tu - Standalone SSD Installer
# Author: omsoni-codes (Om Soni)
# Project: https://github.com/omsoni-codes/HP-Pavilion-x360-14dw1036tu-EFI
# ==============================================================================
set -e

echo "================================================================="
echo "   HP Pavilion x360 14-dw - Master Bespoke EFI SSD Installer   "
echo "               Author: omsoni-codes | OpenCore 1.0.8              "
echo "================================================================="
echo ""

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run as root (sudo ./INSTALL_MASTER_EFI_TO_SSD.sh)"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Source EFI Directory: $SCRIPT_DIR/EFI"

if [ ! -d "$SCRIPT_DIR/EFI/OC" ]; then
  echo "Error: Source EFI/OC directory not found at $SCRIPT_DIR/EFI/OC"
  exit 1
fi

echo "[1/6] Detecting Internal System SSD..."
# Identify internal disk by tracing the root mount /
ROOT_DEV=$(df / | tail -n 1 | awk '{print $1}')
echo "  -> Root volume: $ROOT_DEV"

# APFS container or physical store
ROOT_DISK=$(diskutil info / | grep "Part of Whole" | awk '{print $NF}')
if [ -z "$ROOT_DISK" ]; then
  ROOT_DISK=$(diskutil info / | grep "Device Identifier" | awk '{print $NF}')
fi

PHYS_DISK=""
for store in $(diskutil info "$ROOT_DISK" 2>/dev/null | grep "Physical Store" | awk '{print $NF}'); do
  PHYS_DISK=$(diskutil info "$store" | grep "Part of Whole" | awk '{print $NF}')
  break
done

if [ -z "$PHYS_DISK" ]; then
  # Fallback to checking disk0 or disk1
  for d in disk0 disk1; do
    if diskutil list "$d" 2>/dev/null | grep -q "APFS Container"; then
      PHYS_DISK="$d"
      break
    fi
  done
fi

if [ -z "$PHYS_DISK" ]; then
  echo "Error: Could not locate internal system disk!"
  exit 1
fi

echo "  -> Internal Physical SSD: /dev/$PHYS_DISK"
SSD_EFI_DEV="/dev/${PHYS_DISK}s1"
echo "  -> Internal SSD EFI Partition: $SSD_EFI_DEV"

echo "[2/6] Mounting Target Internal SSD EFI..."
SSD_MNT="/Volumes/SSD_EFI"
mkdir -p "$SSD_MNT"
umount "$SSD_EFI_DEV" 2>/dev/null || true
mount -t msdos "$SSD_EFI_DEV" "$SSD_MNT"

echo "[3/6] Synchronizing Master Bespoke EFI..."
# Clean old files
rm -rf "$SSD_MNT/EFI"
mkdir -p "$SSD_MNT/EFI"

# Copy full master EFI tree
cp -R "$SCRIPT_DIR/EFI/"* "$SSD_MNT/EFI/"

# Copy UEFI shell recovery scripts to the root of the EFI partition
cp -f "$SCRIPT_DIR/startup.nsh" "$SSD_MNT/" 2>/dev/null || true
cp -f "$SCRIPT_DIR/vmd_on.nsh" "$SSD_MNT/" 2>/dev/null || true
cp -f "$SCRIPT_DIR/vmd_off.nsh" "$SSD_MNT/" 2>/dev/null || true
cp -f "$SCRIPT_DIR/EFI/OC/Tools/setup_var.efi" "$SSD_MNT/" 2>/dev/null || true

echo "[4/6] Installing HP InsydeH2O BIOS Disguise (bootmgfw.efi)..."
mkdir -p "$SSD_MNT/EFI/Microsoft/Boot"
cp -f "$SSD_MNT/EFI/BOOT/BOOTx64.efi" "$SSD_MNT/EFI/Microsoft/Boot/bootmgfw.efi"

echo "[5/6] Tuning Power Management & Instant Lid Wake..."
pmset -a hibernatemode 0
pmset -a standby 0
pmset -a autopoweroff 0
pmset -a tcpkeepalive 0 2>/dev/null || true
rm -f /var/vm/sleepimage 2>/dev/null || true
touch /var/vm/sleepimage 2>/dev/null || true
chflags uchg /var/vm/sleepimage 2>/dev/null || true

echo "[6/6] Purging metadata, syncing buffers, and unmounting..."
find "$SSD_MNT" -name "._*" -delete 2>/dev/null || true
sync
diskutil unmount "$SSD_MNT"

echo ""
echo "================================================================="
echo "  SUCCESS! Master Bespoke EFI Installed to Internal SSD!         "
echo "  Your HP Pavilion x360 is now configured for standalone boot   "
echo "  directly from the internal SSD without the USB pendrive!       "
echo "================================================================="
