# Exercise 1.7: FizzBuzz

## Objective

Implement the classic FizzBuzz problem in Zig, synthesizing what you've learned in Module 1.

## Rules

For numbers 1 to 20:
- If divisible by 3 AND 5, print "FizzBuzz"
- If divisible by 3 only, print "Fizz"
- If divisible by 5 only, print "Buzz"
- Otherwise, print the number

## Expected Output

```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
```

## Concepts Tested

- For loops
- Conditionals (if/else or switch)
- Modulo operator (%)
- Print formatting

## Challenge Extension

After completing the basic version:
- Can you solve it using switch instead of if/else?
- Can you make it print on a single line separated by commas?

## Verification

```bash
zig build test-ex-01-07
```
