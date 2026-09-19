#!/usr/bin/env python3
"""NVIDIA utilization for Waybar; VRAM and temperature live in the tooltip."""
import csv
import html
import json
import subprocess


def status():
    try:
        result = subprocess.run(
            [
                "nvidia-smi", "--id=0",
                "--query-gpu=name,utilization.gpu,memory.used,memory.total,temperature.gpu",
                "--format=csv,noheader,nounits",
            ],
            capture_output=True, text=True, check=True, timeout=2,
        )
        name, usage, used, total, temperature = next(csv.reader(result.stdout.splitlines()))
        usage, used, total, temperature = map(int, (usage, used, total, temperature))
        return {
            "text": f"GPU {usage}%",
            "tooltip": (
                f"{html.escape(name.strip())}\nUtilization: {usage}%"
                f"\nVRAM: {used / 1024:.1f} / {total / 1024:.1f} GiB"
                f"\nTemperature: {temperature}°C"
            ),
            "percentage": usage,
            "class": "nvidia",
        }
    except (OSError, subprocess.SubprocessError, ValueError, StopIteration):
        return {
            "text": "GPU n/a",
            "tooltip": "NVIDIA statistics unavailable (nvidia-smi).",
            "class": "unavailable",
        }


if __name__ == "__main__":
    print(json.dumps(status()))
