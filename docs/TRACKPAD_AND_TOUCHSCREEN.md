# 👆 ELAN0722 Precision Trackpad & Touchscreen
### 120Hz Multi-Touch Gestures over Intel LPSS I2C
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## ⚡ Hardware Integration
* **Trackpad Device**: `ELAN0722` (I2C HID Precision Touchpad)
* **Touchscreen**: 10-Point Capacitive Multi-Touch Digitizer
* **Controller**: Intel LPSS I2C0 Controller (`8086:A0E8`)

---

## 🔧 ACPI & Driver Configuration
1. **ACPI Hotpatches**:
   * `SSDT-GPI0.aml`: Unlocks GPIO pin interrupts on LPSS controller.
   * `SSDT-XOSI.aml`: Spoofs `Windows 10` OS interface calls to ensure HP BIOS routes I2C signals properly.
2. **Kext Drivers**:
   * `VoodooI2C.kext` (v2.9.1)
   * `VoodooI2CHID.kext`
3. **120Hz Polling Optimization**:
   Adding `-vi2c-force-polling` in `boot-args` enforces smooth 120Hz polling, eliminating trackpad micro-stutters and input lag.
