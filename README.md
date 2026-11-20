# Uncensored Local AI — Offline Edition

以 Flutter 與 llama.cpp/llamadart 建立的跨平台本機 AI 聊天程式。模型以 GGUF 格式載入，在 Windows、Android、macOS 或 Linux 的本機硬體上推理。

本版本專注於本機模型、離線推理與不依賴雲端 AI 帳號。模型下載完成後，聊天內容不需要送到遠端 AI 服務。

> 這是基於原始專案 [techjarves/Uncensored-Local-AI-Multiplatform](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform) 的本機客製版。

## 功能

- GGUF 模型下載、匯入、載入、切換與卸載
- Windows、Android、macOS、Linux Flutter 介面
- CPU、Vulkan、OpenCL 與 CUDA backend 選擇（依平台與驅動支援情況）
- GPU Layers、上下文長度與溫度調整
- 即時 Token/s、載入進度與模型狀態
- 聊天記錄本機保存
- 強制繁體中文選項與全域 System Prompt
- 模型切換時完整釋放原生推理資源
- 自動清理 GGUF 控制標記與異常角色標記
- 可選的 localhost OpenAI 相容 API，僅供同一台電腦上的本機工具使用

## 與原版的差異

| 項目 | 原版 | 本版本 |
|---|---|---|
| 本機聊天 | 基本本機模型聊天 | 保留並改善模型生命週期與錯誤處理 |
| 硬體設定 | 基本 GPU 設定 | 增加 CPU／Vulkan／OpenCL／CUDA 選擇與 Layers 調整 |
| 上下文 | 固定或較少設定 | 可調整 2048、4096、8192，並自動裁切舊對話 |
| 語言 | 依模型自行決定 | 增加繁體中文強制選項與全域 System Prompt |
| 效能資訊 | 有限 | 顯示載入狀態與 Token/s |
| 穩定性 | 基本載入流程 | 切換模型時完整釋放 engine/backend，降低載入失敗機率 |
| 輸出處理 | 基本輸出 | 清除常見 Chat Template 控制標記 |
| 遠端服務 | 依原版功能 | **不包含 VPS、Nexus、Tailscale、Bearer API 或 SearXNG 部署** |

本版本保留的 localhost API 是本機整合用途；預設不對外網卡開放，也不提供遠端部署設定。

## 支援模型

內建模型清單位於 [`assets/models_catalog.json`](assets/models_catalog.json)。目前包含：

| 模型 | 約略大小 | 適合用途 |
|---|---:|---|
| Gemma 2 2B | 1.6 GB | 記憶體較少、快速回覆 |
| Gemma 4 E4B Heretic | 5.3 GB | 較高品質的本機對話 |
| Dolphin 2.9 Llama 3 8B | 4.9 GB | 角色扮演與較開放的回答風格 |
| Phi-3.5 Mini 3.8B | 2.2 GB | 輕量、快速回覆 |

實際效能取決於量化格式、系統 RAM、顯存、GPU backend、GPU Layers 與上下文長度。

## Windows 安裝

### 必要環境

1. Windows 10 或 Windows 11
2. [Flutter SDK](https://docs.flutter.dev/get-started/install/windows)
3. Visual Studio 2022 或更新版本
4. Visual Studio Installer 中勾選 **Desktop development with C++**
5. 啟用 Windows Developer Mode，以支援 Flutter plugin symlink

確認環境：

```powershell
flutter doctor -v
```

### 從原始碼執行

```powershell
git clone https://github.com/yogaliu0818/Uncensored-Local-AI-Multiplatform.git
cd Uncensored-Local-AI-Multiplatform
flutter pub get
flutter run -d windows
```

建立 Windows Release：

```powershell
flutter build windows --release
```

輸出位置：`build\windows\x64\runner\Release\`

## Android 安裝與建置

需要 Flutter SDK、Android SDK、Android Studio 與可用的 Android 裝置或模擬器。

```powershell
flutter pub get
flutter devices
flutter run -d <device-id>
flutter build apk --release
```

模型檔案可能比 APK 大很多，請預留足夠儲存空間與 RAM。手機若載入失敗，先改用較小的 Gemma 2 2B 或降低上下文長度。

## 第一次使用

1. 啟動程式。
2. 開啟 **Models**。
3. 下載或匯入 GGUF 模型。
4. 點擊模型的 **Load**。
5. 回到聊天頁開始對話。
6. 在 **Settings → Hardware Configuration** 選擇 backend 與 GPU Layers。
7. 在 **Settings → Language & Context** 開啟 **Force Traditional Chinese**。

切換模型前，先等待目前模型卸載完成；大型模型需要較長的載入時間。

## 硬體設定建議

### RTX 3050 Laptop 6 GB 顯存

- 4B～8B Q4 模型可以嘗試 Vulkan
- GPU Layers 先從 20～33 開始，再逐步增加
- 若載入失敗或系統開始大量使用虛擬記憶體，降低 Layers 或上下文
- 8B 模型通常比 3.8B 模型慢，但不一定在所有任務都更準

### CPU 模式

CPU 模式相容性最高，但速度通常較慢；適合 Vulkan/OpenCL 初始化失敗時排查問題。

### 上下文長度

上下文越大，能記住的對話越多，但會增加 RAM/VRAM 使用量與速度負擔。建議從 4096 開始。

## 繁體中文與 System Prompt

在設定中開啟 **Force Traditional Chinese**，並可在 **Global System Prompt** 放入：

```text
You must always reply in Taiwanese Traditional Chinese (繁體中文).
Do not answer in English or Simplified Chinese unless the user explicitly requests another language.
```

修改語言設定後建議建立新對話，避免沿用舊對話保存的 System Prompt。

## 本機 API（可選）

本功能只給同一台電腦上的本機工具使用，不包含遠端部署設定。

1. 載入模型。
2. 到 **Settings → Local API Server**。
3. 保持 **Allow External Connections** 關閉。
4. 本機 Base URL 為：

```text
http://127.0.0.1:4891/v1
```

本離線版本不提供手機或其他電腦的遠端連線設定。

## 常見問題

### Unable to find suitable Visual Studio toolchain

安裝 Visual Studio 的 **Desktop development with C++** 工作負載，然後重新執行：

```powershell
flutter doctor -v
```

### Building with plugins requires symlink support

開啟 Windows Developer Mode：

```powershell
start ms-settings:developers
```

### Tokenization failed or prompt too long

降低上下文長度、建立新對話，或改用較小模型。

### 模型載入失敗或速度很慢

- 確認 GPU backend 與驅動支援情況
- 降低 GPU Layers
- 降低上下文長度
- 關閉其他大型程式
- 先用 Phi-3.5 Mini 或 Gemma 2 2B 測試

## 開發驗證

```powershell
flutter pub get
flutter analyze
flutter test
flutter build windows --debug
```

## 授權

本專案沿用原始專案的 MIT License。模型權重可能有各自的授權條款，下載與使用前請查看模型來源頁面。

## 致謝

- 原始專案：[techjarves/Uncensored-Local-AI-Multiplatform](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform)
- Flutter
- llama.cpp
- llamadart
- GGUF 模型作者與量化作者
