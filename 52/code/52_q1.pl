:- use_module(library(lists), [member/2, permutation/2]).

% A solution uses every value in each attribute exactly once.
solution(Solution) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]),
    Solution = [p('Alex', D1, L1, P1),
                p('Ben', D2, L2, P2),
                p('Carla', D3, L3, P3),
                p('Dana', D4, L4, P4)].

% Clue 1: The friend who prefers AI does not work in research and is not Dana.
clue(1, Solution) :-
    member(p(Name, Department, _, 'AI'), Solution),
    Department \= research,
    Name \= 'Dana'.

% Clue 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Department, Language, _), Solution),
    Department \= development,
    Language \= 'c++'.

% Clue 3: The friend working in testing likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Department, _, web), Solution),
    Department \= testing.

% Clue 5: The friend whose favorite language is Java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla does not prefer embedded, and her department is not development.
clue(6, Solution) :-
    member(p('Carla', Department, _, Project), Solution),
    Project \= embedded,
    Department \= development.

% Clue 7: Dana's favorite language is not Java, and she works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Department, Language, _), Solution),
    Language \= java,
    (Department = research ; Department = testing).

% Clue 8: The friend who prefers data works in research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Language, data), Solution),
    Language \= javascript.

% CLUE 9: The friend working in the testing department prefers the AI project.
clue(9, Solution) :-
    member(p(_, testing, _, 'AI'), Solution).

all_clues_1_to_8(Solution) :-
    clue(1, Solution),
    clue(2, Solution),
    clue(3, Solution),
    clue(4, Solution),
    clue(5, Solution),
    clue(6, Solution),
    clue(7, Solution),
    clue(8, Solution).

all_clues_1_to_9(Solution) :-
    all_clues_1_to_8(Solution),
    clue(9, Solution).

% Check that each clue number in Active holds, ignoring all others.
satisfies_active([], _).
satisfies_active([Number | Rest], Solution) :-
    clue(Number, Solution),
    satisfies_active(Rest, Solution).

count_solutions(Active, N) :-
    findall(Solution,
            (solution(Solution), satisfies_active(Active, Solution)),
            Solutions),
    length(Solutions, N).

main :-
    once((solution(Solution), all_clues_1_to_9(Solution))),
    print_solution(Solution).

print_solution([]).
print_solution([p(Name, Department, Language, Project) | Rest]) :-
    format('~w = [~w, ~w, ~w]~n', [Name, Department, Language, Project]),
    print_solution(Rest).
