#!/bin/bash
# Optimized Game of Life
# Removes repeated sed calls, reduces string-array conversions, and supports benchmark mode.

startfile=${1:-gen0}
GENERATIONS=${GENERATIONS:-10}
DELAY=${DELAY:-0}

ALIVE="."
DEAD="_"

if [ ! -f "$startfile" ]; then
    echo "Startfile \"$startfile\" missing!"
    exit 86
fi

mapfile -t raw_lines < <(grep -v '^#' "$startfile" | grep -v '^$')

ROWS=${#raw_lines[@]}
COLS=${#raw_lines[0]}

declare -a grid
declare -a next

index() {
    echo $(( $1 * COLS + $2 ))
}

load_grid() {
    local r c char pos

    for ((r=0; r<ROWS; r++)); do
        for ((c=0; c<COLS; c++)); do
            char="${raw_lines[$r]:$c:1}"
            pos=$(index "$r" "$c")
            grid[$pos]="$char"
        done
    done
}

display_grid() {
    local r c pos alive_count=0

    for ((r=0; r<ROWS; r++)); do
        for ((c=0; c<COLS; c++)); do
            pos=$(index "$r" "$c")

            if [ "${grid[$pos]}" = "$ALIVE" ]; then
                printf "."
                ((alive_count++))
            else
                printf " "
            fi
        done
        echo
    done

    echo "Alive cells: $alive_count"
}

count_neighbors() {
    local row=$1
    local col=$2
    local count=0
    local dr dc nr nc pos

    for dr in -1 0 1; do
        for dc in -1 0 1; do
            if [ "$dr" -eq 0 ] && [ "$dc" -eq 0 ]; then
                continue
            fi

            nr=$((row + dr))
            nc=$((col + dc))

            if (( nr >= 0 && nr < ROWS && nc >= 0 && nc < COLS )); then
                pos=$(index "$nr" "$nc")

                if [ "${grid[$pos]}" = "$ALIVE" ]; then
                    ((count++))
                fi
            fi
        done
    done

    echo "$count"
}

next_generation() {
    local r c pos neighbors current

    for ((r=0; r<ROWS; r++)); do
        for ((c=0; c<COLS; c++)); do
            pos=$(index "$r" "$c")
            current="${grid[$pos]}"
            neighbors=$(count_neighbors "$r" "$c")

            if [ "$current" = "$ALIVE" ] && { [ "$neighbors" -eq 2 ] || [ "$neighbors" -eq 3 ]; }; then
                next[$pos]="$ALIVE"
            elif [ "$current" = "$DEAD" ] && [ "$neighbors" -eq 3 ]; then
                next[$pos]="$ALIVE"
            else
                next[$pos]="$DEAD"
            fi
        done
    done

    for ((pos=0; pos<ROWS*COLS; pos++)); do
        grid[$pos]="${next[$pos]}"
    done
}

load_grid

echo "Game of Life Optimized"
echo "Grid: ${ROWS}x${COLS}"
echo "Generations: $GENERATIONS"
echo

for ((gen=0; gen<=GENERATIONS; gen++)); do
    echo "Generation $gen"
    display_grid
    echo

    if [ "$gen" -lt "$GENERATIONS" ]; then
        next_generation
        sleep "$DELAY"
    fi
done

exit 0
