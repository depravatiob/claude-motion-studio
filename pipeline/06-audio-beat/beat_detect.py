# 用法：.venv/bin/python beat_detect.py song.mp3 -> beats.json（秒）
import sys, json
import librosa

path = sys.argv[1] if len(sys.argv) > 1 else "song.mp3"
y, sr = librosa.load(path)
tempo, beats = librosa.beat.beat_track(y=y, sr=sr)
times = librosa.frames_to_time(beats, sr=sr)
out = {"tempo": float(tempo), "beats_sec": [round(float(t), 3) for t in times]}
json.dump(out, open("beats.json", "w"), indent=2)
print(f"tempo={out['tempo']:.1f} beats={len(out['beats_sec'])} -> beats.json")
