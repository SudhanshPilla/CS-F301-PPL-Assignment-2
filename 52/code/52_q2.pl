:- use_module(library(lists)).

% Generate every binary expression tree using the numbers in order.
% A single number is a leaf.
expression_tree([N], num(N)).

% Split the list into two non-empty parts and combine their trees.
expression_tree(List, op(Op, Left, Right)) :-
    append(L, R, List),
    L \= [],
    R \= [],
    expression_tree(L, Left),
    expression_tree(R, Right),
    member(Op, [+, -, *, /]).
% Evaluate an expression tree.
eval_tree(num(N), N).

eval_tree(op(+, L, R), V) :-
    eval_tree(L, A),
    eval_tree(R, B),
    V is A + B.

eval_tree(op(-, L, R), V) :-
    eval_tree(L, A),
    eval_tree(R, B),
    V is A - B.

eval_tree(op(*, L, R), V) :-
    eval_tree(L, A),
    eval_tree(R, B),
    V is A * B.

eval_tree(op(/, L, R), V) :-
    eval_tree(L, A),
    eval_tree(R, B),
    B =\= 0,
    0 is A mod B,
    V is A // B.
% Operator precedence: + and - are 1, * and / are 2.
op_precedence(+, 1).
op_precedence(-, 1).
op_precedence(*, 2).
op_precedence(/, 2).

% Convert an expression tree into its canonical string.
render(num(N), S) :-
    number_string(N, S).

render(op(Op, L, R), S) :-
    render(L, LS),
    render(R, RS),
    op_precedence(Op, P),
    render_child(L, P, left, LS, LStr),
    render_child(R, P, right, RS, RStr),
    atom_string(Op, OpS),
    string_concat(LStr, OpS, T),
    string_concat(T, RStr, S).

% Parenthesize a child expression when required.
render_child(num(_), _, _, S, S).

render_child(op(ChildOp, _, _), ParentP, Side, S, Result) :-
    op_precedence(ChildOp, ChildP),
    ( ChildP < ParentP
    ; ChildP =:= ParentP,
      Side = right
    ),
    !,
    string_concat("(", S, T),
    string_concat(T, ")", Result).

render_child(op(ChildOp, _, _), ParentP, left, S, S) :-
    op_precedence(ChildOp, ChildP),
    ChildP >= ParentP.

render_child(op(ChildOp, _, _), ParentP, right, S, S) :-
    op_precedence(ChildOp, ChildP),
    ChildP > ParentP.
% Generate one valid equation by splitting the list into two sides.
generate_equation(List, Equation) :-
    append(LeftNums, RightNums, List),
    LeftNums \= [],
    RightNums \= [],
    expression_tree(LeftNums, LeftTree),
    expression_tree(RightNums, RightTree),
    eval_tree(LeftTree, LeftValue),
    eval_tree(RightTree, RightValue),
    LeftValue =:= RightValue,
    render(LeftTree, LeftString),
    render(RightTree, RightString),
    string_concat(LeftString, "=", Temp),
    string_concat(Temp, RightString, Equation).

% Collect all unique equations in sorted order.
all_equations(List, Equations) :-
    findall(E, generate_equation(List, E), Generated),
    sort(Generated, Equations).

% Count the equations.
count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).