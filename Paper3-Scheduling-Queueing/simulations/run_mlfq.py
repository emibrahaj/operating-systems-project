from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.io_utils import load_json, object_to_row, write_csv
from src.mlfq import simulate_mlfq
from src.workload import generate_processes, save_processes


def main() -> None:
    config_path = ROOT / "configs" / "mlfq_baseline.json"
    config = load_json(config_path)
    processes = generate_processes(
        config["process_count"],
        config["arrival_window"],
        config["burst_min"],
        config["burst_max"],
        config.get("random_distribution", "uniform"),
        seed=42,
    )
    save_processes(processes, ROOT / "datasets" / "mlfq_baseline_workload.csv")
    metrics = simulate_mlfq(
        processes,
        q1=config["q1"],
        q2=config["q2"],
        l1=config["l1"],
        l2=config["l2"],
        third_level_policy=config.get("third_level_policy", "fcfs"),
    )
    row = object_to_row(metrics, {"config": config_path.name})
    write_csv(ROOT / "results" / "raw" / "mlfq_baseline_single_run.csv", [row])
    write_csv(ROOT / "results" / "tables" / "mlfq_baseline_summary.csv", [row])
    print(row)


if __name__ == "__main__":
    main()
