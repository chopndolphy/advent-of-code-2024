package main

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:sort"
import "core:math"

main :: proc() {
    col1, col2: [dynamic]int
    data, ok := os.read_entire_file("input.txt", context.allocator)
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

    m := make(map[int]int)
    total: int
    prev: int

    for i := 0; i < len(col1); i+= 1 {
        m[col1[i]] = 0
    }
    for i := 0; i < len(col2); i+= 1 {
        mult, exists := m[col2[i]]
        if exists {
            m[col2[i]] = mult + 1
        }
    }

    for lval, count in m {
        total += lval * count
    }
    fmt.println(total)
}