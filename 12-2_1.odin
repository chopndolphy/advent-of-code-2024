package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:math"

main :: proc() {
    data, ok := os.read_entire_file("12-2_input.txt", context.allocator)
    if !ok {
        fmt.println("didnt open file")
        return
    }
    defer delete(data, context.allocator)

    arr: [][] int = make([][]int, 1000)

    it := string(data)
    linenum:= 0
    for line in strings.split_lines_iterator(&it) {
        numbers:= strings.split(line, " ")
        arr[linenum] = make([]int, len(numbers))
        for i:=0; i < len(numbers); i+=1 {
            arr[linenum][i] = strconv.atoi(numbers[i])
        }
        linenum += 1
    }


    total: int
    for i:=0; i < len(arr); i+=1 {
        valid:= true 
        increasing: bool
        prev: int
        for j:=0; j < len(arr[i]); j+=1 {
            if j == 0 {
                prev = arr[i][j]
                continue
            }
            diff:= arr[i][j] - prev
            distance := math.abs(diff)
            if distance > 3 || distance < 1 {
                valid = false
                break
            }
            if j == 1 {
                if diff > 0 {
                    increasing = true
                } else {
                    increasing = false
                }
                prev = arr[i][j]
                continue
            }
            if increasing && diff < 0 {
                valid = false 
            }
            if !increasing && diff > 0 {
                valid = false
            }
            prev = arr[i][j]
        }
        if valid {
            total += 1
        }
    }
    fmt.println(total)
}