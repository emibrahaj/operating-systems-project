# Experiments

Repeated experiment scripts go here.

This folder is for parameter sweeps and Monte Carlo runs, not single manual simulations.

Planned experiments:

- vary `Q1` and `Q2`
- vary demotion thresholds `L1` and `L2`
- vary total simulation time `T`
- run the third-level SJF/FCFS split using `T%`
- run 100 to 500 Monte Carlo trials
- compare M/M/1 and M/M/S queueing performance

The assignment asks for many runs. Experiment scripts should write CSV files into `results/raw/` or `results/tables/`.

Implemented scripts:

- `run_mlfq_grid.py`
- `run_split_study.py`
- `run_queueing_study.py`
- `run_all.py`
