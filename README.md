# HP Pavilion x360 Convertible 14-dw1036tu macOS Tahoe & Sequoia OpenCore EFI
### Ultra-Optimized, Hardware-Tailored EFI with Full Metal 2 Graphics Acceleration & Native Wi-Fi

[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.8_RELEASE-blue.svg?style=for-the-badge&logo=apple)](https://github.com/acidanthera/OpenCorePkg)
[![macOS Tahoe](https://img.shields.io/badge/macOS-Tahoe_26.x-green.svg?style=for-the-badge&logo=apple)](https://www.apple.com/macos)
[![macOS Sequoia](https://img.shields.io/badge/macOS-Sequoia_15.x-teal.svg?style=for-the-badge&logo=apple)](https://www.apple.com/macos)
[![Architecture](https://img.shields.io/badge/Architecture-Intel_Tiger_Lake--U-orange.svg?style=for-the-badge&logo=intel)](https://ark.intel.com)
[![Graphics](https://img.shields.io/badge/Graphics-Intel_Xe--LP_Metal_2-red.svg?style=for-the-badge&logo=intel)](https://github.com/b00t0x/WhateverXe)
[![Wi-Fi](https://img.shields.io/badge/Wi--Fi-Intel_AX201_Native-brightgreen.svg?style=for-the-badge&logo=wi-fi)](https://github.com/OpenIntelWireless/itlwm)
[![License](https://img.shields.io/badge/License-MIT-purple.svg?style=for-the-badge)](LICENSE)

**Author:** [Vihaan Nathan (linuxkid473)](https://github.com/linuxkid473)  
**Target Hardware:** HP Pavilion x360 Convertible 14-dw1036tu (Board ID: `087F4`, InsydeH2O BIOS)  
**Status:** 100% Fully Customized, Daily-Driver Production Quality

---

## 📖 Overview

This repository hosts the complete, fully tailored, and ultra-optimized **OpenCore 1.0.8** EFI for running **macOS Tahoe (26.x)** and **macOS Sequoia (15.x)** on the **HP Pavilion x360 Convertible 14-dw1036tu** laptop.

Tiger Lake 11th Gen laptops are notoriously difficult to configure for macOS due to the lack of native Apple driver support for Intel Xe-LP graphics, complex Intel Volume Management Device (VMD) storage topologies, missing XCPM Comet Lake MSRs causing early kernel panics, and HP InsydeH2O defective Memory Attribute Tables (MAT).

Through exhaustive low-level hardware debugging, custom ACPI table synthesis, memory collision mapping, and driver integration, this EFI achieves a **complete, production-ready macOS environment** where every single integrated component works seamlessly.

---

## 💻 Hardware Specifications

| Component | Hardware Details | Subsystem / Device ID | macOS Driver / Solution |
| :--- | :--- | :--- | :--- |
| **Laptop Model** | HP Pavilion x360 Convertible 14-dw1036tu | Product ID: `2R2H3PA#ACJ` | Board ID: `087F4` (InsydeH2O UEFI) |
| **Processor (CPU)** | Intel Core i3-1115G4 (Tiger Lake-U, Willow Cove)<br>2 Cores, 4 Threads, Base 3.00 GHz, Boost up to 4.10 GHz | Family 6 Model 140 Stepping 1<br>(CPUID: `0x0806C1`) | Spoofed Comet Lake (`0x0906EA`)<br>`AppleXcpmExtraMsrs` + `SSDT-PLUG` |
| **Integrated GPU** | Intel UHD Graphics for 11th Gen Intel Processors<br>(Xe-LP architecture, 48 Execution Units) | `8086:9A78` (PCI `00:02.0`)<br>Subsys: `103C:87F4` | `WhateverXe.kext` (v0.7.0) + `AMFIPass.kext`<br>Full Metal 2 Acceleration |
| **Memory (RAM)** | 8 GB DDR4-3200 MHz SDRAM | Dual Channel (2x 4 GB) | Fully native, memory map patched |
| **Storage (SSD)** | 256 GB Western Digital PC SN530 NVMe SSD<br>(behind Intel Tiger Lake VMD Controller) | Controller: `8086:9A0B`<br>(PCI `00:0e.0`) | `IntelVMD.kext` (v1.0.0)<br>Native NVMe Block Storage |
| **Display Panel** | 14" Full HD (1920x1080) IPS Multi-touch<br>Micro-edge, 250 nits, 45% NTSC | Panel ID: `BOE089D`<br>(Model: `NV140FHM-N4V`) | `SSDT-PNLF.aml` (Backlight)<br>`BrightnessKeys.kext` |
| **Audio Codec** | Realtek ALC287 (`0x10EC0287`)<br>on Intel SST / cAVS Controller | Controller: `8086:A0C8`<br>(PCI `00:1f.3`) | `AppleALC.kext` (`alcid=13`)<br>+ `SimpleHDA.kext` (v1.0.1) |
| **Wireless LAN** | Intel Wi-Fi 6 AX201 160MHz (2x2 MIMO) | `8086:A0F0` (CNVi) | `AirportItlwm.kext` (v2.4.0)<br>Native Apple Wi-Fi Menu Bar |
| **Bluetooth** | Intel AX201 Bluetooth 5.0 / 5.2 HCI | `8087:0026` (USB) | `IntelBluetoothFirmware` + `IntelBTPatcher`<br>+ `BlueToolFixup` |
| **Precision Trackpad** | ELAN0722 Precision Multi-Touch Touchpad | LPSS I2C0 (`8086:A0E8`) | `VoodooI2C.kext` + `VoodooI2CHID.kext`<br>`-vi2c-force-polling` (120Hz) |
| **Touchscreen** | Multi-touch Capacitive Digitizer | LPSS I2C0 Bus | `VoodooI2CHID.kext` (Native Touch) |
| **Keyboard** | HP Full-size Backlit Keyboard & Fn hotkeys | PS/2 & ACPI Events | `VoodooPS2Controller.kext` |
| **Battery Management** | HP 3-cell 43 Wh Li-ion (`KB03043XL`) | ACPI Embedded Controller | `ECEnabler.kext` + `SMCBatteryManager.kext` |
| **Webcam** | HP TrueVision 720p HD Camera | USB UVC (`0408:5424`) | Out-of-the-box native support |
| **USB Ports** | 1x USB-C 3.2 Gen 2 (10Gbps, DP, PD)<br>2x USB-A 3.2 Gen 1 (5Gbps) | Intel Tiger Lake PCH USB | `SSDT-EC-USBX-LAPTOP.aml` + `SSDT-RHUB.aml` |

---

## ⚡ Working Hardware Subsystems

| Subsystem | Status | Verification & Notes |
| :--- | :---: | :--- |
| **Intel Xe-LP Metal 2 GPU** | 🟢 **WORKING** | Full Metal 2 acceleration, Quartz Extreme, VideoToolbox HW decode/encode, butter-smooth desktop and animations. |
| **Display Backlight & Brightness** | 🟢 **WORKING** | Native macOS brightness slider in Control Center and Fn+F2 / Fn+F3 keys working smoothly via `SSDT-PNLF.aml`. |
| **Realtek ALC287 Audio Output** | 🟢 **WORKING** | Crystal clear stereo audio through internal B&O tuned speakers and automatic 3.5mm headphone jack switching (`alcid=13`). |
| **Internal Microphone** | 🟢 **WORKING** | Dual-array digital microphone input active with high clarity for Siri, FaceTime, and conferencing. |
| **Native Wi-Fi 6 (AX201)** | 🟢 **WORKING** | Native Apple Wi-Fi control center and menu bar integration without needing third-party helper apps (`AirportItlwm`). |
| **Bluetooth 5.0** | 🟢 **WORKING** | Native Bluetooth toggle in System Settings, peripheral pairing, audio streaming, and AirDrop reception. |
| **ELAN0722 Precision Trackpad** | 🟢 **WORKING** | Native multi-touch gestures (two-finger scroll, pinch to zoom, three-finger swipe) polled at 120Hz for zero latency. |
| **Touchscreen Digitizer** | 🟢 **WORKING** | 10-point capacitive multi-touch digitizer operates directly in macOS for touch navigation and drawing. |
| **Storage (WD SN530 NVMe)** | 🟢 **WORKING** | Full read/write NVMe speeds behind the Intel Tiger Lake VMD controller (`8086:9A0B`) using `IntelVMD.kext`. |
| **Battery Level & Health** | 🟢 **WORKING** | Live battery percentage, charging state, AC power detection, and cycle count via `ECEnabler` + `SMCBatteryManager`. |
| **CPU Power Management** | 🟢 **WORKING** | Native Intel Speed Shift, full dynamic frequency scaling (800 MHz idle to 4.10 GHz boost), C-states down to C10 via `SSDT-DeepIdle`. |
| **Deep Sleep & Instant Wake** | 🟢 **WORKING** | Instant wake on lid open or key press. Locked `sleepimage` eliminates post-sleep corruption. |
| **HP TrueVision HD Camera** | 🟢 **WORKING** | Native 720p 30fps video in FaceTime, Zoom, and Photo Booth. |
| **USB-C & USB-A Ports** | 🟢 **WORKING** | All USB 3.2 Gen 2 and Gen 1 ports deliver correct bus power and speeds. |

---

## 🔬 Breakthrough Discoveries & Technical Architecture

### 1. The KASLR Memory Collision Resolution (`slide=33`)
* **The Symptom**: Intermittent freezes on `#[EB|LOG:EXITBS:START]` during boot.
* **The Discovery**: Through meticulous line-by-line diffing of failed SSD boot logs (`opencore-2026-11-07-154642.txt`) versus successful USB boots (`opencore-2026-11-07-154731.txt`), both logs were found to be completely identical up to the KASLR slide:
  - **Failed Boot**: Booter randomly picked `slide=7`, placing the kernel at physical address `0x00F00000` (15 MB).
  - **The Hardware Conflict**: HP's InsydeH2O BIOS reserves the physical memory window between 16 MB and 32 MB for iGPU stolen memory and SMM runtime. When macOS allocates kernel memory within this window, the CPU crashes immediately upon `ExitBootServices`.
  - **The Fix**: OpenCore's `boot-args` permanently locks `slide=33`. This forces the kernel base address to physical `0x04300000` (67 MB RAM), completely clearing HP's hardware reservation zone forever.

### 2. Early XCPM Comet Lake CPUID Emulation & Missing Willow Cove MSRs
* **The Architecture**: Because Tiger Lake Willow Cove cores are not natively supported by macOS XNU, OpenCore emulates a 10th Gen Comet Lake CPU (`0x0906EA`).
* **The Failure**: During early kernel initialization (`i386_init()`), macOS's XCPM power management queries Comet Lake model-specific registers (`0x198`, `0x199`, `0x1AA`). Because these registers do not exist on physical 10nm Tiger Lake silicon, the CPU throws an unhandled General Protection Fault (`#GP`) before console output initializes.
* **The Solution**: Enabling `AppleXcpmExtraMsrs: True` in OpenCore's `Kernel -> Quirks` intercepts and satisfies these missing MSR reads, allowing XCPM to bootstrap smoothly without crashing.

### 3. HP InsydeH2O Defective Memory Attribute Table (MAT) Quirks
* **The Challenge**: Standard modern OpenCore guides recommend `RebuildAppleMemoryMap: True` with `SyncRuntimePermissions: True`.
* **The Reality on HP**: The InsydeH2O BIOS (Rev. 087F4) supplies a defective Memory Attribute Table (MAT) to the OS. If `RebuildAppleMemoryMap` is enabled, OpenCore builds a corrupt memory map and freezes at `ExitBootServices`.
* **The Tailored Quirks**:
  - `EnableWriteUnprotector: True` (uses CR0 write protection bypass)
  - `RebuildAppleMemoryMap: False`
  - `ProtectUefiServices: False`
  - `SetupVirtualMap: True`
  - `SyncRuntimePermissions: True`
  - `ProvideCustomSlide: True`

### 4. Intel Tiger Lake VMD Storage Architecture (`8086:9A0B`)
* **The Trap**: On this HP motherboard, the M.2 NVMe slot is directly hardwired to the Tiger Lake Volume Management Device (VMD) controller (`8086:9A0B` at PCI `00:0e.0`).
* **Why AHCI / VMD-off Fails**: Modifying BIOS registers to disable VMD (`Setup:0x500=0x00`) cuts reference clocks and power to the M.2 NVMe slot, causing the Western Digital SN530 drive to completely vanish from the PCI bus.
* **The Solution**: Keep VMD enabled in BIOS NVRAM (`Setup:0x500=0x02`, `Setup:0x501=0x01`, `SaSetup:0x415..0x418=0x01`) and load `IntelVMD.kext` (v1.0.0). `IntelVMD.kext` communicates directly with the VMD controller, providing high-throughput NVMe block storage to macOS.

### 5. WhateverXe Metal 2 Acceleration & Stolen Memory Patching
* **Framework**: Uses `WhateverXe.kext` (v0.7.0 RELEASE) paired with `AMFIPass.kext` (v1.4.1) to adapt the Intel Xe-LP graphics pipeline into macOS graphics frameworks.
* **Stolen Memory**: HP BIOS locks DVMT Pre-Allocated at 60MB. This EFI injects `framebuffer-patch-enable` (`01000000`) and `framebuffer-stolenmem` (`0000C003`) under `PciRoot(0x0)/Pci(0x2,0x0)` alongside `-igfxdvmt` in `boot-args` for proper frame allocation.

### 6. Realtek ALC287 on Tiger Lake cAVS/SST Controller
* **Audio Routing**: Realtek ALC287 is connected over Intel's Smart Sound Technology cAVS audio controller (`8086:A0C8`).
* **The Solution**: Injected `alcid=13` (Layout ID `13`) through `boot-args`, paired with `AppleALC.kext` and `SimpleHDA.kext` (v1.0.1) for crystal clear sound output and active digital microphones.

### 7. ELAN0722 120Hz Precision Trackpad
* **Bus Integration**: The trackpad connects over Intel LPSS I2C0 (`8086:A0E8`).
* **Optimization**: Driven by `VoodooI2C.kext` and `VoodooI2CHID.kext` with `SSDT-GPI0.aml` and `SSDT-XOSI.aml`. Adding `-vi2c-force-polling` enables smooth 120Hz polling, eliminating all micro-stutters.

---

## 📂 Repository File Tree

```text
HP-Pavilion-x360-14dw1036tu-EFI/
├── EFI/
│   ├── BOOT/
│   │   └── BOOTx64.efi                 # Primary OpenCore 1.0.8 UEFI binary
│   ├── Microsoft/
│   │   └── Boot/
│   │       └── bootmgfw.efi            # HP InsydeH2O BIOS standalone boot disguise
│   └── OC/
│       ├── ACPI/
│       │   ├── SSDT-ALS0.aml           # Dummy Ambient Light Sensor
│       │   ├── SSDT-AWAC.aml           # Legacy RTC Clock Enabler
│       │   ├── SSDT-DMAC.aml           # Direct Memory Access Controller
│       │   ├── SSDT-DeepIdle.aml       # Tiger Lake S0ix Deep Idle & Sleep
│       │   ├── SSDT-EC-USBX-LAPTOP.aml # Fake Embedded Controller & USB Power
│       │   ├── SSDT-GPI0.aml           # LPSS GPIO Pinning for Trackpad
│       │   ├── SSDT-MCHC.aml           # Memory Controller Hub
│       │   ├── SSDT-MEM2.aml           # Memory Controller Range Fix
│       │   ├── SSDT-PLUG-_SB.PR00.aml  # X86PlatformPlugin Power Management
│       │   ├── SSDT-PMCR.aml           # Power Management Controller Register
│       │   ├── SSDT-PNLF.aml           # Native eDP Display Backlight Control
│       │   ├── SSDT-PPMC.aml           # Platform Power Management Controller
│       │   ├── SSDT-RHUB.aml           # USB Root Hub Reset
│       │   └── SSDT-XOSI.aml           # Windows 10/11 OS Interface Spoofing
│       ├── Drivers/
│       │   ├── HfsPlus.efi             # High-performance HFS+ filesystem driver
│       │   ├── OpenCanopy.efi          # GoldenGate Graphical Boot Picker GUI
│       │   ├── OpenRuntime.efi         # Core OpenCore Runtime Protocol
│       │   └── ResetNvramEntry.efi     # Reset NVRAM Boot Menu Entry
│       ├── Kexts/
│       │   ├── Lilu.kext               # Base Kernel Extension Patcher
│       │   ├── WhateverXe.kext         # Intel Xe-LP Metal 2 GPU Driver
│       │   ├── AMFIPass.kext           # AMFI Entitlement Bypass for WhateverXe
│       │   ├── VirtualSMC.kext         # Apple SMC Emulator
│       │   ├── SMCProcessor.kext       # CPU Temperature & Frequency Monitor
│       │   ├── SMCBatteryManager.kext  # Live Battery & Power Monitoring
│       │   ├── ECEnabler.kext          # Non-standard ACPI EC Fields Fix
│       │   ├── AppleALC.kext           # Realtek ALC287 Codec Driver
│       │   ├── SimpleHDA.kext          # Tiger Lake cAVS Audio Controller Fix
│       │   ├── AutoPkgInstaller.kext   # Automatic Driver Package Installer
│       │   ├── BrightnessKeys.kext     # Keyboard Brightness Hotkey Handler
│       │   ├── IntelVMD.kext           # Intel Tiger Lake VMD Storage Driver
│       │   ├── VoodooPS2Controller.kext# PS/2 Keyboard Driver
│       │   ├── VoodooI2C.kext          # I2C Core Bus Engine
│       │   ├── VoodooI2CHID.kext       # Multi-Touch Trackpad & Screen Driver
│       │   ├── AirportItlwm.kext       # Intel AX201 Native Wi-Fi Driver
│       │   ├── IntelBluetoothFirmware  # AX201 Bluetooth Firmware Uploader
│       │   ├── IntelBTPatcher.kext     # Bluetooth Stack Patcher
│       │   └── BlueToolFixup.kext      # macOS 12+ Bluetooth Subsystem Fixup
│       ├── Resources/                  # GoldenGate GUI Icons, Audio, and Fonts
│       ├── Tools/
│       │   ├── OpenShell.efi           # Interactive UEFI Diagnostic Shell
│       │   ├── RU.efi                  # InsydeH2O BIOS NVRAM Register Editor
│       │   └── setup_var.efi           # Direct NVRAM Variable Modification Tool
│       ├── OpenCore.efi                # OpenCore Core Engine
│       └── config.plist                # Fully Validated Master Configuration
├── dumped_vars/
│   ├── AllVars.bin                     # Complete HP InsydeH2O NVRAM Variable Dump
│   ├── SaSetup.bin                     # System Agent Setup NVRAM Table
│   └── Setup.bin                       # BIOS Main Setup NVRAM Table
├── WhateverXe-PostInstall/
│   ├── AutoPkg-Assets.pkg              # Offline Graphics Asset Payload
│   └── WhateverXe-Graphics-0.4.0.pkg   # WhateverXe Metal 2 Post-Installer
├── INSTALL_MASTER_EFI_TO_SSD.sh        # One-Click Internal SSD EFI Deployer
├── prepare_usb.sh                      # Interactive Bootable USB Creation Tool
├── update_usb_config.sh                # Fast USB EFI Synchronizer
├── startup.nsh                         # UEFI Shell Automated VMD Enabler Script
├── vmd_on.nsh                          # UEFI Shell Script: Enable Intel VMD
├── vmd_off.nsh                         # UEFI Shell Script: Disable Intel VMD
└── README.md                           # Comprehensive Documentation
```

---

## ⚙️ BIOS / UEFI Setup Instructions

Power on your HP Pavilion x360 and immediately tap **F10** repeatedly to enter the InsydeH2O BIOS Setup Utility.

### Required Settings:
* **Configuration / Security**:
  * **Secure Boot**: `Disabled` *(Critical)*
  * **Virtualization Technology (VT-x)**: `Enabled`
* **System Configuration**:
  * **Fast Boot**: `Disabled`
  * **USB Boot**: `Enabled`
  * **Network Boot / PXE**: `Disabled`
* Save and exit (**F10** -> Yes).

### Intel VMD Storage Mode Verification:
Intel VMD **must remain enabled** so the Western Digital NVMe drive is powered. If you previously experimented with disabling VMD, you can restore it in two seconds:
1. Boot into OpenCore and choose **UEFI Shell**.
2. Run `vmd_on.nsh` or type:
   ```text
   setup_var.efi Setup:0x500=0x02
   setup_var.efi Setup:0x501=0x01
   setup_var.efi SaSetup:0x415=0x01
   ```
3. Type `reset` to reboot.

---

## 🚀 Installation Walkthrough

### Step 1: Create the macOS Installer USB
1. Download macOS Sequoia or Tahoe via Apple's official `InstallAssistant.pkg`.
2. Insert a 16 GB+ USB flash drive into your Mac.
3. Open Terminal, navigate to this repository, and run the automated preparation tool:
   ```bash
   cd HP-Pavilion-x360-14dw1036tu-EFI
   sudo ./prepare_usb.sh
   ```
4. Choose **Option 1** if you already created the installer media and simply want to flash the Master EFI, or **Option 2** for complete automated media creation.

### Step 2: Install macOS
1. Plug the USB flash drive into your HP Pavilion x360.
2. Power on the laptop and tap **F9** repeatedly to open the HP Boot Device Menu.
3. Select your USB drive. OpenCore GoldenGate GUI will load.
4. Select **Install macOS Sequoia** (or **Install macOS Tahoe**).
5. Open **Disk Utility**, select **View -> Show All Devices**, format your target internal NVMe SSD as **APFS** with **GUID Partition Map**.
6. Follow standard macOS installation prompts. The laptop will restart multiple times; continue selecting the macOS installer entry from the boot menu until you land at the macOS Setup Assistant.

### Step 3: Standalone Internal SSD Boot Setup
Once you have reached the macOS desktop, you can disconnect the USB flash drive permanently by deploying this EFI directly to your internal NVMe SSD:
1. Open Terminal in macOS.
2. Run the included standalone deployment script:
   ```bash
   sudo ./INSTALL_MASTER_EFI_TO_SSD.sh
   ```
3. The script automatically:
   - Mounts your internal NVMe EFI partition (`/dev/disk0s1`).
   - Copies the full Master EFI.
   - Installs the HP InsydeH2O BIOS disguise (`EFI/Microsoft/Boot/bootmgfw.efi`), ensuring HP firmware directly boots OpenCore without needing boot order adjustments.
   - Configures power management (`hibernatemode: 0`, disables standby/autopoweroff, locks `/var/vm/sleepimage` to prevent post-wake panics).
4. Reboot your laptop without the USB drive. It will boot directly into macOS!

---

## 🛠️ Post-Installation & Troubleshooting

### Q: Why does the screen freeze at `#[EB|LOG:EXITBS:START]`?
> **Answer**: This occurs on Tiger Lake laptops if the KASLR slide collides with HP's reserved stolen memory window, or if `AppleXcpmExtraMsrs` is omitted. This EFI locks `slide=33` and has `AppleXcpmExtraMsrs: True` enabled, completely eliminating this issue. Ensure your NVRAM has been reset (select **Reset NVRAM** in OpenCore boot menu) after modifying boot-args.

### Q: Why does the Western Digital NVMe SSD not show in Disk Utility?
> **Answer**: Ensure Intel VMD is enabled in BIOS NVRAM. If disabled, the M.2 slot loses clock and power. Boot into UEFI Shell and execute `vmd_on.nsh`.

### Q: How do I change audio volume or switch audio outputs?
> **Answer**: Audio is natively bound to layout ID `13`. If you ever need alternative jack routing, change `alcid=13` in `boot-args` to `alcid=11` or `alcid=12`.

---

## 🌟 Credits & Acknowledgments

This project stands on the shoulders of the extraordinary open-source Hackintosh community:

* **[Acidanthera](https://github.com/acidanthera)**: For developing the world-class [OpenCore Bootloader](https://github.com/acidanthera/OpenCorePkg), [Lilu](https://github.com/acidanthera/Lilu), [AppleALC](https://github.com/acidanthera/AppleALC), [VirtualSMC](https://github.com/acidanthera/VirtualSMC), and [VoodooPS2](https://github.com/acidanthera/VoodooPS2).
* **[b00t0x & WhateverXe Team](https://github.com/b00t0x/WhateverXe)**: For the groundbreaking [WhateverXe](https://github.com/b00t0x/WhateverXe) graphics driver that made Intel Xe-LP graphics acceleration possible on macOS.
* **[OpenIntelWireless](https://github.com/OpenIntelWireless)**: For [AirportItlwm](https://github.com/OpenIntelWireless/itlwm) and [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware), enabling native Apple Wi-Fi and Bluetooth on Intel hardware.
* **[Alexandre Da Silva & VoodooI2C Team](https://github.com/VoodooI2C/VoodooI2C)**: For the [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C) and [VoodooI2CHID](https://github.com/VoodooI2C/VoodooI2CHID) drivers powering precision multi-touch trackpad and touchscreen support.
* **[1Revenger1](https://github.com/1Revenger1)**: For [ECEnabler](https://github.com/1Revenger1/ECEnabler), resolving ACPI Embedded Controller 8-bit field restrictions.
* **[laobamac](https://github.com/laobamac)**: For [SimpleHDA](https://github.com/laobamac/SimpleHDA), enabling Tiger Lake cAVS / SST audio controller initialization.
* **[intelosx](https://github.com/intelosx)**: For [IntelVMD](https://github.com/intelosx/IntelVMD), providing native macOS driver support for the Intel Volume Management Device controller.
* **[Dortania](https://dortania.github.io)**: For incredible architectural documentation and guides that make Hackintoshing transparent.
* **[Vihaan Nathan (linuxkid473)](https://github.com/linuxkid473)**: Project architecture, hardware reverse engineering, custom ACPI tables, KASLR memory collision mapping, VMD shell automation, and bespoke EFI integration.

---

## ⚖️ License & Disclaimer

* This repository is released under the [MIT License](LICENSE).
* macOS is a registered trademark of Apple Inc. This repository is intended strictly for personal research, educational experimentation, and non-commercial hardware enablement.
