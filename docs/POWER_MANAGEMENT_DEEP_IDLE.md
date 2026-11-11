# ⚡ CPU Power Management & Instant Lid Wake
### Tiger Lake Speed Shift, S0ix Deep Idle & Locked Sleepimage
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## 🔋 Dynamic Frequency Scaling
* **Processor**: Intel Core i3-1115G4 (Willow Cove)
* **Scaling**: Native Intel Speed Shift from 800 MHz idle to 4.10 GHz boost.
* **Driver**: `X86PlatformPlugin` injected via `SSDT-PLUG-_SB.PR00.aml`.

---

## 💤 S0ix Deep Sleep & Instant Lid Wake
1. `SSDT-DeepIdle.aml` enables hardware C-states down to **C10**.
2. **Instant Lid Wake Settings**:
   ```bash
   sudo pmset -a hibernatemode 0
   sudo pmset -a standby 0
   sudo pmset -a autopoweroff 0
   sudo rm -f /var/vm/sleepimage
   sudo touch /var/vm/sleepimage
   sudo chflags uchg /var/vm/sleepimage
   ```
   Locking `/var/vm/sleepimage` prevents slow disk hibernation writes and guarantees instant wake on lid open.
