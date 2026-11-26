#!/usr/bin/env bash
# Claude Motion Studio 一键安装：JS 线 + Python 线 + 技能 + Blender
set -e
cd "$(dirname "$0")"

echo "== JS 线（npm，需 --legacy-peer-deps 解决 React 生态 peer 冲突）=="
npm install --legacy-peer-deps --no-audit --no-fund

echo "== Python 线（venv + CPU 版 torch，避免拉 CUDA 全家桶撑爆磁盘）=="
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install torch --index-url https://download.pytorch.org/whl/cpu
.venv/bin/pip install -r requirements.txt

echo "== 技能仓库 =="
cd skills
for r in lottiefiles/motion-design-skill lucasmarkes/hairline wheresryan22/anatomy annnguyentt/anatomy-reveal-skill remotion-dev/skills; do
  n=$(basename "$r")
  [ -d "$n" ] || git clone --depth 1 "https://github.com/$r" "$n"
done
cd ..

echo "== Blender（官方源被墙时走 dotsrc 镜像）=="
if [ ! -x tools/blender/blender ]; then
  mkdir -p tools
  f=$(curl -s https://mirrors.dotsrc.org/blender/release/Blender5.3/ | grep -o 'blender-[^"]*-linux-x64.tar.xz' | sort -V | tail -1)
  curl -sL -o tools/blender.tar.xz "https://mirrors.dotsrc.org/blender/release/Blender5.3/$f"
  tar -xf tools/blender.tar.xz -C tools
  mv tools/blender-*-linux-x64 tools/blender
  rm tools/blender.tar.xz
fi

echo "== FFmpeg / Openverse =="
echo "FFmpeg 用系统包即可（本机已验 8.1.2）；Openverse 免 Key 直接调 https://api.openverse.org/v1/"
echo "全部完成。冒烟：node 的 gsap/three/motion 导入、.venv/bin/python -c 'import manim, librosa, whisperx'、tools/blender/blender --version"
