from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.io_utils import load_json, object_to_row, write_csv
from src.queueing import mm1_metrics, mms_metrics, rates_from_n_m_r


def main() -> None:
    config_path = ROOT / "configs" / "queueing_baseline.json"
    config = load_json(config_path)
    arrival_rate, per_server_rate = rates_from_n_m_r(
        config["process_count"],
        config["arrival_window"],
        config["service_capacity"],
        config.get("servers", 1),
    )
    mm1 = mm1_metrics(arrival_rate, config["service_capacity"])
    mms = mms_metrics(arrival_rate, per_server_rate, max(2, config.get("servers", 1)))
    rows = [
        object_to_row(mm1, {"config": config_path.name}),
        object_to_row(mms, {"config": config_path.name}),
    ]
    write_csv(ROOT / "results" / "raw" / "queueing_baseline.csv", rows)
    write_csv(ROOT / "results" / "tables" / "queueing_baseline_summary.csv", rows)
    for row in rows:
        print(row)


if __name__ == "__main__":
    main()
