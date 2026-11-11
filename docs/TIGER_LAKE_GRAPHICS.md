# 🎨 Intel UHD / Iris Xe Graphics (Xe-LP) on macOS
### WhateverXe & AMFIPass Architectural Deep-Dive
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## 🌟 The Xe-LP Breakthrough
Historically, Intel 11th Gen Tiger Lake graphics lacked native drivers in macOS XNU. **WhateverXe** (v0.7.0 RELEASE) adapts the Intel Xe-LP pipeline to macOS graphics frameworks, delivering:
* **Metal 2 Hardware Acceleration**: Quartz Extreme, desktop compositing, native blur effects, and smooth 60fps animations.
* **VideoToolbox Hardware Acceleration**: HEVC / H.264 video decoding and encoding.
* **Display Backlight Control**: Smooth brightness slider integrated with macOS Control Center.

---

## 🔧 Kernel Loading Sequence
WhateverXe must be loaded in a strict sequential order:
1. `Lilu.kext` (v1.7.2) - Core arbitrary patching framework
2. `WhateverXe.kext` (v0.7.0) - Intel Xe-LP graphics driver
3. `AMFIPass.kext` (v1.4.1) - Entitlement bypass for Xe-LP frameworks

> ⚠️ **Note**: `WhateverGreen.kext` is strictly omitted to prevent driver symbol collisions.

---

## 🛠️ DVMT Stolen Memory Configuration
Because HP BIOS locks DVMT Pre-Allocated memory at 60MB, the following properties are injected under `PciRoot(0x0)/Pci(0x2,0x0)`:
* `framebuffer-patch-enable`: `<01000000>`
* `framebuffer-stolenmem`: `<0000C003>` (60MB stolen memory allocation)
* `boot-args`: `-allow3d -disablegfxfirmware -igfxdvmt igfxonln=1`
