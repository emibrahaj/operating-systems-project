from __future__ import annotations

from dataclasses import dataclass, field
from typing import Optional


@dataclass
class Process:
    pid: int
    arrival_time: int
    burst_time: int
    remaining_time: int = field(init=False)
    start_time: Optional[int] = None
    completion_time: Optional[int] = None
    level: int = 1

    def __post_init__(self) -> None:
        self.remaining_time = self.burst_time

    def clone(self) -> "Process":
        return Process(self.pid, self.arrival_time, self.burst_time)


@dataclass
class SchedulerMetrics:
    process_count: int
    completed: int
    makespan: int
    throughput: float
    avg_turnaround_time: float
    avg_waiting_time: float
    avg_response_time: float
    cpu_utilization: float


@dataclass
class QueueMetrics:
    model: str
    arrival_rate: float
    service_rate: float
    servers: int
    utilization: float
    stable: bool
    avg_queue_length: float
    avg_system_length: float
    avg_waiting_time: float
    avg_response_time: float
    probability_wait: float
