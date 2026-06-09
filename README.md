# Operating Systems Project

This repository contains the practical work for the Operating Systems final project. It is organized as three separate paper folders so that each topic can keep its own source code, datasets, benchmark outputs, and report material.

Paper 1 is the active, implemented part of the repository. Paper 2 and Paper 3 are present as placeholders for future work.

## Repository Layout

```text
operating-systems-project/
|-- Paper1-Shell-Scripts/
|   |-- scripts_original/
|   |-- scripts_optimized/
|   |-- datasets/
|   |-- results/
|   `-- benchmark.sh
|-- Paper2-Synchronization/
|-- Paper3-Scheduling-Queueing/
`-- README.md
```

## Paper 1: Shell Script Analysis and Optimization

`Paper1-Shell-Scripts/` compares ten original Bash scripts with optimized versions. The work focuses on how small shell-programming choices affect execution time, process creation, system calls, and command overhead.

The selected scripts are:

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

Each original script is stored in `scripts_original/`, and the matching optimized implementation is stored in `scripts_optimized/`. Test inputs are stored in `datasets/`, while measured outputs are stored in `results/`.

For setup, commands, and folder details, see [Paper1-Shell-Scripts/README.md](Paper1-Shell-Scripts/README.md).

## Paper 2: Synchronization

`Paper2-Synchronization/` is reserved for synchronization experiments, such as producer-consumer and dining philosophers implementations. This folder currently contains only the project placeholder.

Planned work:

- implement synchronization problems using threads;
- compare synchronization strategies;
- measure throughput, latency, CPU usage, memory usage, context switches, and deadlock behavior;
- document results with tables and plots.

## Paper 3: Scheduling and Queueing

`Paper3-Scheduling-Queueing/` is reserved for scheduling and queueing simulations. This folder currently contains only the project placeholder.

Planned work:

- simulate process scheduling with multilevel feedback queues;
- evaluate waiting time, turnaround time, response time, and throughput;
- run repeated experiments across scheduler parameters;
- extend the analysis to queueing models such as M/M/1 and M/M/S.

## Requirements

Paper 1 is designed for a Linux or WSL environment with Bash. The benchmark workflow can also use:

- `/usr/bin/time`
- `strace`
- `perf`

If `strace` or `perf` is not installed, `benchmark.sh` still writes an output file noting that the tool is unavailable.

## Quick Start

From the repository root:

```bash
cd Paper1-Shell-Scripts
chmod +x benchmark.sh scripts_original/*.sh scripts_optimized/*.sh
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent
```

Benchmark outputs are written under `Paper1-Shell-Scripts/results/`.

## Final Deliverables

The final submission should include:

- the written report for each completed paper;
- source code and optimized code;
- datasets and test inputs;
- raw benchmark outputs;
- result tables, screenshots, and diagrams;
- reproduction notes explaining how the experiments were run.
