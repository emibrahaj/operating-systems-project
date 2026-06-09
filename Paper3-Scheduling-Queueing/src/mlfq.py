from __future__ import annotations

from collections import deque
from typing import Deque, Iterable, List, Literal

from .models import Process, SchedulerMetrics
from .workload import clone_processes


ThirdLevelPolicy = Literal["fcfs", "sjf", "split"]


def simulate_mlfq(
    processes: Iterable[Process],
    q1: int,
    q2: int,
    l1: int,
    l2: int,
    third_level_policy: ThirdLevelPolicy = "fcfs",
    third_level_sjf_percent: int = 50,
) -> SchedulerMetrics:
    jobs = clone_processes(processes)
    jobs.sort(key=lambda p: (p.arrival_time, p.pid))

    waiting: list[Process] = jobs[:]
    q_high: Deque[Process] = deque()
    q_mid: Deque[Process] = deque()
    q_low: list[Process] = []
    completed: list[Process] = []

    time = 0
    busy_time = 0
    level1_budget = max(1, l1)
    level2_budget = max(1, l2)
    third_budget = max(1, 100 - l1 - l2)
    third_sjf_budget = max(0, third_budget * third_level_sjf_percent // 100)
    third_fcfs_budget = max(0, third_budget - third_sjf_budget)
    cycle_used = {1: 0, 2: 0, 3: 0}

    while waiting or q_high or q_mid or q_low:
        _release_arrivals(waiting, q_high, time)

        if not (q_high or q_mid or q_low):
            time = max(time + 1, waiting[0].arrival_time)
            _release_arrivals(waiting, q_high, time)
            continue

        if q_high and cycle_used[1] < level1_budget:
            process = q_high.popleft()
            run_for = min(q1, process.remaining_time, level1_budget - cycle_used[1])
            _run_process(process, run_for, time)
            time += run_for
            busy_time += run_for
            cycle_used[1] += run_for
            _release_arrivals(waiting, q_high, time)
            if process.remaining_time == 0:
                process.completion_time = time
                completed.append(process)
            else:
                process.level = 2
                q_mid.append(process)
        elif q_mid and cycle_used[2] < level2_budget:
            process = q_mid.popleft()
            run_for = min(q2, process.remaining_time, level2_budget - cycle_used[2])
            _run_process(process, run_for, time)
            time += run_for
            busy_time += run_for
            cycle_used[2] += run_for
            _release_arrivals(waiting, q_high, time)
            if process.remaining_time == 0:
                process.completion_time = time
                completed.append(process)
            else:
                process.level = 3
                q_low.append(process)
        elif q_low and cycle_used[3] < third_budget:
            process = _pop_third_level(q_low, third_level_policy, cycle_used[3], third_sjf_budget)
            if third_level_policy == "split" and cycle_used[3] >= third_sjf_budget and third_fcfs_budget == 0:
                run_cap = third_budget - cycle_used[3]
            else:
                run_cap = third_budget - cycle_used[3]
            run_for = min(process.remaining_time, run_cap)
            _run_process(process, run_for, time)
            time += run_for
            busy_time += run_for
            cycle_used[3] += run_for
            _release_arrivals(waiting, q_high, time)
            if process.remaining_time == 0:
                process.completion_time = time
                completed.append(process)
            else:
                q_low.append(process)
        else:
            cycle_used = {1: 0, 2: 0, 3: 0}

    return _calculate_metrics(completed, time, busy_time)


def _release_arrivals(waiting: List[Process], q_high: Deque[Process], time: int) -> None:
    while waiting and waiting[0].arrival_time <= time:
        process = waiting.pop(0)
        process.level = 1
        q_high.append(process)


def _run_process(process: Process, run_for: int, time: int) -> None:
    if process.start_time is None:
        process.start_time = time
    process.remaining_time -= run_for


def _pop_third_level(
    q_low: list[Process],
    policy: ThirdLevelPolicy,
    used: int,
    sjf_budget: int,
) -> Process:
    if policy == "sjf" or (policy == "split" and used < sjf_budget):
        index = min(range(len(q_low)), key=lambda i: (q_low[i].remaining_time, q_low[i].arrival_time, q_low[i].pid))
        return q_low.pop(index)
    return q_low.pop(0)


def _calculate_metrics(completed: list[Process], makespan: int, busy_time: int) -> SchedulerMetrics:
    if not completed:
        return SchedulerMetrics(0, 0, makespan, 0, 0, 0, 0, 0)

    turnaround = [(p.completion_time or 0) - p.arrival_time for p in completed]
    waiting = [turnaround[i] - completed[i].burst_time for i in range(len(completed))]
    response = [(p.start_time or 0) - p.arrival_time for p in completed]
    count = len(completed)

    return SchedulerMetrics(
        process_count=count,
        completed=count,
        makespan=makespan,
        throughput=count / makespan if makespan else 0,
        avg_turnaround_time=sum(turnaround) / count,
        avg_waiting_time=sum(waiting) / count,
        avg_response_time=sum(response) / count,
        cpu_utilization=busy_time / makespan if makespan else 0,
    )
