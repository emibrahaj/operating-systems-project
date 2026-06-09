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
    q1_values = [10, 20, 40]
    q2_values = [40, 80, 120]
    l1_values = [20, 30]
    l2_values = [20, 30]
    runs = 10
    rows = []

    for q1 in q1_values:
        for q2 in q2_values:
            for l1 in l1_values:
                for l2 in l2_values:
                    run_rows = []
                    for seed in range(runs):
                        processes = generate_processes(300, 100, 10, 1000, "uniform", seed=seed)
                        metrics = simulate_mlfq(processes, q1=q1, q2=q2, l1=l1, l2=l2)
                        run_rows.append(object_to_row(metrics))
                    rows.append(_average_rows(run_rows, {"q1": q1, "q2": q2, "l1": l1, "l2": l2, "runs": runs}))

    raw_path = ROOT / "results" / "raw" / "mlfq_grid_search.csv"
    table_path = ROOT / "results" / "tables" / "mlfq_grid_search_summary.csv"
    write_csv(raw_path, rows)
    write_csv(table_path, sorted(rows, key=lambda r: (r["avg_waiting_time"], -r["throughput"])))
    plot_metric_from_csv(table_path, "q1", "avg_waiting_time", ROOT / "results" / "plots" / "mlfq_q1_waiting_time.png", "MLFQ Q1 vs Waiting Time")
    print(f"wrote {table_path}")


def _average_rows(rows: list[dict], extra: dict) -> dict:
    numeric_keys = [key for key, value in rows[0].items() if isinstance(value, (int, float))]
    averaged = {key: sum(row[key] for row in rows) / len(rows) for key in numeric_keys}
    return {**extra, **averaged}


if __name__ == "__main__":
    main()
