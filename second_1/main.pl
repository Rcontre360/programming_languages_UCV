% Define the triangle levels
triangleLevel([1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5]).
isEmpty([false,true,false,false,false,false,false,false,false,false,false,false,false,false,false]).

printList([]).
printList([H|T]) :-
    write(H), nl,  % Write the current element and a newline
    printList(T). % Recursively print the rest of the list

mapToTuples([], _, []).
mapToTuples([X | Rest], Element, [(Element,X) | Tuples]) :-
    mapToTuples(Rest, Element, Tuples).

flatten([], []).
flatten([H|T], Flat) :-
    is_list(H),
    flatten(H, FlatH),
    flatten(T, FlatT),
    append(FlatH, FlatT, Flat).
flatten([H|T], [H|FlatT]) :-
    \+ is_list(H),
    flatten(T, FlatT).

modifyAtIndex([], _, _, []).
modifyAtIndex([_|Rest], 1, Value, [Value|Rest]).
modifyAtIndex([X|Rest], Index, Value, [X|ResTail]) :-
    Index > 1,
    NewIndex is Index - 1,
    modifyAtIndex(Rest, NewIndex, Value, ResTail).

modifyPuzzle(Index, Value, X):-
    triangleLevel(Levels),  
    modifyAtIndex(Levels,Index,Value, X).

% Predicate to check the difference between two numbers levels
isLevelDifference(Cur, Nxt, Diff) :-
    triangleLevel(Levels),  
    nth1(Cur, Levels, LevelCur),  
    nth1(Nxt, Levels, LevelNxt),  
    (
        LevelCur >= LevelNxt, 
        CurDiff is LevelCur - LevelNxt,
        Diff = CurDiff
        ;
        LevelCur < LevelNxt, 
        CurDiff is LevelNxt - LevelCur,
        Diff = CurDiff
    ).

% Predicate to check if a move from Cur to Nxt is valid
isValidMove(Cur, Nxt,Puzzle) :- 
    isIntermediate(Cur,Nxt,Inter),

    nth1(Cur, Puzzle, false),
    nth1(Nxt, Puzzle, true),
    nth1(Inter, Puzzle, false), %check if intermediate is full

    triangleLevel(Levels),  
    nth1(Cur, Levels, LevelCur),  
    isLevelDifference(Cur, Nxt, LevelDiff),  
(
    (Nxt =:= Cur - 2*LevelCur + 1, LevelDiff = 2);  %arriba a la izq
    (Nxt =:= Cur - 2*LevelCur + 3, LevelDiff = 2); %arriba a la derecha
    (Nxt =:= Cur - 2, LevelDiff = 0); % izquierda
    (Nxt =:= Cur + 2, LevelDiff = 0); % derecha
    (Nxt =:= Cur + 2*LevelCur + 1, LevelDiff = 2); % abajo a la izquierda
    (Nxt =:= Cur + 2*LevelCur + 3, LevelDiff = 2) % abajo a la derecha
).

isIntermediate(Cur, Nxt, Inter) :- 
    triangleLevel(Levels),  
    nth1(Cur, Levels, LevelCur),  
    isLevelDifference(Cur, Nxt, LevelDiff),  
(
    (Nxt =:= Cur - 2*LevelCur + 1, LevelDiff = 2, Calc is Cur - LevelCur, Inter = Calc);  %arriba a la izq
    (Nxt =:= Cur - 2*LevelCur + 3, LevelDiff = 2, Calc is Cur - LevelCur + 1, Inter = Calc); %arriba a la derecha
    (Nxt =:= Cur - 2, LevelDiff = 0, Calc is Cur - 1, Inter = Calc); % izquierda
    (Nxt =:= Cur + 2, LevelDiff = 0, Calc is Cur + 1, Inter = Calc); % derecha
    (Nxt =:= Cur + 2*LevelCur + 1, LevelDiff = 2, Calc is Cur + LevelCur, Inter = Calc); % abajo a la izquierda
    (Nxt =:= Cur + 2*LevelCur + 3, LevelDiff = 2, Calc is Cur + LevelCur + 1, Inter = Calc) % abajo a la derecha
).

% Predicate to find all valid moves
allValidMoves(Puzzle, Cur, ValidMoves) :-
    findall(Nxt, isValidMove(Cur, Nxt, Puzzle), ValidMoves).

% Predicate to check if the puzzle is solved
isSolved([], IsOneFilled) :- IsOneFilled.
isSolved([Cur | Rest],IsOneFilled) :-
    (
        Cur = true, isSolved(Rest,IsOneFilled)
    )
    ;
    (
        Cur = false, IsOneFilled = false, isSolved(Rest,true)
    ).

isValidTransition(Puzzle, NxtPuzzle,From,To) :-
    isValidMove(From,To,Puzzle),
    isIntermediate(From,To,Inter),

    modifyAtIndex(Puzzle, From, true, FirstChange),
    modifyAtIndex(FirstChange, To, false, SecondChange),
    modifyAtIndex(SecondChange, Inter, true, NxtPuzzle).

isSolutionInTransitionList([],_) :- false.
isSolutionInTransitionList([(_,_,CurTransition) | Transitions],Count) :-
    Count > 1,
    NxtCount is Count - 1,
    (
        canBeSolved(CurTransition,NxtCount)
        ;
        isSolutionInTransitionList(Transitions,Count)
    ).
    
canBeSolved(Puzzle,[]) :- isSolved(Puzzle,false).
canBeSolved(Puzzle,Count) :-
    Count>=1,
    (
        isSolved(Puzzle, false)
        ;
        (
        areAllValidTransitions(Puzzle,Transitions),
        length(Transitions,Length),
        write("\n"),
        write(Length),
        write("\n"),
        isSolutionInTransitionList(Transitions,Count)
        )
    ).

transitionFromMovement(_,[],[]).
transitionFromMovement(Puzzle,[(From,To)|NxtMoves],[(From,To,CurTran)|NxtTran]):-
    isValidTransition(Puzzle,CurTran,From,To),
    transitionFromMovement(Puzzle,NxtMoves,NxtTran).

areAllValidTransitions(Puzzle, Transitions) :-
    areValidMovements(Puzzle, Movements),
    transitionFromMovement(Puzzle,Movements,Transitions).
    %findall((From,To, Solution), isValidTransition(Puzzle, Solution, From, To) ,Transitions).

areValidMovements(Puzzle,Movements):-
    isListValidMovements(Puzzle,1,ListMov),
    flatten(ListMov,Movements).

isListValidMovements(_, 16, []).
isListValidMovements(Puzzle, From, [MappedMov | NxtOnes]) :-
    From =< 15,
    allValidMoves(Puzzle, From, Movements),
    mapToTuples(Movements, From,MappedMov),
    NxtFrom is From + 1,
    isListValidMovements(Puzzle, NxtFrom, NxtOnes).

main(Num) :-
    %tell('./pinga.txt'),
    isEmpty(Puzzle),
    canBeSolved(Puzzle,Num).
    %told.

% Define a predicate that extracts the first and second elements from a tuple
extractFirstAndSecond((First, Second, _), (First, Second)).

% Define a predicate to process the list of tuples
getMovements([], []).
getMovements([Tuple | Rest], [(First, Second) | Result]) :-
    extractFirstAndSecond(Tuple, (First, Second)),
    getMovements(Rest, Result).

    









