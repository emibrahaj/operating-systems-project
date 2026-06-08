# Operating Systems Final Project

This repository organizes the final Operating Systems project for CEN/SWE 2025-2026. The project is divided into three independent research papers, each with its own code, experiments, results, and reproducibility material.

## Project Structure

```text
operating-systems-project/
|-- Paper1-Shell-Scripts/
|-- Paper2-Synchronization/
`-- Paper3-Scheduling-Queueing/
```

## Papers

### Paper 1: Advanced Shell Script Analysis & Optimization

Focus: systematic empirical evaluation of Bash/shell scripts.

Required work includes:

- select and analyze 10 scripts from the provided Part I material;
- explain each script's functionality;
- add comments and instrumentation logs;
- run experiments with different inputs;
- collect execution time, CPU usage, memory usage, and I/O-related results;
- identify performance bottlenecks;
- create optimized versions;
- compare original and optimized implementations;
- extract shell scripting design patterns;
- include diagrams, screenshots, raw runs, tables, and plots.

### Paper 2: Multithreaded Synchronization & Performance

Focus: producer-consumer and dining philosophers synchronization problems.

Required work includes:

- implement producer-consumer with bounded buffer in POSIX pthreads and Java or Python;
- implement dining philosophers using multiple synchronization approaches;
- vary buffer size, producer/consumer counts, and philosopher count;
- compare throughput, latency, CPU usage, memory usage, context switches, and deadlock behavior.

### Paper 3: Scheduling, Queuing & System Optimization

Focus: multilevel feedback queue scheduling and queuing theory simulation.

Required work includes:

- simulate randomized process arrivals and burst times;
- study optimal values for Q1, Q2, L1, L2, and T;
- evaluate throughput, turnaround time, waiting time, and response time;
- run Monte Carlo experiments;
- visualize results using tables, heatmaps, and performance plots;
- extend the analysis to M/M/1 and M/M/S queuing models.

## Final Deliverables

Each paper should include:

- abstract and keywords;
- methodology;
- implementation details;
- experiments and results;
- plots, tables, and screenshots;
- reproducibility notes;
- appendices with code, raw outputs, and supporting files.

The final submission should include the full MS Word report plus all separate support files needed to reproduce the work.
