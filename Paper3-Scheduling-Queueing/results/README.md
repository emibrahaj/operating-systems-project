# Results

Raw outputs, summary tables, and plots go here.

Suggested structure:

```text
results/
|-- raw/
|-- tables/
|-- plots/
`-- screenshots/
```

The main result table should compare throughput, turnaround time, waiting time, response time, and utilization across experiment settings.

Expected result groups:

- MLFQ results for `Q1`, `Q2`, `L1`, and `L2`
- SJF/FCFS split results for `T`
- M/M/1 queueing results
- M/M/S queueing results
- comparison of random distributions

Current generated outputs:

- `raw/mlfq_baseline_single_run.csv`
- `raw/mlfq_split_single_run.csv`
- `raw/mlfq_grid_search.csv`
- `raw/mlfq_sjf_fcfs_split.csv`
- `raw/queueing_baseline.csv`
- `raw/queueing_study.csv`
- `tables/mlfq_baseline_summary.csv`
- `tables/mlfq_split_summary.csv`
- `tables/mlfq_grid_search_summary.csv`
- `tables/mlfq_sjf_fcfs_split_summary.csv`
- `tables/queueing_baseline_summary.csv`
- `tables/queueing_study_summary.csv`
- `plots/mlfq_q1_waiting_time.svg`
- `plots/sjf_split_turnaround.svg`
- `plots/mm1_arrival_waiting_time.svg`
