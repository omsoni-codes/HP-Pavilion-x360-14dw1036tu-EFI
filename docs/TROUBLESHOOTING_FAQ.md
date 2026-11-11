# ❓ Troubleshooting & Frequently Asked Questions
### HP Pavilion x360 14-dw1036tu OpenCore EFI
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

### Q1: The bootloader halts at `#[EB|LOG:EXITBS:START]`. How do I fix it?
> **Fix**: Verify that `slide=33` is present in `boot-args` and that `AppleXcpmExtraMsrs` is set to `True` in `Kernel -> Quirks`. Select **Reset NVRAM** from OpenCore menu to apply changes.

### Q2: Why is my Western Digital SN530 SSD missing in macOS installer?
> **Fix**: Intel VMD must be enabled in BIOS NVRAM. Boot into OpenCore's UEFI Shell and execute `vmd_on.nsh`, then reboot.

### Q3: How do I switch audio output jack configuration?
> **Fix**: The default layout is `alcid=13`. You can test alternative layouts by passing `alcid=11` or `alcid=12` in `boot-args`.

### Q4: How do I update the EFI on my internal SSD?
> **Fix**: Run `sudo ./INSTALL_MASTER_EFI_TO_SSD.sh` inside macOS. It mounts the internal EFI, copies files, and restores the HP BIOS disguise.
