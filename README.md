# RDAK Shaders — Build Workspace

Low-end RenderDragon shader for Minecraft Bedrock Edition (1.21.20+).

## Repo layout

```
tool/
  MaterialBinTool-0.9.1-all.jar   ← pre-built JAR (official v0.9.1)
shader/
  renderer/materials/*.material.bin  ← original compiled shader binaries
  (attachables, textures, fogs …)    ← full resource pack assets
unpacked/
  Clouds/   EndSky/   LegacyCubemap/
  RenderChunk/   Sky/   Stars/   SunMoon/
    ← JSON + raw GLSL extracted from each .material.bin
```

## Material files in this shader

| File | Purpose |
|---|---|
| `RenderChunk.material.bin` | Terrain blocks (opaque, transparent, alpha-test, depth) |
| `Sky.material.bin` | Sky background & atmosphere |
| `Clouds.material.bin` | Cloud rendering |
| `SunMoon.material.bin` | Sun & moon disc |
| `Stars.material.bin` | Star field |
| `EndSky.material.bin` | The End dimension sky |
| `LegacyCubemap.material.bin` | Legacy cubemap fallback |

## Quick commands (requires Java 8+)

```bash
JAR=tool/MaterialBinTool-0.9.1-all.jar

# Unpack a single material.bin → JSON + GLSL
java -jar $JAR -u shader/renderer/materials/RenderChunk.material.bin -o unpacked/RenderChunk

# Repack unpacked directory back into .material.bin
java -jar $JAR -r unpacked/RenderChunk -o shader/renderer/materials/

# Compile .sc source files into .material.bin
java -jar $JAR -c unpacked/RenderChunk -s /path/to/shaderc -o shader/renderer/materials/
```

## Tool reference

```
-u / --unpack     unpack .material.bin → JSON + shaders
-r / --repack     repack directory → .material.bin
-c / --compile    compile .sc sources → .material.bin
-o / --output     output directory
-s / --shaderc    path to shaderc binary (for compile)
-i / --include    extra include dirs (for compile)
-a / --add-flags  add FlagMode comments to output shaders
--raw             output raw bgfx shader files
```

## Supported platforms

| Platform | Shader language |
|---|---|
| Android | ESSL (GLSL ES 1.00 / 3.00) |
| Windows | Direct3D HLSL |
| iOS | Metal |
| Linux/Mac | ESSL via mcpelauncher |

## Original tool

Pre-built JAR sourced from: https://github.com/ddf8196/MaterialBinTool/releases/tag/v0.9.1  
English-translated source: https://github.com/Quoty0/MaterialBinTool-EnglishTranslated
