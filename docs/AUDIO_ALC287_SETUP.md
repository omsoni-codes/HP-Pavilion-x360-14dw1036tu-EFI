# 🔊 Realtek ALC287 Audio & Microphone Setup
### Tuning B&O Speakers over Intel Smart Sound Technology (cAVS)
**Author:** [Om Soni (omsoni-codes)](https://github.com/omsoni-codes)

---

## 🎧 Audio Subsystem Details
* **Audio Codec**: Realtek ALC287 (`0x10EC0287`)
* **Audio Controller**: Intel Smart Sound Technology cAVS / SST (`8086:A0C8`)
* **Speakers**: Dual Bang & Olufsen (B&O) tuned stereo speakers
* **Microphone**: Integrated dual-array digital microphones

---

## 🛠️ OpenCore Implementation
1. **Layout ID**: Injected `alcid=13` in `boot-args` (Layout ID `13`).
2. **Kexts Deployed**:
   * `AppleALC.kext` (v1.9.8) - Codec patches for ALC287
   * `SimpleHDA.kext` (v1.0.1) - Initializes Intel Tiger Lake cAVS controller
3. **Features Verified**:
   * Internal stereo speaker output
   * Automatic 3.5mm headphone jack detection and switching
   * Dual-array digital microphone input for Siri, FaceTime, and conferencing
