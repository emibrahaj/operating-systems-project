# Paper 1: Advanced Shell Script Analysis & Optimization

This folder contains the code, datasets, benchmark outputs, screenshots, diagrams, and report files for Paper 1. The goal is to evaluate selected shell scripts empirically, instrument them, optimize them, and compare the results.

## Start Here

Do the practical work first, then write the report from the evidence:

1. Copy the 10 selected original scripts into `scripts_original/`.
2. Create small datasets in `datasets/`.
3. Run each original script once and save screenshots in `results/screenshots/`.
4. Copy scripts into `scripts_instrumented/` and add comments/logging.
5. Benchmark original scripts with `time`, `strace`, and `perf`.
6. Create optimized versions in `scripts_optimized/`.
7. Compare original vs optimized results.
8. Use the collected outputs, plots, and screenshots to write the paper in `report/`.

## Folder Structure

```text
Paper1-Shell-Scripts/
|-- scripts_original/
|-- scripts_instrumented/
|-- scripts_optimized/
|-- datasets/
|   |-- emails/
|   |-- rename_test/
|   |-- text_files/
|   |-- names/
|   `-- life_grids/
|-- results/
|   |-- screenshots/
|   |-- time/
|   |-- strace/
|   `-- perf/
|-- diagrams/
|-- report/
`-- benchmark.sh
```

## Folder Purpose

- `scripts_original/`: exact copies of the selected scripts from the assignment material.
- `scripts_instrumented/`: versions with added comments, logging, and intermediate-output tracing.
- `scripts_optimized/`: improved versions used for original-vs-optimized comparison.
- `datasets/emails/`: sample email/text inputs for `mailformat`.
- `datasets/rename_test/`: copied test folders/files for `rn` and `blank-rename`.
- `datasets/text_files/`: sample text inputs for scripts such as `makedict`.
- `datasets/names/`: sample name lists for scripts such as `soundex`.
- `datasets/life_grids/`: starting grids for Game of Life.
- `results/screenshots/`: screenshots proving script behavior and intermediate outputs.
- `results/time/`: `/usr/bin/time -v` outputs.
- `results/strace/`: `strace -c` outputs.
- `results/perf/`: `perf stat` outputs.
- `diagrams/`: control-flow and data-flow diagrams for each selected script.
- `report/`: outline, draft, references, tables, and final Paper 1 report.

## Suggested 10 Scripts

The assignment specifically mentions several examples. A manageable starting set is:

1. `mailformat.sh`
2. `rn.sh`
3. `blank-rename.sh`
4. `encryptedpw.sh`
5. `collatz.sh`
6. `days-between.sh`
7. `makedict.sh`
8. `soundex.sh`
9. `life.sh`
10. `password.sh`

This list can be changed if the team chooses different scripts from the provided material.

## Benchmark Commands

Example for `collatz.sh`:

```bash
/usr/bin/time -v ./scripts_original/collatz.sh 27 > results/time/collatz_time.txt 2>&1
strace -c ./scripts_original/collatz.sh 27 > results/strace/collatz_strace.txt 2>&1
perf stat ./scripts_original/collatz.sh 27 > results/perf/collatz_perf.txt 2>&1
```

Use instrumented scripts for explanation and screenshots. Use original and optimized scripts for performance comparison, because logging changes timing results.
