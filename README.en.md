# Uncensored Local AI — Offline Local AI Chat

[繁體中文](README.md)

A cross-platform local AI chat application built with Flutter and `llamadart`／`llama.cpp`. GGUF models run on your own computer or Android device without a paid cloud AI API.

> This project is a customized version based on [techjarves/Uncensored-Local-AI-Multiplatform](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform).

## Features

- Download, import, load, switch, and unload GGUF models
- Windows, Android, macOS, and Linux support
- CPU, Vulkan, OpenCL, and CUDA backends when supported
- Adjustable GPU Layers, context size, and temperature
- Token/s, model loading progress, and runtime status
- Local chat history storage
- Traditional Chinese response enforcement and a global system prompt
- UI languages: Traditional Chinese, English, Japanese, Korean, Spanish, French, and German
- Optional localhost OpenAI-compatible API

## Differences from upstream

| Area | Upstream | This version |
|---|---|---|
| UI languages | Original UI language | Adds multiple UI languages and Traditional Chinese support |
| Hardware settings | Basic configuration | CPU／Vulkan／OpenCL／CUDA and GPU Layers |
| Context | Fewer controls | 2048, 4096, and 8192 options |
| Model lifecycle | Basic loading flow | Releases native inference resources when switching models |
| Output handling | Basic output | Removes common Chat Template control markers |
| Remote services | Upstream-dependent | No VPS, Nexus, Tailscale, Bearer API, or SearXNG deployment |

The optional API listens on `127.0.0.1` by default and is intended for tools on the same device.

## Supported models

The built-in model catalog is located at [`assets/models_catalog.json`](assets/models_catalog.json). Sizes are approximate and depend on the selected quantization.

| Model | Approx. size | Minimum RAM | Best for |
|---|---:|---:|---|
| Gemma 2 2B | 1.6 GB | 4 GB | Lower-memory devices and fast replies |
| Gemma 4 E4B Heretic | 5.3 GB | 8 GB | Higher-quality local conversations |
| Dolphin 2.9 Llama 3 8B | 4.9 GB | 8 GB | Roleplay and open-ended responses |
| Phi-3.5 Mini 3.8B | 2.2 GB | 4 GB | Lightweight, fast local inference |

Actual performance depends on quantization, system RAM, VRAM, backend, GPU Layers, and context size.

## Downloads

Download prebuilt artifacts from [GitHub Releases](https://github.com/yogaliu0818/Uncensored-Local-AI-Multiplatform/releases):

- Windows x64: extract the ZIP and run `portable_ai_flutter.exe`
- Android: choose ARM64, ARMv7, or x86_64 according to your device
- macOS: extract the ZIP and open the app
- Linux x64: extract the `.tar.gz` bundle and run the application inside it

## Build from source

You need the Flutter SDK. Windows desktop builds additionally require Visual Studio 2022 with **Desktop development with C++**. Android builds require the Android SDK.

```powershell
git clone https://github.com/yogaliu0818/Uncensored-Local-AI-Multiplatform.git
cd Uncensored-Local-AI-Multiplatform
flutter pub get

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

## First launch

1. Open the app and go to **Models**.
2. Download or import a GGUF model.
3. Select **Load Model**, then return to chat.
4. Open **Settings → Language** to select the UI language.
5. Use **Language & Context** to enable Traditional Chinese replies or adjust context size.
6. Use **Hardware Configuration** to select the backend and GPU Layers.

## Hardware guidance

- Lower-memory devices: start with Gemma 2 2B or Phi-3.5 Mini 3.8B.
- RTX 3050 Laptop 6 GB: try Vulkan with 4B–8B Q4 models; start around 20–33 GPU Layers.
- Android devices: start with a smaller model and a 2048／4096 context.
- If loading fails or the app crashes, lower GPU Layers, switch to CPU, or reduce context size.
- Larger context retains more conversation but uses more RAM／VRAM and can reduce speed.

## Local API

Load a model, then enable **Settings → Local API Server**. The default base URL is:

```text
http://127.0.0.1:4891/v1
```

This project does not provide remote deployment configuration. Review your firewall and network security settings before enabling external connections.

## Troubleshooting

### Tokenization failed or prompt too long

Reduce context size, start a new chat, or use a smaller model.

### Windows cannot find the Visual Studio toolchain

Install **Desktop development with C++** through Visual Studio Installer, then run `flutter doctor -v`.

### Building with plugins requires symlink support

Enable Windows Developer Mode:

```powershell
start ms-settings:developers
```

## Development checks

```powershell
flutter analyze
flutter test
flutter build windows --release
```

## License

This project follows the upstream MIT License. Model weights may have separate licenses; review the model source before use.

## Credits

- [Upstream project](https://github.com/techjarves/Uncensored-Local-AI-Multiplatform)
- [Flutter](https://flutter.dev/)
- [llama.cpp](https://github.com/ggml-org/llama.cpp)
- [llamadart](https://pub.dev/packages/llamadart)
