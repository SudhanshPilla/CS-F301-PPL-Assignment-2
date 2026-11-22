
# Prolog Development Skill

## Environment
- Language: Prolog
- Runtime: SWI-Prolog
- Version required by assignment: SWI-Prolog 9.x
- Current development environment: SWI-Prolog 11.0.0

## Coding conventions
- Use declarative Prolog predicates.
- Prefer recursion, pattern matching, and backtracking.
- Use meaningful predicate and variable names.
- Keep predicates focused on one responsibility.
- Avoid unnecessary cuts.
- Do not use global state, assert, or retract.
- Do not print output from assignment predicates unless explicitly required.
- Do not include initialization directives or halt calls in submitted source files.

## Testing
- Test predicates directly from the SWI-Prolog command line.
- Test normal cases, boundary cases, and failure cases.
- Check exact output formats where required.
- Use PlUnit for automated tests.
- Run the complete test suite before committing.

## Arithmetic
- Use `is/2` for arithmetic evaluation.
- Use arithmetic comparisons such as `=:=`, `=\=`, and `>`.
- Check division by zero before division.
- For integer division, verify that the division is exact.
- Account for negative intermediate values.

## Expression trees
- Represent numbers as leaves.
- Represent binary operations as nodes containing an operator and two subtrees.
- Preserve the order of input numbers.
- Evaluate and render trees separately.
- Render parentheses according to operator precedence and associativity.

## Common mistakes to avoid
- Accidentally changing the order of input numbers.
- Allowing empty expression sides.
- Accepting non-exact division.
- Forgetting to reject division by zero.
- Producing duplicate equations.
- Returning equations in an unspecified order.
- Adding unnecessary spaces or parentheses to canonical strings.
- Testing only successful cases.

## AI-assisted development
- Ask for one focused predicate or task at a time.
- Do not ask an AI tool to generate the entire assignment solution.
- Verify every generated predicate against the assignment specification.
- Run tests independently and inspect failures.
- Record prompts used during development in the appropriate prompt log.
- Do not accept code without understanding its representation, recursion, and failure behavior.
