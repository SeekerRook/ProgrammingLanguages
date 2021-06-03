% contains code from https://stackoverflow.com/questions/8429479/sorting-a-list-in-prolog
issorted([]).
issorted([_]).
issorted([Head|[Head2|Tail]]):-
    Head =< Head2, issorted([Head2|Tail]).

queue([H|T],[],T,[H]).
queue([H|T],[S|T2],T,[H,S|T2]).
    
stack([],[S|T],[S],T).
stack([H|T],[S|T2],Ans,T2):-
    append([H|T],[S],Ans).

read_input(File, N, C) :-
    open(File, read, Stream),
    read_line(Stream, N),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).


move(Queue,Stack,q,NextQueue,NextStack) :-
    queue(Queue,Stack,NextQueue,NextStack).
move(Queue,Stack,s,NextQueue,NextStack) :-
    stack(Queue,Stack,NextQueue,NextStack).

notempty([_|_]).

validmove(Q,_,q):-
    notempty(Q).

validmove(_,S,s):-
    notempty(S).

quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(_,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X>=H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X<H,pivoting(H,T,L,G).

    
same([H|T],[H|T]).

solution([Head|T], [],[_]):-
    final([Head|T]).

solution(Q,S,[Move|Moves]):-
    move(Q,S,Move,NQ,NS),
    validmove(Q,S,Move),
    solution(NQ,NS,Moves).
butlast([_],[]).

butlast([Head|Tail],[Head|Next]):-
    butlast(Tail,Next).

listtostring([q],'Q').
listtostring([s],'S').
listtostring([],'empty').

listtostring([q|T],Ans):-
    listtostring(T,Res),
    atom_concat('Q',Res,Ans).
listtostring([s|T],Ans):-
    listtostring(T,Res),
    atom_concat('S',Res,Ans).

qssorth(Filename, Answer):-

    read_input(Filename,_,Queue),
    quick_sort(Queue,Sorted),
    assert(final(Sorted)),
    length(L,_), solution(Queue,[],L)->
    butlast(L,Res),
    listtostring(Res,Answer);
     listtostring([],Answer).

qssort(Filename, Answer):-
    once(qssorth(Filename, Answer)).