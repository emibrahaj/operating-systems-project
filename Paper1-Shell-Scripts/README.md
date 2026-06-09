# Paper 1: Shell Script Analysis and Optimization

This folder contains the working files for Paper 1. The project compares ten Bash scripts with optimized versions and records the effect on runtime, memory use, system calls, and CPU counters.

## Folder Layout

```text
Paper1-Shell-Scripts/
|-- appendices/
|-- benchmarks/
|-- datasets/
|-- diagrams/
|-- report/
|-- results/
|-- scripts_original/
|-- scripts_optimized/
|-- src/
|-- benchmark.sh
`-- README.md
```

## Scripts

| Original | Optimized | Purpose |
|---|---|---|
| `blank-rename.sh` | `blank-rename_optimized.sh` | replace blanks in filenames |
| `collatz.sh` | `collatz_optimized.sh` | print a Collatz sequence |
| `days-between.sh` | `days-between_optimized.sh` | calculate the difference between two dates |
| `encryptedpw.sh` | `encryptedpw_optimized.sh` | handle encrypted password input |
| `life.sh` | `life_optimized.sh` | run Conway's Game of Life in Bash |
| `mailformat.sh` | `mailformat_optimized.sh` | format email-style text |
| `makedict.sh` | `makedict_optimized.sh` | build a word list from text |
| `password.sh` | `password_optimized.sh` | generate password output |
| `rn.sh` | `rn_optimized.sh` | rename files by pattern |
| `soundex.sh` | `soundex_optimized.sh` | produce Soundex-style codes |

Original scripts are in `scripts_original/`. Optimized scripts are in `scripts_optimized/`.

## New Script

The new script for Section 8 is:

```text
src/file_organizer.sh
```

It sorts files into `Documents`, `Images`, `Source_Code`, `Archives`, and `Other` based on file extension. The test files are in `datasets/organizer_test/`, and the design notes are in `appendices/paper1_appendices.md`.

## Datasets

The input files are kept small so the scripts can be rerun easily.

| Dataset | Used by |
|---|---|
| `datasets/emails/sample_email.txt` | `mailformat.sh` |
| `datasets/encryptedpw/test_upload.txt` | `encryptedpw.sh` |
| `datasets/life/gen0` | `life.sh` |
| `datasets/life_grids/gen0` | alternate Game of Life input |
| `datasets/organizer_test/` | `file_organizer.sh` |
| `datasets/rename_test/` | `blank-rename.sh` |
| `datasets/rn_test/` | `rn.sh` |
| `datasets/text/sample_text.txt` | `makedict.sh` |

The rename scripts change filenames, so those tests should be run on a copy of the dataset.

## Results

Raw benchmark files are stored by script:

```text
results/<script-name>/
|-- original_time.txt
|-- original_strace.txt
|-- original_perf.txt
|-- optimized_time.txt
|-- optimized_strace.txt
`-- optimized_perf.txt
```

The same files are also grouped by tool:

```text
results/time/
results/strace/
results/perf/
```

The main summary table is:

```text
results/paper1_results_table.md
```

Extra summary notes are in `results/paper1_results/`. Screenshots are in `results/screenshots/`.

Copies of the raw results and screenshots are also under `appendices/` so the report can reference them without moving files around.

## Running Benchmarks

Run the experiments in Linux or WSL.

```bash
chmod +x benchmark.sh scripts_original/*.sh scripts_optimized/*.sh src/file_organizer.sh
```

Example:

```bash
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent
```

`benchmark.sh` uses `/usr/bin/time -v`, `strace -c`, and `perf stat` when available.

## File Organizer Test

```bash
./src/file_organizer.sh datasets/organizer_test
find datasets/organizer_test
```

Expected output structure:

```text
Documents/report.pdf
Images/photo.png
Source_Code/script.sh
Archives/archive.zip
Other/random.xyz
```

The test files are only placeholders. The script checks file extensions, not the actual file format.
