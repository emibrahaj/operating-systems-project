# Paper 1: Shell Script Analysis and Optimization

This folder contains the implementation and benchmark evidence for Paper 1 of the Operating Systems project. The paper studies ten Bash scripts, explains what each script does, identifies performance bottlenecks, and compares the original scripts with optimized versions.

The main goal is not only to make the scripts faster, but also to show why the optimized versions perform better using operating-system-level evidence such as timing, system-call summaries, and CPU performance counters.

## What Is Included

```text
Paper1-Shell-Scripts/
|-- scripts_original/
|   |-- blank-rename.sh
|   |-- collatz.sh
|   |-- days-between.sh
|   |-- encryptedpw.sh
|   |-- life.sh
|   |-- mailformat.sh
|   |-- makedict.sh
|   |-- password.sh
|   |-- rn.sh
|   `-- soundex.sh
|-- scripts_optimized/
|   |-- blank-rename_optimized.sh
|   |-- collatz_optimized.sh
|   |-- days-between_optimized.sh
|   |-- encryptedpw_optimized.sh
|   |-- life_optimized.sh
|   |-- mailformat_optimized.sh
|   |-- makedict_optimized.sh
|   |-- password_optimized.sh
|   |-- rn_optimized.sh
|   `-- soundex_optimized.sh
|-- datasets/
|-- results/
|-- benchmark.sh
`-- README.md
```

## Script Set

| Script | Purpose | Main optimization idea |
|---|---|---|
| `blank-rename.sh` | Replaces blanks in filenames | reduce external commands inside loops |
| `collatz.sh` | Prints a Collatz sequence | separate computation from formatted output |
| `days-between.sh` | Computes date distance | simplify date handling and repeated parsing |
| `encryptedpw.sh` | Demonstrates encrypted password handling | reduce unnecessary command calls |
| `life.sh` | Runs Conway's Game of Life in Bash | reduce repeated text processing in the generation loop |
| `mailformat.sh` | Formats email/text input | streamline text transformations |
| `makedict.sh` | Builds a dictionary-style word list | simplify pipeline work |
| `password.sh` | Generates password-style output | reduce process overhead |
| `rn.sh` | Renames files matching a pattern | safer filename handling and fewer subshells |
| `soundex.sh` | Computes Soundex-style name codes | simplify character mapping and filtering |

## Datasets

The `datasets/` folder contains small, repeatable inputs used by the scripts. Examples include:

- `datasets/emails/` for `mailformat.sh`;
- `datasets/encryptedpw/` for password/encryption-related tests;
- `datasets/life/` and `datasets/life_grids/` for `life.sh`;
- `datasets/rename_test/`, `datasets/rn_test/`, and copied run folders for rename tests;
- `datasets/text/` for text-processing scripts.

Rename-related scripts modify files, so use copied test folders instead of running them directly on important files.

## Results

The `results/` folder stores benchmark evidence. The repo already contains per-script result folders such as:

```text
results/
|-- blank-rename/
|-- collatz/
|-- days-between/
|-- encryptedpw/
|-- environment/
|-- life/
|-- mailformat/
|-- makedict/
|-- password/
|-- rn/
|-- soundex/
`-- paper1_results_table.md
```

Each per-script folder can contain:

- `original_time.txt`
- `original_strace.txt`
- `original_perf.txt`
- `optimized_time.txt`
- `optimized_strace.txt`
- `optimized_perf.txt`

`results/environment/` stores machine and tool information such as OS, CPU, memory, Bash, Git, `strace`, and `perf` versions. `results/paper1_results_table.md` is the summary table used for the paper.

## Requirements

Run the experiments in Linux or WSL. Required:

- Bash
- `/usr/bin/time`

Recommended:

- `strace`
- `perf`

The benchmark helper checks for `strace` and `perf`. If either tool is unavailable, it still creates a result file explaining that the tool was missing.

## Running a Benchmark

From this folder:

```bash
chmod +x benchmark.sh scripts_original/*.sh scripts_optimized/*.sh
```

Run an original script:

```bash
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
```

Run the optimized version:

```bash
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent
```

The helper writes:

```text
results/time/<name>_time.txt
results/strace/<name>_strace.txt
results/perf/<name>_perf.txt
```

Some existing results are also organized in per-script folders, for example `results/collatz/original_time.txt` and `results/collatz/optimized_time.txt`.

## Suggested Test Commands

These examples show the intended comparison style. Adjust inputs when needed for the paper.

```bash
./benchmark.sh collatz-original ./scripts_original/collatz.sh 27
./benchmark.sh collatz-optimized ./scripts_optimized/collatz_optimized.sh 27 --silent

./benchmark.sh days-between-original ./scripts_original/days-between.sh 2024-01-01 2024-12-31
./benchmark.sh days-between-optimized ./scripts_optimized/days-between_optimized.sh 2024-01-01 2024-12-31

./benchmark.sh password-original ./scripts_original/password.sh
./benchmark.sh password-optimized ./scripts_optimized/password_optimized.sh

./benchmark.sh soundex-original ./scripts_original/soundex.sh Smith
./benchmark.sh soundex-optimized ./scripts_optimized/soundex_optimized.sh Smith
```

For `rn.sh` and `blank-rename.sh`, first copy the sample dataset into a temporary run directory, then run the benchmark inside that copied directory. This prevents one test run from changing the input files needed by the next run.

## How to Use the Evidence in the Paper

For each script, the report should include:

- what the original script does;
- the input used for testing;
- the main bottleneck found in the original version;
- which optimization was applied;
- timing results from `/usr/bin/time`;
- system-call behavior from `strace -c`;
- CPU-counter evidence from `perf stat`, when available;
- a short explanation of whether the optimized script improved speed, reduced process creation, or improved safety/readability.

## Notes

- Logging and extra `echo` statements can change timing results, so benchmark the original and optimized scripts without adding extra debug output.
- Use the same input for original and optimized scripts whenever possible.
- Run each benchmark more than once if the numbers vary significantly.
- Keep raw outputs in `results/` so the final report can reference reproducible evidence instead of only screenshots or summaries.
