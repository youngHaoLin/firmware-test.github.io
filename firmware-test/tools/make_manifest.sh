#!/usr/bin/env bash
set -e

VERSION="$1"
BIN="build/firmware.bin"
OUT="build/manifest.json"

# 确保 build/ 存在
mkdir -p build

# 检查固件是否存在
if [ ! -f "$BIN" ]; then
  echo "找不到 $BIN，请先编译并放到 build/ 目录下"
  exit 1
fi

# 计算 SHA256（兼容 Linux / macOS）
if command -v sha256sum >/dev/null 2>&1; then
  SHA=$(sha256sum "$BIN" | cut -d' ' -f1)
else
  SHA=$(shasum -a 256 "$BIN" | cut -d' ' -f1)
fi

# 生成 manifest.json
cat > "$OUT" <<EOF
{
  "version": "$VERSION",
  "url": "https://github.com/youngHaoLin/firmware-test/releases/download/v$VERSION/firmware.bin",
  "sha256": "$SHA"
}
EOF

echo "已生成 $OUT"
