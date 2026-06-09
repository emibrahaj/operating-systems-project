# Plots

Generated plots go here.

Expected plots:

- heatmaps for `Q1` and `Q2`
- heatmaps or surfaces for `L1` and `L2`
- line plots for waiting time and response time
- queueing utilization plots
- M/M/1 vs M/M/S comparison plots

Current plots:

- `mlfq_q1_waiting_time.svg`
- `sjf_split_turnaround.svg`
- `mm1_arrival_waiting_time.svg`

The code uses `matplotlib` if it is installed. If not, it writes simple SVG plots with the standard library.
