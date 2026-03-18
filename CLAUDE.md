# Godot AdMob Editor Plugin (Claude Context)

## 🏗️ Build Commands
- **Build Android:** `cd platforms/android && ./gradlew assembleDebug`
- **Build iOS:** `cd platforms/ios && scons platform=ios`
- **Clean Build (All):** `./scripts/build_local.sh`

## 📝 Code Style & Logic
- **GDScript:** Use `:=` for type inference. No `class_name` in `addons/admob/internal/`.
- **C#:** Use PascalCase. Follow GDScript API parity.
- **Auto-Hide:** `csharp/` folder is managed by `CSharpService.gd`.

## 🔄 Cross-Platform Sync
When adding or modifying ad formats or bridge methods, you **MUST** follow the multi-platform synchronization protocol:
👉 [Read the Sync Protocol](.github/ai/guides/sync.md)

## 🚫 Workflow Rules
- Never stage or commit changes unless explicitly asked.
- Always check `.claudeignore` to avoid wasting context tokens on build artifacts.
- Reproduce bugs with a script before implementing a fix.
