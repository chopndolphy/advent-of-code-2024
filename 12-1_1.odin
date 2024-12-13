package main

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:sort"
import "core:math"

main :: proc() {
    col1, col2: [dynamic]int
    data, ok := os.read_entire_file("12-1_input.txt", context.allocator)
    if !ok {
        fmt.println("didnt open file")
        return
    }
    defer delete(data, context.allocator)

    it := string(data)
    for line in strings.split_lines_iterator(&it) {
        numbers:= strings.split(line, "   ")
        append(&col1, strconv.atoi(numbers[0]))
        append(&col2, strconv.atoi(numbers[1]))
    }

    sort.quick_sort(col1[:])
    sort.quick_sort(col2[:])
    total: int

    for i := 0; i < len(col1); i+= 1 {
        distance: int = col1[i] - col2[i]
        distance = math.abs(distance)
        total += distance
    }
    fmt.println(total)
}