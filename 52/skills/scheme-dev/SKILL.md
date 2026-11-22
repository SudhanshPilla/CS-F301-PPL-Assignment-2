---
name: scheme-dev
description: Conventions, allowed built-ins, testing method and known AI pitfalls for the Racket work (S1, S2) in CS F301 Assignment 2.
---

# Scheme Development Skill

## Environment
- Racket 8.x, every file starts with `#lang racket/base`.
- Run a file: `racket 52/code/52_q3.rkt` (must print nothing).
- Run tests (from repo root): `racket 52/tests/52_q3_tests.rkt`, `racket 52/tests/52_q4_tests.rkt`.

## Allowed built-ins (nothing else)
define, lambda, let, let*, letrec, named let, if, cond (with else), and, or, not, begin,
quote ('), cons, car, cdr, list, c[ad]r compositions up to 4 levels, null?, pair?, eq?,
assq, assoc, + - * < > <= >= =, max, display, newline. S2 additionally: read.

## Coding conventions
- kebab-case names; own helpers are prefixed `my-` (my-length, my-map).
- A `;;` comment above every function giving its recursive reading
  (base case, then "a node is ... of its subtrees").
- All state passed through arguments; use accumulators instead of append/reverse.
- Prefer tail recursion where natural (named let with an accumulator).
- A value is a list iff `(or (null? x) (pair? x))`.
- Files contain only definitions: no top-level calls, no output on load.

## Self-review checklist (apply before answering)
1. First line is `#lang racket/base`.
2. Only allowed built-ins are used (search for append, reverse, length, map, list?, set!).
3. No top-level expression other than define.
4. Every print function ends with (newline).
5. The empty list () is handled in every function.
6. Every example from the assignment PDF produces exactly the expected output.

## Known AI failure modes in Scheme
- Using forbidden built-ins: append, reverse, length, map, filter, member, list?, symbol?,
  number?, null, empty, first, rest, when, unless, foldl, apply, printf, set!.
- Adding provide, module+ test, or test calls at top level (module prints their values).
- Using list? to separate atoms from lists (not allowed; use null?/pair?).
- Measuring a list's length after inserting into it (S2 requires the original length).
- Treating the top-level list or () as a special case when it should not be.
- Forgetting the trailing newline, or printing extra spaces/prompts.
