
:- begin_tests(q2).

:- consult('../code/52_q2.pl').

test(one_equation, true(E == "2*4=8")) :-
    once(generate_equation([2,4,8], E)).

test(official_example, true(Es == [
    "4*2-5=3",
    "4*2=5+3",
    "4-2=5-3",
    "4/2=5-3",
    "4=2*(5-3)",
    "4=2+(5-3)",
    "4=2+5-3"
])) :-
    all_equations([4,2,5,3], Es).

test(no_equations, true(Es == [])) :-
    all_equations([2,3,4], Es).

test(count, true(N == 1)) :-
    count_equations([2,4,8], N).

test(empty_list, [fail]) :-
    generate_equation([], _).

test(single_number, [fail]) :-
    generate_equation([7], _).

test(non_exact_division, [fail]) :-
    eval_tree(op(/,num(5),num(2)), _).

test(divide_by_zero, [fail]) :-
    eval_tree(op(/,num(5),num(0)), _).

test(negative_result, true(V == -2)) :-
    eval_tree(op(/,num(-6),num(3)), V).

:- end_tests(q2).
