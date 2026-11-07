#!/bin/bash
# ==============================================================================
# HP Pavilion x360 14-dw1036tu - One-Click GitHub Release Publisher
# Author: linuxkid473 (Vihaan Nathan)
# ==============================================================================
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "======================================================================"
echo "    Publishing HP-Pavilion-x360-14dw1036tu-EFI to GitHub (linuxkid473) "
echo "======================================================================"
echo ""
echo "Remote URL: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI.git"
echo "Branch: main (Tag: v1.0.0)"
echo ""
echo "Note: Before pushing, ensure you have created an empty repository on GitHub:"
echo "      Name: HP-Pavilion-x360-14dw1036tu-EFI"
echo "      Link: https://github.com/new"
echo ""

echo "Choose your authentication method to push:"
echo "  1) GitHub Personal Access Token (Classic / Fine-Grained with 'repo' scope)"
echo "  2) Standard Git Push (System will prompt for GitHub credentials / Keychain)"
echo "  3) SSH (git@github.com:linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI.git)"
echo ""
read -p "Select [1, 2, or 3]: " PUSH_CHOICE

if [ "$PUSH_CHOICE" == "1" ]; then
    read -s -p "Paste your GitHub Personal Access Token: " GH_PAT
    echo ""
    if [ -z "$GH_PAT" ]; then
        echo "[-] Error: Token cannot be empty."
        exit 1
    fi
    echo "[*] Pushing to GitHub via authenticated PAT..."
    git push "https://${GH_PAT}@github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI.git" main --tags
    echo ""
    echo "[+] SUCCESS! Repository and release v1.0.0 are now live on GitHub!"
    echo "    URL: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI"
    exit 0

elif [ "$PUSH_CHOICE" == "2" ]; then
    echo "[*] Executing standard git push..."
    git push -u origin main --tags
    echo ""
    echo "[+] SUCCESS! Repository and release v1.0.0 are now live on GitHub!"
    echo "    URL: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI"
    exit 0

elif [ "$PUSH_CHOICE" == "3" ]; then
    echo "[*] Setting remote to SSH..."
    git remote set-url origin git@github.com:linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI.git
    echo "[*] Pushing via SSH..."
    git push -u origin main --tags
    echo ""
    echo "[+] SUCCESS! Repository and release v1.0.0 are now live on GitHub!"
    echo "    URL: https://github.com/linuxkid473/HP-Pavilion-x360-14dw1036tu-EFI"
    exit 0
else
    echo "[-] Invalid choice."
    exit 1
fi
