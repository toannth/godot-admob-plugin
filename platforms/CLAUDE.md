# 🏗️ Platforms Context (Claude)

## Android (`platforms/android`)
- **Build:** Use `./gradlew`.
- **Logic:** JNI/Kotlin bridges.
- **Config:** Managed by `platforms/godot_editor/addons/admob/android/config.gd`.

## iOS (`platforms/ios`)
- **Build:** Use `scons`.
- **Logic:** Swift/Obj-C wrappers.
- **Deps:** Uses SPM (Swift Package Manager).

## Godot Editor (`platforms/godot_editor`)
- This is where the plugin resides during development.
- The real `addons/admob` folder is here.
