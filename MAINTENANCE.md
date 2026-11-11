# 🛡️ Automated Repository Health & Upstream Tracker
### HP Pavilion x360 Convertible 14-dw1036tu macOS Tahoe & Sequoia OpenCore EFI
**Maintained by:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)  
**Verification Schedule:** Daily at 8:00 PM IST (14:30 UTC)  
**Last Verified:** `2026-11-11 18:40 IST` (`2026-11-11 13:10:07 UTC`)

---

## 📊 Core Upstream Components Status

| Component | Architecture Role | Deployed Version | Upstream Latest | Health Status |
| :--- | :--- | :---: | :---: | :---: |
| **OpenCorePkg** | UEFI Bootloader | `1.0.8` | `1.0.8` | 🟢 Current |
| **WhateverXe** | Intel Xe-LP Metal 2 GPU Driver | `0.7.0` | `0.8.0` | ℹ️ Upstream: 0.8.0 |
| **Lilu** | Arbitrary Kext Patcher Framework | `1.7.2` | `1.7.2` | 🟢 Current |
| **AppleALC** | Realtek ALC287 Audio Driver | `1.9.8` | `1.9.8` | 🟢 Current |
| **AirportItlwm** | Intel AX201 Native Wi-Fi Driver | `2.4.0` | `v2.3.0` | ℹ️ Upstream: v2.3.0 |
| **IntelBluetoothFirmware** | Intel AX201 Bluetooth Driver | `2.5.0` | `v2.4.0` | ℹ️ Upstream: v2.4.0 |
| **VoodooI2C** | I2C Trackpad & Touchscreen Engine | `2.9.1` | `v2.9.1` | 🟢 Current |
| **VirtualSMC** | Apple SMC Hardware Emulator | `1.3.8` | `1.3.8` | 🟢 Current |
| **ECEnabler** | ACPI EC 8-bit Field Fix | `1.0.6` | `1.0.6` | 🟢 Current |

---

## 🔬 Hardware Verification Matrix

| Subsystem | Hardware Spec | Target Status | Verification Mode |
| :--- | :--- | :---: | :--- |
| **iGPU** | Intel UHD Xe-LP (`8086:9A78`) | 🟢 Stable | Metal 2 Acceleration & Quartz Extreme via `WhateverXe.kext` |
| **Storage** | WD SN530 NVMe behind VMD (`8086:9A0B`) | 🟢 Stable | Native Block Storage via `IntelVMD.kext` + VMD NVRAM |
| **Audio** | Realtek ALC287 on Tiger Lake cAVS | 🟢 Stable | Stereo Output & Internal Mic via `alcid=13` + `SimpleHDA` |
| **Wi-Fi** | Intel Wi-Fi 6 AX201 (`8086:A0F0`) | 🟢 Stable | Native Apple Wi-Fi Menu Bar via `AirportItlwm.kext` |
| **Bluetooth** | Intel AX201 Bluetooth 5.0 | 🟢 Stable | System Settings Pairing & HCI via `IntelBluetoothFirmware` |
| **Trackpad** | ELAN0722 Precision Touchpad | 🟢 Stable | 120Hz Polling & Gestures via `VoodooI2C` (`-vi2c-force-polling`) |
| **KASLR** | Willow Cove Physical Memory Map | 🟢 Stable | Collision Immunity locked via `slide=33` |
| **XCPM** | Comet Lake CPUID Emulation | 🟢 Stable | Missing MSR `#GP` bypass via `AppleXcpmExtraMsrs=True` |

---

*This document is automatically updated daily by GitHub Actions and local maintenance agents.*
