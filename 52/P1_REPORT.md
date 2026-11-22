# P1 Report

## Clues 1–8

`count_solutions([1,2,3,4,5,6,7,8], N)` gives **N = 3**. The original eight clues do not determine a unique assignment; three complete assignments satisfy them.

## Ninth clue

The added clue is: **The friend working in the testing department prefers the AI project.**

It is true in exactly one of the three assignments, so `count_solutions([1,2,3,4,5,6,7,8,9], N)` gives **N = 1**.
