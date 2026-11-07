@echo -off
cls
echo "=========================================================="
echo "    HP Pavilion x360 14-dw - Intel VMD Storage Mode OFF   "
echo "=========================================================="
setup_var.efi Setup:0x500=0x00
EFI\OC\Tools\setup_var.efi Setup:0x500=0x00
setup_var.efi Setup:0x501=0x00
EFI\OC\Tools\setup_var.efi Setup:0x501=0x00
setup_var.efi SaSetup:0x415=0x00
setup_var.efi SaSetup:0x416=0x00
setup_var.efi SaSetup:0x417=0x00
setup_var.efi SaSetup:0x418=0x00
echo "VMD Disabled."
