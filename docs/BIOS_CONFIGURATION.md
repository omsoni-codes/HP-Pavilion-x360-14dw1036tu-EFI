# ⚙️ HP InsydeH2O BIOS Setup & NVRAM Registers Guide
### HP Pavilion x360 Convertible 14-dw1036tu (Board ID: 087F4)
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## 📋 Standard BIOS Settings
Turn on your laptop and press **F10** repeatedly to open the InsydeH2O BIOS Setup:

* **Security Tab**:
  * **Secure Boot**: `Disabled` (Mandatory for OpenCore loading)
* **System Configuration Tab**:
  * **Virtualization Technology (VT-x)**: `Enabled`
  * **Fast Boot**: `Disabled`
  * **USB Boot**: `Enabled`
  * **Network Boot / PXE**: `Disabled`

---

## 🔬 Critical Intel Tiger Lake NVRAM Registers
HP consumer BIOS hides advanced storage and power settings. This EFI provides `setup_var.efi` and companion scripts to verify and set these offsets directly:

| Variable Store | Hex Offset | Optimal Value | Description |
| :--- | :---: | :---: | :--- |
| **Setup** | `0x500` | `0x02` | Storage Interface Mode: Intel VMD / RST (Required for M.2 power) |
| **Setup** | `0x501` | `0x01` | VMD Controller Enable |
| **SaSetup** | `0x415` | `0x01` | VMD Root Port 1 Enable |
| **SaSetup** | `0x416` | `0x01` | VMD Root Port 2 Enable |
| **SaSetup** | `0x417` | `0x01` | VMD Root Port 3 Enable |
| **SaSetup** | `0x418` | `0x01` | VMD Root Port 4 Enable |

---

## ⚡ Automated UEFI Shell Execution
To apply all storage registers in one second, open OpenCore's **UEFI Shell** and run:
```text
vmd_on.nsh
```
Or execute manually:
```text
setup_var.efi Setup:0x500=0x02
setup_var.efi Setup:0x501=0x01
setup_var.efi SaSetup:0x415=0x01
reset
```
