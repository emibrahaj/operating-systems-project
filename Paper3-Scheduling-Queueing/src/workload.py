from __future__ import annotations

import csv
import random
from pathlib import Path
from typing import Iterable, List

from .models import Process


def generate_processes(
    process_count: int,
    arrival_window: int,
    burst_min: int,
    burst_max: int,
    distribution: str = "uniform",
    seed: int | None = None,
) -> List[Process]:
    rng = random.Random(seed)
    processes: list[Process] = []

    for pid in range(1, process_count + 1):
        arrival_time = _arrival_time(rng, arrival_window, distribution)
        burst_time = rng.randint(burst_min, burst_max)
        processes.append(Process(pid, arrival_time, burst_time))

    return sorted(processes, key=lambda p: (p.arrival_time, p.pid))


def clone_processes(processes: Iterable[Process]) -> List[Process]:
    return [process.clone() for process in processes]


def save_processes(processes: Iterable[Process], path: str | Path) -> None:
    out = Path(path)
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.writer(fh)
        writer.writerow(["pid", "arrival_time", "burst_time"])
        for process in processes:
            writer.writerow([process.pid, process.arrival_time, process.burst_time])


def load_processes(path: str | Path) -> List[Process]:
    with Path(path).open(newline="", encoding="utf-8") as fh:
        reader = csv.DictReader(fh)
        return [
            Process(
                pid=int(row["pid"]),
                arrival_time=int(row["arrival_time"]),
                burst_time=int(row["burst_time"]),
            )
            for row in reader
        ]


def _arrival_time(rng: random.Random, arrival_window: int, distribution: str) -> int:
    if arrival_window <= 0:
        return 0
    if distribution == "exponential":
        value = rng.expovariate(1 / max(arrival_window / 3, 1))
        return min(arrival_window, int(value))
    if distribution == "poisson":
        # Knuth sampler with a modest lambda; clipped to the assignment window.
        lam = max(arrival_window / 2, 1)
        l_val = 2.718281828459045 ** (-lam)
        k = 0
        p = 1.0
        while p > l_val and k < arrival_window:
            k += 1
            p *= rng.random()
        return min(arrival_window, max(0, k - 1))
    return rng.randint(0, arrival_window)
