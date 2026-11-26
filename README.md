# 無審核破甲模型

[English](README.en.md)

使用 Flutter 與 `llamadart`／`llama.cpp` 建立的跨平台本機 AI 聊天程式。模型以 GGUF 格式在自己的電腦或 Android 手機上執行，不需要付費雲端 AI API。

> 本專案是基於 [techjarves/Uncensored-Local-AI-Multiplatform](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform) 的客製版本。

## 功能

- GGUF 模型下載、匯入、載入、切換與卸載
- Windows、Android、macOS、Linux
- CPU、Vulkan、OpenCL 與 CUDA backend（依平台與驅動支援情況）
- GPU Layers、上下文長度與 Temperature 調整
- Token/s、模型載入進度與狀態顯示
- 聊天記錄儲存在本機
- 繁體中文強制回覆與全域 System Prompt
- 介面語言：繁體中文、英文、日文、韓文、西班牙文、法文、德文
- 可選的 localhost OpenAI 相容 API

## 與原版的差異

| 項目 | 原版 | 本版本 |
|---|---|---|
| 介面語言 | 主要依原始介面 | 新增多語系與繁體中文體驗 |
| 硬體設定 | 基本設定 | CPU／Vulkan／OpenCL／CUDA 與 GPU Layers |
| 上下文 | 設定較少 | 可調整 2048、4096、8192 |
| 模型生命週期 | 基本載入流程 | 切換模型時釋放原生推理資源 |
| 輸出處理 | 基本輸出 | 清理常見 Chat Template 控制標記 |
| 遠端服務 | 依原版功能 | 不包含 VPS、Nexus、Tailscale、Bearer API 或 SearXNG 部署 |

本版本的 API 預設只監聽 `127.0.0.1`，供同一台裝置上的本機工具使用。

## 支援模型

內建模型清單位於 [`assets/models_catalog.json`](assets/models_catalog.json)。模型大小為約略值，實際下載檔案大小依量化版本而定。

| 模型 | 約略大小 | 最低 RAM | 適合用途 |
|---|---:|---:|---|
| Gemma 2 2B | 1.6 GB | 4 GB | 記憶體較少、快速回覆 |
| Gemma 4 E4B Heretic | 5.3 GB | 8 GB | 較高品質的本機對話 |
| Dolphin 2.9 Llama 3 8B | 4.9 GB | 8 GB | 角色扮演與較開放的回答風格 |
| Phi-3.5 Mini 3.8B | 2.2 GB | 4 GB | 輕量、快速回覆 |

實際效能取決於量化格式、系統 RAM、顯存、GPU backend、GPU Layers 與上下文長度。

## 支援平台與下載

前往 [GitHub Releases](https://github.com/yogaliu0818/Uncensored-Local-AI-Multiplatform/releases) 下載：

- Windows x64：解壓縮 ZIP 後執行 `portable_ai_flutter.exe`
- Android：依手機 CPU 選擇 ARM64、ARMv7 或 x86_64 APK
- macOS：解壓縮 ZIP 後開啟 App
- Linux x64：解壓縮 `.tar.gz` 後執行 bundle 中的程式

## 從原始碼建置

需要 Flutter SDK。Windows 桌面版另外需要 Visual Studio 2022 的 **Desktop development with C++**；Android 需要 Android SDK。

```powershell
git clone https://github.com/yogaliu0818/Uncensored-Local-AI-Multiplatform.git
cd Uncensored-Local-AI-Multiplatform
flutter pub get
```

```powershell
# Windows
flutter run -d windows
flutter build windows --release

# Android
flutter devices
flutter run -d <device-id>
flutter build apk --release --split-per-abi
```

```bash
# macOS / Linux
flutter pub get
flutter build macos --release
flutter build linux --release
```

## 第一次使用

1. 開啟 App，進入 **Models／模型**。
2. 下載或匯入 GGUF 模型。
3. 點擊 **Load Model／載入模型**，回到聊天頁。
4. 到 **Settings／設定 → Language／介面語言** 選擇語言。
5. 到 **Language & Context／語言與上下文** 開啟強制繁體中文或調整上下文。
6. 到 **Hardware Configuration／硬體設定** 選擇 backend 與 GPU Layers。

## 模型與硬體建議

- 記憶體較少：先使用 Gemma 2 2B 或 Phi-3.5 Mini 3.8B。
- RTX 3050 Laptop 6 GB：4B～8B Q4 模型可先嘗試 Vulkan，GPU Layers 從 20～33 開始。
- 手機：先使用較小模型與 2048／4096 上下文。
- 載入失敗或閃退：降低 GPU Layers、改用 CPU 或降低上下文長度。
- 上下文越大，能保留的對話越多，但會增加 RAM／VRAM 使用量並降低速度。

## 本機 API

載入模型後，在 **Settings → Local API Server** 開啟。預設網址：

```text
http://127.0.0.1:4891/v1
```

本專案不提供遠端部署設定；若開啟外部連線，請自行確認防火牆與網路安全。

## 常見問題

### Tokenization failed or prompt too long

降低上下文長度、建立新對話，或改用較小模型。

### Windows 找不到 Visual Studio toolchain

在 Visual Studio Installer 安裝 **Desktop development with C++**，再執行：

```powershell
flutter doctor -v
```

### Building with plugins requires symlink support

開啟 Windows Developer Mode：

```powershell
start ms-settings:developers
```

## 開發驗證

```powershell
flutter analyze
flutter test
flutter build windows --release
```

## 授權

本專案沿用原始專案的 MIT License。模型權重可能有各自授權條款，請查看模型來源頁面。

## 致謝

- [原始專案](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform)
- [Flutter](https://flutter.dev/)
- [llama.cpp](https://github.com/ggml-org/llama.cpp)
- [llamadart](https://pub.dev/packages/llamadart)
