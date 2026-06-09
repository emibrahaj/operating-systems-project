# Operating Systems Project

This repository contains the practical files for the Operating Systems final project. The work is split into three paper folders. Paper 1 includes scripts, datasets, measurements, screenshots, and appendix material. Paper 3 now has its starting folder layout for scheduling and queueing work. Paper 2 is still a placeholder.

## Structure

```text
operating-systems-project/
|-- Paper1-Shell-Scripts/
|   |-- appendices/
|   |-- benchmarks/
|   |-- datasets/
|   |-- diagrams/
|   |-- report/
|   |-- results/
|   |-- scripts_original/
|   |-- scripts_optimized/
|   |-- src/
|   `-- benchmark.sh
|-- Paper2-Synchronization/
|-- Paper3-Scheduling-Queueing/
|   |-- appendices/
|   |-- configs/
|   |-- datasets/
|   |-- diagrams/
|   |-- experiments/
|   |-- report/
|   |-- results/
|   |-- simulations/
|   `-- src/
`-- README.md
```

## Paper 1

Paper 1 studies ten Bash scripts. For each one, the original version is kept in `scripts_original/` and the optimized version is kept in `scripts_optimized/`.

Scripts used:

- `blank-rename.sh`
- `collatz.sh`
- `days-between.sh`
- `encryptedpw.sh`
- `life.sh`
- `mailformat.sh`
- `makedict.sh`
- `password.sh`
- `rn.sh`
- `soundex.sh`

The results compare execution time, memory use, system-call behavior, and CPU-related counters. Raw outputs are in `results/`, screenshots are in `results/screenshots/`, and the appendix material is in `appendices/`.

The new script for the research contribution section is:

```text
Paper1-Shell-Scripts/src/file_organizer.sh
```

It sorts files into folders by extension. Its algorithm and test notes are included in `Paper1-Shell-Scripts/appendices/paper1_appendices.md`.

## Paper 2

`Paper2-Synchronization/` is reserved for the synchronization paper. It is intended for producer-consumer and dining philosophers experiments, but no implementation has been added yet.

## Paper 3

`Paper3-Scheduling-Queueing/` is for the scheduling and queueing paper. It now includes Python code for multilevel feedback queue simulations, SJF/FCFS third-level splitting, M/M/1 and M/M/S queueing models, generated workloads, experiment scripts, CSV results, and SVG plots.

## Running Paper 1 Benchmarks

Paper 1 should be run in Linux or WSL with Bash.

Useful tools:

- `/usr/bin/time`
- `strace`
- `perf`

Example:

```bash
cd Paper1-Shell-Scripts
chmod +x benchmark.sh scripts_original/*.sh scripts_optimized/*.sh src/file_organizer.sh
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent
```

The main Paper 1 folder has its own README with the full layout and result locations.
