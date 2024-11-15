init_triangle([[1],
              [1,1],
             [1,1,1],
            [1,1,0,1],
           [1,1,1,1,1]]).

% select/4 except it exposes the index of the replacement
swap_list(J, L1, E1, L2, E2) :-
    var(J) % if index is known in advance, do deterministic search
    -> swap_list_any(0, J, L1, E1, L2, E2)
    ;  swap_list_det(J, L1, E1, L2, E2).

swap_list_det(0, [E1|R], E1, [E2|R], E2) :- !.
swap_list_det(J, [F|R1], E1, [F|R2], E2) :-
    Jm1 is J-1,
    swap_list_det(Jm1, R1, E1, R2, E2).

swap_list_any(J, J, [E1|R], E1, [E2|R], E2).
swap_list_any(A, J, [F|R1], E1, [F|R2], E2) :-
    Ap1 is A+1,
    swap_list_any(Ap1, J, R1, E1, R2, E2).

% implement peg indexing by (I,J) position in triangular lists
swap_triangle((I,J), T1, E1, T2, E2) :-
    swap_list(I, T1, Row1, T2, Row2),
    swap_list(J, Row1, E1, Row2, E2).

% => easy to compute neighbors in the 6 directions
tri_neighbor((I ,J1), (I ,J2), 0) :- succ(J1,J2).
tri_neighbor((I1,J ), (I2,J ), 1) :- succ(I2,I1).
tri_neighbor((I1,J1), (I2,J2), 2) :- succ(I2,I1), succ(J2,J1).
tri_neighbor((I ,J1), (I ,J2), 3) :- succ(J2,J1).
tri_neighbor((I1,J ), (I2,J ), 4) :- succ(I1,I2).
tri_neighbor((I1,J1), (I2,J2), 5) :- succ(I1,I2), succ(J1,J2).

checkers_move([Start,End], T1, T2) :-
    swap_triangle(Start, T1, 1, Ta, 0),% take jumping peg
    tri_neighbor(Start, Mid, Dir),     % locate victim peg
    tri_neighbor(Mid, End, Dir),       % locate landing spot
    swap_triangle(Mid, Ta, 1, Tb, 0),  % remove victim peg
    swap_triangle(End, Tb, 0, T2, 1).  % place jumping peg

solve :-
    init_triangle(Tinit),
    length(CoordMoves, 13),
    scanl(checkers_move, CoordMoves, Tinit, Ts),
    maplist(print_tri, Ts).

print_tri(T) :- format("    ~w~n   ~w~n  ~w~n ~w~n~w~n", T).
