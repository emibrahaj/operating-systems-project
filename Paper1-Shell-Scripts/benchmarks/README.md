# Benchmark Notes

This folder records the benchmark method used for Paper 1.

The measurements were collected with:

- `/usr/bin/time -v` for elapsed time, memory, CPU percentage, context switches, and file-system activity
- `strace -c` for system-call counts and time spent in system calls
- `perf stat` for CPU-level counters, when available

Raw output is kept in two layouts:

- by script: `results/<script-name>/`
- by measurement type: `results/time/`, `results/strace/`, `results/perf/`

The appendix copies are in `appendices/raw_results/`.

## Command Pattern

```bash
./benchmark.sh <result-name> <script-path> [arguments...]
```

Example:

```bash
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent
```

For `rn.sh` and `blank-rename.sh`, the dataset should be copied before each run because the scripts rename files.

The final table is `results/paper1_results_table.md`.
