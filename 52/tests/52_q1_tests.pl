% Lightweight tests for 52_q1.pl. Run from the 52 directory with:
% swipl -q -f tests/52_q1_tests.pl -g run_p1_tests -t halt
:- consult('code/52_q1.pl').

check(Goal) :-
    ( call(Goal) -> true ; throw(error(test_failed(Goal), _)) ).

check_not(Goal) :-
    ( call(Goal) -> throw(error(test_unexpected_success(Goal), _)) ; true ).

run_p1_tests :-
    check((count_solutions([1,2,3,4,5,6,7,8], 3))),
    check((count_solutions([1,2,3,4,5,6,7,8,9], 1))),
    check((solution(Solution),
           all_clues_1_to_9(Solution),
           Solution = [p('Alex', design, java, embedded),
                       p('Ben', development, javascript, web),
                       p('Carla', testing, python, 'AI'),
                       p('Dana', research, 'c++', data)])),
    check_not((solution(Solution),
               all_clues_1_to_8(Solution),
               clue(9, Solution),
               Solution = [p('Alex', design, java, 'AI'), _, _, _])).
