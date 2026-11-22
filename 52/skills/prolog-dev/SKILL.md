# Prolog Development Skill

## Environment
- Language: Prolog
- Runtime: SWI-Prolog
- Required version: SWI-Prolog 9.x
- Development environment: SWI-Prolog 11.0.0

## Coding Conventions
- Use declarative Prolog predicates.
- Prefer recursion, pattern matching, and backtracking.
- Use meaningful predicate and variable names.
- Keep predicates focused on one responsibility.
- Avoid unnecessary cuts.
- Do not use global state, `assert/1`, or `retract/1`.
- Do not print output unless explicitly required.
- Do not include initialization directives or `halt/0` in submitted source files.

## Testing
- Test predicates directly from the SWI-Prolog command line.
- Test normal, boundary, and failure cases.
- Check exact output formats.
- Use PlUnit for automated tests.
- Run the complete test suite before committing.

## Arithmetic
- Use `is/2` for arithmetic evaluation.
- Use arithmetic comparisons such as `=:=`, `=\=`, and `>`.
- Check division by zero before division.
- For integer division, verify that division is exact.
- Account for negative intermediate values.

## Expression Trees
- Represent numbers as leaves.
- Represent binary operations as nodes containing an operator and two subtrees.
- Preserve the order of input numbers.
- Evaluate and render trees separately.
- Render parentheses according to operator precedence and associativity.

## Common Mistakes
- Changing the order of input numbers.
- Allowing empty expression sides.
- Accepting non-exact division.
- Forgetting to reject division by zero.
- Producing duplicate equations.
- Returning equations in unspecified order.
- Adding unnecessary spaces or parentheses.
- Testing only successful cases.

## AI-Assisted Development
- Ask for one focused predicate or task at a time.
- Do not ask an AI tool to generate the entire assignment solution.
- Verify generated predicates against the assignment specification.
- Run tests independently and inspect failures.
- Record prompts in the appropriate prompt log.
- Understand the representation, recursion, and failure behavior of all accepted code.