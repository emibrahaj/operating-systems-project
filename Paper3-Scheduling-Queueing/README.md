# Paper 3: Scheduling and Queueing

This folder is for Paper 3 of the Operating Systems project.

The paper topic is:

```text
Optimization of Multilevel Feedback Queue Scheduling and Queueing Models
Using Simulation and Analytical Techniques
```

The assignment has three practical parts:

1. MLFQ scheduling with randomized processes and optimization of `Q1`, `Q2`, `L1`, and `L2`.
2. MLFQ scheduling where the third level is split between SJF and FCFS using percentage `T`.
3. M/M/1 and M/M/S queueing analysis using repeated stochastic process-generation setups.

## Folder Layout

```text
Paper3-Scheduling-Queueing/
|-- appendices/
|-- configs/
|-- datasets/
|-- diagrams/
|-- experiments/
|-- report/
|-- results/
|-- simulations/
|-- src/
`-- README.md
```

## Assignment Parts

### Part A: MLFQ Quantum and Level Optimization

Processes are generated randomly:

- burst time: `10..1000` time units
- arrival time: random within `0..M`
- number of processes: `N`

The scheduler uses a three-level feedback queue.

Parameters:

- `Q1`: time quantum for the highest-priority queue
- `Q2`: time quantum for the second-priority queue
- `L1`: time assigned to level 1
- `L2`: time assigned to level 2
- `100 - L1 - L2`: time assigned to level 3

The goal is to find values that improve:

- throughput
- turnaround time
- waiting time
- response time

### Part B: Third-Level SJF and FCFS Split

This part uses the same MLFQ setup, but level 3 is split between:

- SJF for `T%`
- FCFS for `100 - T%`

Parameters:

- `Q1`
- `Q2`
- `L1`
- `L2`
- `T`

The same four metrics are compared.

### Part C: Queueing Models

This part studies repeated stochastic process-arrival setups.

Variables:

- `N`: number of processes
- `M`: arrival interval
- `R`: service capacity per time unit
- random distribution used for arrivals and workloads

Models:

- M/M/1
- M/M/S

The queueing section should compare changing and constant values of `N`, `M`, and `R`.

Metrics:

- response time
- average queue length
- average waiting time
- server utilization
- stability
- queueing probabilities

## Folder Purpose

- `src/`: reusable Python modules
- `simulations/`: single-run scripts
- `experiments/`: repeated runs, grid searches, and Monte Carlo studies
- `configs/`: parameter sets for experiments
- `datasets/`: generated arrivals and burst times
- `results/`: raw outputs, tables, plots, and screenshots
- `diagrams/`: MLFQ and queueing diagrams
- `appendices/`: copied raw outputs, notes, and extra material
- `report/`: final MS Word report

## Starting Point

The current implementation includes the workload generator, MLFQ simulator, queueing calculators, experiment scripts, baseline CSV outputs, and SVG plots.

## Running the Code

From the repository root:

```powershell
py Paper3-Scheduling-Queueing\experiments\run_all.py
```

From inside `Paper3-Scheduling-Queueing/`:

```powershell
py experiments\run_all.py
```

Single-run scripts:

```powershell
py simulations\run_mlfq.py
py simulations\run_split_mlfq.py
py simulations\run_queueing.py
```

Experiment scripts:

```powershell
py experiments\run_mlfq_grid.py
py experiments\run_split_study.py
py experiments\run_queueing_study.py
```

Generated outputs:

- `datasets/mlfq_baseline_workload.csv`
- `datasets/mlfq_split_workload.csv`
- `results/raw/*.csv`
- `results/tables/*.csv`
- `results/plots/*.svg`
- `appendices/raw_results/*.csv`
- `appendices/plots/*.svg`
