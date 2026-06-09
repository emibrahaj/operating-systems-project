from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.io_utils import object_to_row, write_csv
from src.mlfq import simulate_mlfq
from src.plotting import plot_metric_from_csv
from src.workload import generate_processes


def main() -> None:
    split_values = [0, 25, 50, 75, 100]
    runs = 10
    rows = []

    for split in split_values:
        run_rows = []
        for seed in range(runs):
            processes = generate_processes(300, 100, 10, 1000, "uniform", seed=100 + seed)
            metrics = simulate_mlfq(processes, q1=20, q2=80, l1=30, l2=30, third_level_policy="split", third_level_sjf_percent=split)
            run_rows.append(object_to_row(metrics))
        rows.append(_average_rows(run_rows, {"third_level_sjf_percent": split, "third_level_fcfs_percent": 100 - split, "runs": runs}))

    raw_path = ROOT / "results" / "raw" / "mlfq_sjf_fcfs_split.csv"
    table_path = ROOT / "results" / "tables" / "mlfq_sjf_fcfs_split_summary.csv"
    write_csv(raw_path, rows)
    write_csv(table_path, rows)
    plot_metric_from_csv(table_path, "third_level_sjf_percent", "avg_turnaround_time", ROOT / "results" / "plots" / "sjf_split_turnaround.png", "SJF Split vs Turnaround Time")
    print(f"wrote {table_path}")


def _average_rows(rows: list[dict], extra: dict) -> dict:
    numeric_keys = [key for key, value in rows[0].items() if isinstance(value, (int, float))]
    averaged = {key: sum(row[key] for row in rows) / len(rows) for key in numeric_keys}
    return {**extra, **averaged}


if __name__ == "__main__":
    main()
