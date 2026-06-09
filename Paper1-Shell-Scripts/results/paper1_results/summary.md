# Results Summary

The clearest improvements came from scripts that originally spent extra work on repeated output, repeated text processing, or unnecessary external commands.

Main observations:

- `life.sh` improved from `0:26.60` to `0:03.28`.
- `soundex.sh` improved from `0:00.03` to `0:00.00`, and memory dropped from `7884 KB` to `4032 KB`.
- `rn.sh` improved from `0:00.02` to `0:00.00`, and memory dropped from `7540 KB` to `3876 KB`.
- `collatz.sh` is faster in the optimized test because `--silent` removes the printing cost from the computation loop.

Notes:

- Some inputs are very small, so several measurements round to `0:00.00`.
- `encryptedpw_optimized.sh` currently has a recorded time of `0:42.02`. This should be treated as an outlier unless a repeated run gives the same result.

The full table is in `paper1_results_table.md`.
