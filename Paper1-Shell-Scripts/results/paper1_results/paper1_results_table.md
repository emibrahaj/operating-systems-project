| Script | Version | Input | Execution Time | Max Memory | Main Bottleneck / Observation |
|---|---|---|---:|---:|---|
| blank-rename | Original | 4 rename-test files | 0:00.01 | 3888 KB | repeated filename parsing and external command use |
| blank-rename | Optimized | 4 rename-test files | 0:00.00 | 3928 KB | direct filename handling reduces loop overhead |
| collatz | Original | seed 27 | 0:00.01 | 3932 KB | repeated formatted output inside arithmetic loop |
| collatz | Optimized | seed 27, `--silent` | 0:00.00 | 3944 KB | computation measured separately from printing |
| days-between | Original | two date values | 0:00.00 | 7724 KB | date parsing and command invocation overhead |
| days-between | Optimized | two date values | 0:00.01 | 9276 KB | optimization did not improve this small input case |
| encryptedpw | Original | `datasets/encryptedpw/test_upload.txt` | 0:00.00 | 7412 KB | password/encryption command path |
| encryptedpw | Optimized | `datasets/encryptedpw/test_upload.txt` | 0:42.02 | 9548 KB | unusually slow run; should be discussed or rechecked |
| life | Original | `datasets/life/gen0` | 0:26.60 | 8008 KB | repeated display, sleeps, and text processing |
| life | Optimized | `datasets/life/gen0` | 0:03.28 | 7940 KB | reduced delay and generation-loop overhead |
| mailformat | Original | `datasets/emails/sample_email.txt` | 0:00.00 | 8004 KB | text-formatting pipeline overhead |
| mailformat | Optimized | `datasets/emails/sample_email.txt` | 0:00.00 | 7820 KB | streamlined text transformation |
| makedict | Original | `datasets/text/sample_text.txt` | 0:00.00 | 8516 KB | filtering and sorting pipeline overhead |
| makedict | Optimized | `datasets/text/sample_text.txt` | 0:00.00 | 8916 KB | small input makes improvement hard to measure |
| password | Original | default generation | 0:00.00 | 3860 KB | random/password generation command overhead |
| password | Optimized | default generation | 0:00.00 | 7912 KB | output remains fast; memory rose in this run |
| rn | Original | 4 rename-test files | 0:00.02 | 7540 KB | `sed`, `basename`, and unquoted filename handling |
| rn | Optimized | 4 rename-test files | 0:00.00 | 3876 KB | parameter expansion and safer filename handling |
| soundex | Original | `Harrison` | 0:00.03 | 7884 KB | repeated external text-processing commands |
| soundex | Optimized | `Harrison` | 0:00.00 | 4032 KB | simplified character mapping and filtering |
