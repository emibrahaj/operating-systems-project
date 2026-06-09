from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main() -> None:
    scripts = [
        ROOT / "simulations" / "run_mlfq.py",
        ROOT / "simulations" / "run_split_mlfq.py",
        ROOT / "simulations" / "run_queueing.py",
        ROOT / "experiments" / "run_mlfq_grid.py",
        ROOT / "experiments" / "run_split_study.py",
        ROOT / "experiments" / "run_queueing_study.py",
    ]
    for script in scripts:
        print(f"running {script.relative_to(ROOT)}")
        subprocess.run([sys.executable, str(script)], check=True, cwd=ROOT)


if __name__ == "__main__":
    main()
