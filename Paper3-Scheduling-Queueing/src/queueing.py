from __future__ import annotations

import math

from .models import QueueMetrics


def mm1_metrics(arrival_rate: float, service_rate: float) -> QueueMetrics:
    utilization = arrival_rate / service_rate if service_rate else float("inf")
    stable = utilization < 1
    if not stable:
        return QueueMetrics("M/M/1", arrival_rate, service_rate, 1, utilization, False, math.inf, math.inf, math.inf, math.inf, 1.0)

    avg_system_length = utilization / (1 - utilization)
    avg_queue_length = utilization**2 / (1 - utilization)
    avg_response_time = 1 / (service_rate - arrival_rate)
    avg_waiting_time = arrival_rate / (service_rate * (service_rate - arrival_rate))

    return QueueMetrics("M/M/1", arrival_rate, service_rate, 1, utilization, True, avg_queue_length, avg_system_length, avg_waiting_time, avg_response_time, utilization)


def mms_metrics(arrival_rate: float, service_rate: float, servers: int) -> QueueMetrics:
    if servers <= 0:
        raise ValueError("servers must be positive")

    traffic = arrival_rate / service_rate if service_rate else float("inf")
    utilization = traffic / servers if servers else float("inf")
    stable = utilization < 1
    if not stable:
        return QueueMetrics("M/M/S", arrival_rate, service_rate, servers, utilization, False, math.inf, math.inf, math.inf, math.inf, 1.0)

    p0 = _mms_p0(traffic, servers)
    probability_wait = ((traffic**servers) / (math.factorial(servers) * (1 - utilization))) * p0
    avg_queue_length = probability_wait * utilization / (1 - utilization)
    avg_system_length = avg_queue_length + traffic
    avg_waiting_time = avg_queue_length / arrival_rate if arrival_rate else 0
    avg_response_time = avg_waiting_time + (1 / service_rate if service_rate else math.inf)

    return QueueMetrics("M/M/S", arrival_rate, service_rate, servers, utilization, True, avg_queue_length, avg_system_length, avg_waiting_time, avg_response_time, probability_wait)


def rates_from_n_m_r(process_count: int, arrival_window: int, service_capacity: int, servers: int = 1) -> tuple[float, float]:
    arrival_rate = process_count / max(arrival_window, 1)
    service_rate = max(service_capacity, 1)
    return arrival_rate, service_rate / max(servers, 1)


def _mms_p0(traffic: float, servers: int) -> float:
    total = sum((traffic**n) / math.factorial(n) for n in range(servers))
    tail = (traffic**servers) / (math.factorial(servers) * (1 - (traffic / servers)))
    return 1 / (total + tail)
