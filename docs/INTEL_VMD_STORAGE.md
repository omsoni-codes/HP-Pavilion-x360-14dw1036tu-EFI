# 💾 Intel Tiger Lake VMD Storage Architecture
### Driving Western Digital PC SN530 NVMe behind Controller 8086:9A0B
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## 🧩 Motherboard Topology
On the HP Pavilion x360 Convertible 14-dw1036tu (Board `087F4`), the M.2 NVMe slot does not connect directly to standard PCH PCIe lanes. Instead, it is routed through the **Intel Volume Management Device (VMD)** controller:
* **PCI Device**: `00:0e.0`
* **Device ID**: `8086:9A0B` (Intel Tiger Lake-U VMD Controller)

---

## ⚠️ The AHCI / VMD-Off Pitfall
Many general Hackintosh tutorials recommend disabling Intel RST/VMD in BIOS to switch to standard AHCI.
**Why this breaks HP Pavilion laptops:**
Disabling VMD removes PCIe clock and power delivery to the physical M.2 slot, causing the Western Digital SN530 SSD to completely disappear from the PCI bus.

---

## 🟢 The Solution: Native IntelVMD.kext
1. Keep Intel VMD enabled in BIOS NVRAM (`Setup:0x500=0x02`, `Setup:0x501=0x01`).
2. Inject `IntelVMD.kext` (v1.0.0) in OpenCore.
3. `IntelVMD.kext` initializes controller `8086:9A0B` and provides high-speed native block storage directly to macOS APFS!
