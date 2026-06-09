from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.io_utils import object_to_row, write_csv
from src.plotting import plot_metric_from_csv
from src.queueing import mm1_metrics, mms_metrics


def main() -> None:
    rows = []
    for process_count in [100, 500, 1000]:
        for arrival_window in [50, 100, 200]:
            arrival_rate = process_count / arrival_window
            for service_capacity in [5, 10, 20]:
                rows.append(object_to_row(mm1_metrics(arrival_rate, service_capacity), {
                    "process_count": process_count,
                    "arrival_window": arrival_window,
                    "service_capacity": service_capacity,
                    "distribution": "poisson",
                }))
                rows.append(object_to_row(mms_metrics(arrival_rate, service_capacity / 4, 4), {
                    "process_count": process_count,
                    "arrival_window": arrival_window,
                    "service_capacity": service_capacity,
                    "distribution": "poisson",
                }))

    raw_path = ROOT / "results" / "raw" / "queueing_study.csv"
    table_path = ROOT / "results" / "tables" / "queueing_study_summary.csv"
    write_csv(raw_path, rows)
    write_csv(table_path, rows)
    stable_rows = [row for row in rows if row["stable"] is True and row["model"] == "M/M/1"]
    stable_path = ROOT / "results" / "tables" / "queueing_stable_mm1.csv"
    write_csv(stable_path, stable_rows)
    plot_metric_from_csv(stable_path, "arrival_rate", "avg_waiting_time", ROOT / "results" / "plots" / "mm1_arrival_waiting_time.png", "M/M/1 Arrival Rate vs Waiting Time")
    print(f"wrote {table_path}")


if __name__ == "__main__":
    main()
