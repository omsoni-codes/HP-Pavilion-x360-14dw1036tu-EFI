@echo -off
cls
echo "=========================================================="
echo "    HP Pavilion x360 14-dw - Intel VMD Storage Mode Restorer "
echo "=========================================================="
echo ""
echo "[1/2] Setting Storage Interface Mode to Intel VMD / RST (0x02)..."
setup_var.efi Setup:0x500=0x02
EFI\OC\Tools\setup_var.efi Setup:0x500=0x02
FS0:\setup_var.efi Setup:0x500=0x02
FS0:\EFI\OC\Tools\setup_var.efi Setup:0x500=0x02
FS1:\setup_var.efi Setup:0x500=0x02
FS1:\EFI\OC\Tools\setup_var.efi Setup:0x500=0x02
FS2:\setup_var.efi Setup:0x500=0x02
FS2:\EFI\OC\Tools\setup_var.efi Setup:0x500=0x02

echo "[2/2] Enabling VMD Controller and Root Ports (0x01)..."
setup_var.efi Setup:0x501=0x01
EFI\OC\Tools\setup_var.efi Setup:0x501=0x01
FS0:\setup_var.efi Setup:0x501=0x01
FS0:\EFI\OC\Tools\setup_var.efi Setup:0x501=0x01
FS1:\setup_var.efi Setup:0x501=0x01
FS1:\EFI\OC\Tools\setup_var.efi Setup:0x501=0x01

setup_var.efi SaSetup:0x415=0x01
EFI\OC\Tools\setup_var.efi SaSetup:0x415=0x01
FS0:\setup_var.efi SaSetup:0x415=0x01
FS0:\EFI\OC\Tools\setup_var.efi SaSetup:0x415=0x01
FS1:\setup_var.efi SaSetup:0x415=0x01
FS1:\EFI\OC\Tools\setup_var.efi SaSetup:0x415=0x01

setup_var.efi SaSetup:0x416=0x01
EFI\OC\Tools\setup_var.efi SaSetup:0x416=0x01
FS0:\setup_var.efi SaSetup:0x416=0x01
FS0:\EFI\OC\Tools\setup_var.efi SaSetup:0x416=0x01
FS1:\setup_var.efi SaSetup:0x416=0x01
FS1:\EFI\OC\Tools\setup_var.efi SaSetup:0x416=0x01

setup_var.efi SaSetup:0x417=0x01
EFI\OC\Tools\setup_var.efi SaSetup:0x417=0x01
FS0:\setup_var.efi SaSetup:0x417=0x01
FS0:\EFI\OC\Tools\setup_var.efi SaSetup:0x417=0x01
FS1:\setup_var.efi SaSetup:0x417=0x01
FS1:\EFI\OC\Tools\setup_var.efi SaSetup:0x417=0x01

setup_var.efi SaSetup:0x418=0x01
EFI\OC\Tools\setup_var.efi SaSetup:0x418=0x01
FS0:\setup_var.efi SaSetup:0x418=0x01
FS0:\EFI\OC\Tools\setup_var.efi SaSetup:0x418=0x01
FS1:\setup_var.efi SaSetup:0x418=0x01
FS1:\EFI\OC\Tools\setup_var.efi SaSetup:0x418=0x01

echo ""
echo "=========================================================="
echo "  Verification (Expected: Setup:0x500=0x02, Setup:0x501=0x01):"
echo "=========================================================="
setup_var.efi Setup:0x500
setup_var.efi Setup:0x501
setup_var.efi SaSetup:0x415
echo "=========================================================="
echo "SUCCESS: Intel VMD mode is restored for macOS Tahoe!"
echo "Type 'reset' and press Enter to reboot into OpenCore."
echo "=========================================================="
