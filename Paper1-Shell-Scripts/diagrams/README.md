# Diagrams

This folder contains Mermaid flowcharts for Paper 1.

## Script Diagrams

- `blank-rename.mmd`
- `collatz.mmd`
- `days-between.mmd`
- `encryptedpw.mmd`
- `life.mmd`
- `mailformat.mmd`
- `makedict.mmd`
- `password.mmd`
- `rn.mmd`
- `soundex.mmd`

## Benchmark Workflow

```mermaid
flowchart TD
    A[Choose script] --> B[Prepare input files]
    B --> C[Run original script]
    C --> D[Save time, strace, and perf output]
    D --> E[Review bottlenecks]
    E --> F[Run optimized script]
    F --> G[Compare measurements]
    G --> H[Add results to report]
```

## File Organizer Logic

```mermaid
flowchart TD
    A[Start] --> B[Read target directory]
    B --> C{Valid directory?}
    C -- No --> D[Print error]
    C -- Yes --> E[Create output folders]
    E --> F[Read next file]
    F --> G[Check extension]
    G --> H{Category}
    H --> I[Documents]
    H --> J[Images]
    H --> K[Source_Code]
    H --> L[Archives]
    H --> M[Other]
    I --> N[Move file]
    J --> N
    K --> N
    L --> N
    M --> N
    N --> O{More files?}
    O -- Yes --> F
    O -- No --> P[Print moved-file count]
```
