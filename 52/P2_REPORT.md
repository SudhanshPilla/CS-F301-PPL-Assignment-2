# P2 Report — Equation Generator

## 1. Problem Overview

The objective of P2 is to generate valid equations from a given sequence of numbers while preserving their order. The generated equations must satisfy the arithmetic and formatting requirements specified in the assignment.

## 2. Approach

The solution uses recursive expression-tree generation.

- Each expression tree represents an arithmetic expression using the input numbers in their original order.

- The input sequence is divided into two non-empty contiguous parts to form the left-hand and right-hand sides.

- Expression trees are generated for both sides.

- Each pair of expressions is evaluated, and equations with equal values are retained.

- Valid equations are rendered as strings and duplicate equations are removed.

## 3. Implementation

The implementation consists of the following predicates:

- `expression_tree/2` — generates expression trees from the input numbers.

- `eval_tree/2` — evaluates an expression tree using the supported arithmetic operators.

- `render/2` — converts an expression tree into a formatted equation expression.

- `generate_equation/2` — generates a valid equation from the input sequence.

- `all_equations/2` — collects and sorts all valid equations.

- `count_equations/2` — counts the distinct valid equations.

Division by zero and non-exact division are rejected. Negative intermediate results are permitted.

## 4. Testing

The implementation was tested using the assignment's examples and additional edge cases.

| Input | Expected result |
|---|---|
| `[4,2,5,3]` | 7 distinct equations |
| `[2,3,4]` | No valid equations |
| `[2,4,8]` | `2*4=8` |
| `[2,4,8]` count | 1 |

Additional tests cover empty input, single-element input, division by zero, non-exact division, and negative results.

## 5. Test Results

All 9 P2 unit tests passed using SWI-Prolog.

## 6. AI Assistance

AI assistance was used during development to help with implementation, testing, and reviewing the Prolog predicates. The generated solution was tested against the assignment examples and additional unit tests.
