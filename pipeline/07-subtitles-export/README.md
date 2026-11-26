# 阶段 7 · 字幕与导出
- WhisperX（pip）：精准打轴字幕（多语言）
  .venv/bin/whisperx video.mp4 --model medium --language zh --output_format srt
- FFmpeg（系统 8.1.2）：转码/烧字幕/无损导出
  ffmpeg -i in.mp4 -vf subtitles=subs.srt -c:a copy out.mp4
  ffmpeg -i in.mov -c:v libx264 -crf 18 -c:a aac out.mp4
过关：字幕校对无错轴 / 按目标平台规格导出 / 成片自检一遍
