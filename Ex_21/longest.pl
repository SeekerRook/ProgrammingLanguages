max(X,X,X).
max(X,Y,X) :- X>Y.
max(X,Y,Y) :- X<Y.

check(Sum,Hospitals,Days) :- -Sum/(Hospitals * Days)>1. 

%sum of list elements
sum([],X,X).
sum([H|T], A, S) :- A2 is A + H, sum(T,A2,S).
sum(L,S) :- sum(L,0,S).
%---

checklist(L,Hospitals,Days,Ans):-
    sum(L,S),
    check(S,Hospitals,Days) -> Ans = L; Ans = [].


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

%find sublists-----
subseq([], []).
subseq([_|Xs], Ys) :-
    subseq(Xs, Ys).
subseq([X|Xs], [X|Ys]) :-
    prefix_subseq(Xs, Ys).

prefix_subseq(_, []).
prefix_subseq([X|Xs], [X|Ys]) :-
    prefix_subseq(Xs, Ys).

subsets(Data,L):-
    findall(Answer,subseq(Data,Answer),L).
%----

%remove duplicates-----
remove_dups([], []).

remove_dups([First | Rest], NewRest) :- member(First, Rest), remove_dups(Rest, NewRest).

remove_dups([First | Rest], [First | NewRest]) :- not(member(First, Rest)), remove_dups(Rest, NewRest). 
%-----
%find valid subsets----
validsubset(Data,Hospitals,Days,Ans):-
    subseq(Data,Answer),
    checklist(Answer,Hospitals,Days,Ans).

validsubsets(Data,Hospitals,Days,Ans):-
    findall(Answer,validsubset(Data,Hospitals,Days,Answer),Temp),
    remove_dups(Temp,Temp2),
    %writeln(Temp2),%debugging
    longest_list(Temp2,_,0,Ans).
%-----

%find longest element----
head([X|_],Y):-Y = X.
longestList([], []).
longest_list([H|T], LongList, LongLen,Ans):-
    length(H, Len),
    (Len > LongLen -> 
        longest_list(T, [H], Len,Ans); 
        longest_list(T, LongList, LongLen,Ans)).

longest_list([],Finallist,_,Ans):-
    head(Finallist,T),
    length(T,Ans).

    


%main-------
longesth(File,Answer):-
    read_input(File,Days,Hospitals,Data),
    validsubsets(Data,Hospitals,Days,Answer).

longest(File,Answer):- once(longesth(File,Answer)).
 
