#!/bin/bash
# ==============================================================================
# HP Pavilion x360 Convertible 14-dw1036tu - USB Installer Preparation Tool
# Author: linuxkid473 (Vihaan Nathan)
# Project: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EFI_SOURCE="$SCRIPT_DIR/EFI"
AUTOPKG_SOURCE="$SCRIPT_DIR/WhateverXe-PostInstall/AutoPkg-Assets.pkg"

echo "======================================================================"
echo "    HP Pavilion x360 14-dw1036tu macOS Installer & EFI Setup Tool     "
echo "               Author: linuxkid473 | OpenCore 1.0.8                  "
echo "======================================================================"
echo ""

if [ ! -d "$EFI_SOURCE/OC" ]; then
    echo "[-] Error: Source EFI/OC directory not found at $EFI_SOURCE"
    exit 1
fi

echo "Select an operation:"
echo "  1) Flash / Copy OpenCore Master EFI directly to a mounted USB EFI"
echo "  2) Full macOS Installer Media creation (createinstallmedia + EFI)"
echo ""
read -p "Enter choice [1 or 2]: " CHOICE

if [ "$CHOICE" == "1" ]; then
    echo ""
    echo "[*] Scanning for connected USB EFI partitions..."
    diskutil list | grep -E "disk[1-9]|EFI|DOS_FAT_32" || true
    echo ""
    read -p "Enter your USB EFI partition identifier (e.g. disk4s1): " USB_EFI_ID
    USB_EFI_ID=$(echo "$USB_EFI_ID" | sed 's#/dev/##')
    
    if [ -z "$USB_EFI_ID" ]; then
        echo "[-] Invalid partition identifier."
        exit 1
    fi
    
    echo "[*] Mounting /dev/$USB_EFI_ID..."
    MOUNT_DIR=$(mktemp -d /Volumes/USB_EFI_XXXXXX)
    sudo diskutil mount -mountPoint "$MOUNT_DIR" "/dev/$USB_EFI_ID" 2>/dev/null || sudo mount -t msdos "/dev/$USB_EFI_ID" "$MOUNT_DIR"
    
    echo "[*] Installing Master EFI to $MOUNT_DIR..."
    rm -rf "$MOUNT_DIR/EFI"
    cp -R "$EFI_SOURCE" "$MOUNT_DIR/"
    cp -f "$SCRIPT_DIR/startup.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_on.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_off.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    
    # Purge macOS metadata
    find "$MOUNT_DIR" -name "._*" -delete 2>/dev/null || true
    sync
    sudo diskutil unmount "$MOUNT_DIR"
    rmdir "$MOUNT_DIR" 2>/dev/null || true
    
    echo ""
    echo "[+] SUCCESS! Master EFI successfully installed to /dev/$USB_EFI_ID!"
    echo "    Your USB is now ready to boot your HP Pavilion x360."
    exit 0

elif [ "$CHOICE" == "2" ]; then
    echo ""
    echo "[*] Full macOS Installer Media Creation Selected."
    echo "[*] Ensure you have downloaded macOS Sequoia or Tahoe via 'InstallAssistant.pkg'"
    echo "    or have 'Install macOS Sequoia.app' / 'Install macOS Tahoe.app' in /Applications."
    echo ""
    
    INSTALLER_APP=""
    for app in "/Applications/Install macOS Sequoia.app" "/Applications/Install macOS Tahoe.app" "/Applications/Install macOS Sonoma.app"; do
        if [ -d "$app" ]; then
            INSTALLER_APP="$app"
            break
        fi
    done
    
    if [ -z "$INSTALLER_APP" ]; then
        echo "[-] No supported macOS installer app found in /Applications."
        echo "    Download 'InstallAssistant.pkg' from Apple and run it first to extract the app."
        exit 1
    fi
    
    echo "[+] Detected installer: $INSTALLER_APP"
    echo ""
    diskutil list external
    echo ""
    read -p "Enter the target USB volume path (e.g. /Volumes/MyUSB): " USB_VOL
    
    if [ ! -d "$USB_VOL" ]; then
        echo "[-] Error: Volume $USB_VOL does not exist or is not mounted."
        exit 1
    fi
    
    echo "[*] Creating bootable macOS installer on $USB_VOL..."
    sudo "$INSTALLER_APP/Contents/Resources/createinstallmedia" --volume "$USB_VOL" --nointeraction
    
    echo "[*] Detecting newly created USB EFI partition..."
    # Disk of installer
    PARENT_DISK=$(diskutil info "$INSTALLER_APP" 2>/dev/null | grep "Part of Whole" | awk '{print $NF}')
    if [ -z "$PARENT_DISK" ]; then
        diskutil list external
        read -p "Enter your USB disk EFI partition (e.g. disk4s1): " USB_EFI_ID
    else
        USB_EFI_ID="${PARENT_DISK}s1"
    fi
    
    echo "[*] Mounting /dev/$USB_EFI_ID..."
    MOUNT_DIR=$(mktemp -d /Volumes/USB_EFI_XXXXXX)
    sudo diskutil mount -mountPoint "$MOUNT_DIR" "/dev/$USB_EFI_ID" 2>/dev/null || sudo mount -t msdos "/dev/$USB_EFI_ID" "$MOUNT_DIR"
    
    echo "[*] Deploying Master OpenCore EFI to USB..."
    rm -rf "$MOUNT_DIR/EFI"
    cp -R "$EFI_SOURCE" "$MOUNT_DIR/"
    cp -f "$SCRIPT_DIR/startup.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_on.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    cp -f "$SCRIPT_DIR/vmd_off.nsh" "$MOUNT_DIR/" 2>/dev/null || true
    find "$MOUNT_DIR" -name "._*" -delete 2>/dev/null || true
    sync
    sudo diskutil unmount "$MOUNT_DIR"
    rmdir "$MOUNT_DIR" 2>/dev/null || true
    
    echo "[*] Injecting WhateverXe AutoPkg offline graphics payload..."
    INSTALLER_VOL=""
    for v in "/Volumes/Install macOS Sequoia" "/Volumes/Install macOS Tahoe" "/Volumes/Install macOS Sonoma"; do
        if [ -d "$v" ]; then
            INSTALLER_VOL="$v"
            break
        fi
    done
    
    if [ -n "$INSTALLER_VOL" ] && [ -f "$AUTOPKG_SOURCE" ]; then
        sudo mkdir -p "$INSTALLER_VOL/Library/Packages"
        sudo cp "$AUTOPKG_SOURCE" "$INSTALLER_VOL/Library/Packages/AutoPkg-Assets.pkg"
        echo "[+] AutoPkg-Assets.pkg successfully staged in $INSTALLER_VOL/Library/Packages/"
    fi
    
    echo ""
    echo "======================================================================"
    echo "[+] ALL DONE! Your bootable macOS USB installer is 100% complete!"
    echo "    - OpenCore 1.0.8 + WhateverXe 0.7.0 deployed."
    echo "    - All ACPI patches & Tiger Lake VMD kexts bundled."
    echo "    - You can now boot your HP Pavilion x360 from this USB."
    echo "======================================================================"
    exit 0
else
    echo "[-] Invalid selection."
    exit 1
fi
