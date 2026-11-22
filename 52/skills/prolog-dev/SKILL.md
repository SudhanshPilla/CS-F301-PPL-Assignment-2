---
name: prolog-dev
description: Implement and review this assignment's Prolog predicates in SWI-Prolog 9.x.
---

# Prolog development instructions

- Target SWI-Prolog 9.x.
- Use lowercase predicate names, descriptive variables, and one clause per numbered puzzle clue.
- Read predicates declaratively: each clause states a relationship; avoid side effects and global state.
- Keep solution files to definitions, with no initialization directive or load-time output.
- For P1, represent a row as `p(Name, Department, Language, Project)`, use quoted atoms exactly as the assignment specifies, and preserve the Alex, Ben, Carla, Dana order.
- For counting, enumerate complete assignments with `findall/3`; apply only the clue numbers passed to the predicate.
- Use only the permitted libraries (`lists`, `apply`, `yall`, `aggregate`). Do not use `assert/1`, `retract/1`, or global variables.
- Run the P1 checks with `swipl -q -f tests/test_p1.pl -g run_p1_tests -t halt`; run the requested display with `swipl -q -f code/52_q1.pl -g main -t halt`.

## Self-review checklist

- Does each attribute use every allowed value exactly once?
- Does every clue predicate succeed exactly when its statement holds?
- Does counting ignore clues outside `Active`?
- Is the ninth clue independent of friend names and unique among solutions to clues 1–8?
- Does `main/0` print exactly four required lines and does loading the file print nothing?

## Known AI failure modes

- Confusing Prolog atom quoting and output formatting, especially `AI`, `Alex`, and `c++`.
- Accidentally counting duplicate permutations or using only some clues in the base solution generator.
- Treating a clue as a constraint on a named person when the wording refers to any friend.
- Adding initialization or diagnostic output that breaks the grader's invocation.
