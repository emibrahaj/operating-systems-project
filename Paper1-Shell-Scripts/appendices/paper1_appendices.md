# Paper 1 Appendices

This file lists the supporting material used for the Shell Script Analysis and Optimization paper.

## Appendix A: Source Files

Original scripts:

- `scripts_original/blank-rename.sh`
- `scripts_original/collatz.sh`
- `scripts_original/days-between.sh`
- `scripts_original/encryptedpw.sh`
- `scripts_original/life.sh`
- `scripts_original/mailformat.sh`
- `scripts_original/makedict.sh`
- `scripts_original/password.sh`
- `scripts_original/rn.sh`
- `scripts_original/soundex.sh`

Optimized scripts:

- `scripts_optimized/blank-rename_optimized.sh`
- `scripts_optimized/collatz_optimized.sh`
- `scripts_optimized/days-between_optimized.sh`
- `scripts_optimized/encryptedpw_optimized.sh`
- `scripts_optimized/life_optimized.sh`
- `scripts_optimized/mailformat_optimized.sh`
- `scripts_optimized/makedict_optimized.sh`
- `scripts_optimized/password_optimized.sh`
- `scripts_optimized/rn_optimized.sh`
- `scripts_optimized/soundex_optimized.sh`

New script:

- `src/file_organizer.sh`

## Appendix B: Datasets

Input files:

- `datasets/emails/sample_email.txt`
- `datasets/encryptedpw/test_upload.txt`
- `datasets/life/gen0`
- `datasets/life_grids/gen0`
- `datasets/organizer_test/`
- `datasets/rename_test/`
- `datasets/rn_test/`
- `datasets/text/sample_text.txt`

The rename datasets are kept small because `rn.sh` and `blank-rename.sh` change filenames while running.

## Appendix C: Measurements

Raw benchmark output is stored in `results/`.

Measurement files include:

- `/usr/bin/time -v` output
- `strace -c` output
- `perf stat` output

Grouped copies are stored in:

- `results/time/`
- `results/strace/`
- `results/perf/`

Appendix copies are stored in:

- `appendices/raw_results/time/`
- `appendices/raw_results/strace/`
- `appendices/raw_results/perf/`

Screenshots are stored in `results/screenshots/` and copied to `appendices/screenshots/`. The screenshot list is in `appendices/screenshot_inventory.md`.

## Appendix D: File Organizer Script

`src/file_organizer.sh` is the new script for Section 8. It sorts files in a target directory into folders based on extension.

Categories:

- `Documents`
- `Images`
- `Source_Code`
- `Archives`
- `Other`

Algorithm:

1. Read the target directory, or use the current directory if none is given.
2. Check that the directory exists.
3. Create the category folders.
4. Loop through the files in the target directory.
5. Read each file extension.
6. Move the file to the matching category.
7. Print the number of files moved.

Test files:

- `datasets/organizer_test/report.pdf`
- `datasets/organizer_test/photo.png`
- `datasets/organizer_test/script.sh`
- `datasets/organizer_test/archive.zip`
- `datasets/organizer_test/random.xyz`

Expected placement:

- `report.pdf` -> `Documents/`
- `photo.png` -> `Images/`
- `script.sh` -> `Source_Code/`
- `archive.zip` -> `Archives/`
- `random.xyz` -> `Other/`
