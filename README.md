# Claude Motion Studio · 动效全流程线

把 20 个开源工具整合成一条可落地的视频动效流水线：**分镜 → 动效 → 3D/物理 → 后期 → 视频生成 → 配乐卡点 → 字幕导出**。
来源：X 帖子 @jonnyhlkw 的 20 工具清单（2026-11-26）。本仓库所有条目均已实测：链接存活 20/20，JS/Python 包实装并冒烟通过（版本见下）。

## 全流程（7 阶段）

| 阶段 | 干什么 | 工具 |
|---|---|---|
| 1 分镜与动画法则 | 定画面语言与节奏 | motion-design-skill、hairline、anatomy、anatomy-reveal |
| 2 动效引擎 | 弹簧物理、时间轴、矢量动画 | Motion、GSAP、Lottie |
| 3 3D 与物理 | 建模动画、场景运镜、真实物理、粒子 | Blender、Three.js、react-three-rapier、three.quarks |
| 4 电影后期 | 光晕景深等后期 + 实时调参 | react-postprocessing、Tweakpane |
| 5 视频生成 | 可编程视频渲染、科普公式动画 | Remotion、Remotion Skills、Manim |
| 6 配乐卡点 | 免费音乐音效、鼓点检测对齐 | Openverse API、librosa |
| 7 字幕与导出 | 自动打轴字幕、转码导出 | WhisperX、FFmpeg |

每阶段的说明与过关清单在 `pipeline/` 对应目录。

## 20 工具总表（帖子原序）

| # | 工具 | 一句话 | 仓库 | 本机实测 |
|---|---|---|---|---|
| 01 | motion-design-skill | 迪士尼 12 法则与缓动节奏（技能） | https://github.com/lottiefiles/motion-design-skill | 已克隆 skills/ |
| 02 | Motion | 弹簧物理与丝滑转场 | https://github.com/motiondivision/motion | npm motion 14.14.0 ✔ |
| 03 | Remotion Skills | 官方视频生成技能库 | https://github.com/remotion-dev/skills | 已克隆 skills/ |
| 04 | hairline | SVG 变交互动态线条（技能） | https://github.com/lucasmarkes/hairline | 已克隆 skills/ |
| 05 | anatomy | 机械结构转 3D 剖面（技能） | https://github.com/wheresryan22/anatomy | 已克隆 skills/ |
| 06 | anatomy-reveal | 产品 3D 爆炸拆解（技能） | https://github.com/annnguyentt/anatomy-reveal-skill | 已克隆 skills/ |
| 07 | Blender | 3D 建模、骨骼与角色动画 | https://github.com/blender/blender | 5.3.0 二进制 ✔ |
| 08 | Three.js | 3D 场景与电影运镜 | https://github.com/mrdoob/three.js | npm three 0.187.0 ✔ |
| 09 | react-three-rapier | 3D 真实物理 | https://github.com/pmndrs/react-three-rapier | npm @react-three/rapier 2.2.0 ✔ |
| 10 | react-postprocessing | 光晕、景深等电影后期 | https://github.com/pmndrs/react-postprocessing | npm 1.4.0 ✔ |
| 11 | three.quarks | 粒子轨迹与 VFX | https://github.com/Alchemist0823/three.quarks | npm 0.18.0 ✔ |
| 12 | Tweakpane | 运行时实时调参面板 | https://github.com/cocopon/tweakpane | npm 4.0.5 ✔ |
| 13 | GSAP | 动画时间轴（已免费） | https://github.com/greensock/GSAP | npm 3.15.1 ✔ |
| 14 | Remotion | React 可编程视频引擎 | https://github.com/remotion-dev/remotion | npm 4.0.547 ✔ |
| 15 | Manim | 科普、公式与几何动画 | https://github.com/ManimCommunity/manim | pip（见 requirements.txt） |
| 16 | Lottie | 轻量矢量动画渲染 | https://github.com/airbnb/lottie-web | npm lottie-web 5.13.0 ✔ |
| 17 | Openverse API | 免 Key 搜免费音效音乐 | https://github.com/WordPress/openverse | API 实测返回结果 ✔ |
| 18 | librosa | 鼓点检测、动画卡点 | https://github.com/librosa/librosa | pip（见 requirements.txt） |
| 19 | WhisperX | 自动精准打轴字幕 | https://github.com/m-bain/whisperX | pip（见 requirements.txt） |
| 20 | FFmpeg | 格式转换与无损导出 | https://github.com/FFmpeg/FFmpeg | 系统 8.1.2 ✔ |

配套生态：react 19.3.1、@react-three/fiber 9.8.2（npm 安装需 `--legacy-peer-deps`）。

## 一键安装

```bash
./install.sh
```

要点（都是实测踩过的坑）：
- npm 必须加 `--legacy-peer-deps`，否则 React 生态 peer 版本冲突装不上。
- Python 先装 **CPU 版 torch**（`--index-url https://download.pytorch.org/whl/cpu`），默认版会拉 CUDA 全家桶（近 900MB 单包 + 数 GB 依赖），小磁盘直接撑爆。
- Blender 官方下载站对部分网络 403，install.sh 走 dotsrc 镜像；无头渲染用 Cycles CPU（EEVEE 需要 libEGL）。

## 目录

- `pipeline/` 七个阶段的说明、过关清单与示例（Manim 场景、librosa 卡点脚本）
- `skills/` 五个技能仓库（install.sh 克隆，不 vendored）
- `tools/` Blender 二进制（不进 git）
- `package.json` / `requirements.txt` 全部依赖清单
