# 🛡️ Automated Repository Health & Upstream Tracker
### HP Pavilion x360 Convertible 14-dw1036tu macOS Tahoe & Sequoia OpenCore EFI
**Maintained by:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)  
**Verification Schedule:** Daily at 8:00 PM IST (14:30 UTC)  
**Last Verified:** `2026-11-11 20:05 IST` (`2026-11-11 14:35:10 UTC`)

---

## 📊 Core Upstream Components Status

| Component | Deployed Version | Upstream Latest | Health Status | Subsystem Notes |
| :--- | :---: | :---: | :---: | :--- |
| **OpenCore UEFI Bootloader** | `1.0.8` | `1.0.8` | 🟢 Current | Verified schema compliant with OpenCore 1.0.8. Quirks tuned for HP InsydeH2O MAT. |
| **WhateverXe Intel Xe-LP GPU** | `0.7.0` | `0.8.0` | ℹ️ Upstream: 0.8.0 | Metal 2 hardware acceleration & Quartz Extreme active. DVMT 60MB stolen memory injected. |
| **Lilu Kernel Patcher** | `1.7.2` | `1.7.2` | 🟢 Current | Base kext patcher framework operating as primary kernel dependency. |
| **Realtek ALC287 Audio Codec** | `1.9.8` | `1.9.8` | 🟢 Current | Layout-ID 13 active over Intel SST/cAVS controller (8086:A0C8) with SimpleHDA. |
| **Intel Wi-Fi 6 AX201 Native** | `2.4.0` | `Checked` | ℹ️ Upstream: Checked | Native Apple Control Center and Menu Bar Wi-Fi integration via AirportItlwm. |
| **Intel AX201 Bluetooth 5.0** | `2.5.0` | `v2.4.0` | ℹ️ Upstream: v2.4.0 | HCI firmware upload & BlueToolFixup active for seamless Bluetooth pairing. |
| **ELAN0722 Precision Trackpad** | `2.9.1` | `v2.9.1` | 🟢 Current | 120Hz polling enforced (-vi2c-force-polling) with multi-touch gestures and touchscreen. |
| **VirtualSMC & Battery Monitor** | `1.3.8` | `1.3.8` | 🟢 Current | Apple SMC emulation with ECEnabler for 3-cell 43Wh battery percentage readings. |
| **Intel Tiger Lake VMD NVMe** | `1.0.0` | `Checked` | ℹ️ Upstream: Checked | Western Digital SN530 NVMe block storage powered via VMD controller 8086:9A0B. |

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

*This document is automatically updated daily with 10 verified contributions by macOS maintenance agents.*
