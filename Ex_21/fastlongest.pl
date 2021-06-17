second([_,B],B).
first([A,_],A).

min2(A,B,Res):-
    A < B -> Res = A; Res = B.

max(A,B,Res):-
    A > B -> Res = A; Res = B.

tupleCompare([X1,Y1],[X2,Y2],Res):-

    compare(FirstComp,X1,X2),
    compare(SecondComp,Y1,Y2),
    FirstComp = (=) -> 
    Res = SecondComp ;
    compare(FirstComp,X1,X2),
    Res = FirstComp.

smallerthan(A,B,Res):-
    A<B -> Res = true;
    Res = false.
greaterthan(A,B,Res):-
    A>B -> Res = true;
    Res = false.
notequal(A,B,Res):-
    A==B -> Res = false;
    Res = true.


prolog_while(PreSum,V,L,H,Ans,Answer) :-%Add Mid1
% (
(  L =< H ->
    Mid1 is (L+H)div 2,
    nth0(Mid1, PreSum, X),
    first(X,Z),
(    Z =< V ->
    Ans1 = Mid1,
    L1 is Mid1 + 1,
    prolog_while(PreSum,V,L1,H,Ans1,Answer)%Add Mid1
    ;
    Mid1 is (L+H)div 2,
    H1 is Mid1 -1,
    prolog_while(PreSum,V,L,H1,Ans,Answer))
    ;
         Answer = Ans
).

findInd(PreSum,V,N,Res):-
    L is 0,
    H is N-1,%there was a -1 once
    Ans is -1,
    prolog_while(PreSum,V,L,H,Ans,Res).

    % ).
fakefi(I,Ans):-
    nth0(I,[9,10,8,7,2,3,5,0,4,6,1,5],Ans).

for1(_,[],[]).
for1(X,[H|Tail],[NewHead|NewTail]):-
    NewHead is (-1*(H+X)),
    for1(X,Tail,NewTail).

for2(_,_,[],[]).
for2(I,Sum,[Head|Tail],[PSHead|PSTail]):-
    S is Sum+Head,
    PSHead = [S,I],
    I1 is I+1,
    for2(I1,S,Tail,PSTail).

for3(_,[],[]).
for3(MinInd,[[_,Sec]|Tail],[MIHead|MITail]):-

    % second(Head,Sec),
    min2(MinInd,Sec,MIHead),
    for3(MIHead,Tail,MITail).

findmax([],[],Ans,Ans).
findmax([[_|PSHead]|PSTail],[MIHead|MITail],Max,Ans):-
    Dif is PSHead - MIHead,
    max(Max,Dif,Next),
    findmax(PSTail,MITail,Next,Ans).

longestSub(Arr,_,X,Ans):-
    for1(X,Arr,A),
    for2(0,0,A,PreSum),
    sort(PreSum,PreSumSorted),
    nth0(0,PreSumSorted,MIT),
    second(MIT,MI),
    for3(MI,PreSumSorted,MinInd),
    findmax(PreSumSorted,MinInd,-1,Ans).

    % for4(A,MinInd,PreSumSorted,N,Ans).



%read from file-----
read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).
%----

longest(Filename,Ans):-
    read_input(Filename,N,Hospitals,Data),
    Fixed = [0|Data],
    longestSub(Fixed,N,Hospitals,Ans).