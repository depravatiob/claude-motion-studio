# Manim 冒烟示例：.venv/bin/manim render -ql manim_example.py BeatDot
from manim import *

class BeatDot(Scene):
    def construct(self):
        dot = Dot(color=YELLOW).scale(2)
        label = Text("beat!", font_size=36).next_to(dot, DOWN)
        self.play(FadeIn(dot), Write(label))
        self.play(dot.animate.scale(1.6), rate_func=there_and_back, run_time=0.6)
        self.wait(0.4)
