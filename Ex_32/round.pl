%helpful predicates----
is_equal(A,A).
maximum(A,B,Maxn):- A >= B -> Maxn is A; Maxn is B.
minimum(A,B,Min):- A >= B -> Min is B; Min is A.
first([Head|_],Head).


zeros(N,L):-
    (N =\= 0 ->     Nn is N-1,
        zeros(Nn, NL)  ,
        L = [0| NL]
    ;   L = []
    ).

%convert array of town per carr to cars in town----
cars_of_city([], Iter,Count,T, Res):-
    Rest is T - Iter-1,
    zeros(Rest, Zeros),
    Res = [Count| Zeros].
cars_of_city([Head|Tail], Iter,Count,T, Res):-
    (Head =:= Iter -> Countn is Count + 1,
    cars_of_city(Tail, Iter, Countn,T, Res);
    Countn is Iter +1,
    cars_of_city([Head|Tail],Countn ,0 ,T, Resn) ,
    Res =  [Count | Resn]).
%help function to rotate pointer in a pac-man style rotation-----
rot_increment(L,I,R):-
    I < L-1 -> R is I+1; R is I - L + 1.
%find next non zero town using a pac-man style rotation-----
next_non_zero(_,I,1,_,I).    
next_non_zero(List,I,0,T,R):-
    rot_increment(T,I,In),
    nth0(In,List,Cars),
    is_equal(Cars,0) -> next_non_zero(List,In,0,T,R); 
    rot_increment(T,I,In),
    next_non_zero(List,In,1,T,R).

%compute max and sum for town 0-----
sum_from_zero([],_,_,_,Sum,Sum).% Use without the first head
sum_from_zero([Hs|Ts],T,I,Max,Sum,Sumr):-
    maximum(Hs,Max,Maxn),
    In is I+1,
    (I =\= 0 ->
    Sumn is Sum + Hs*(T-I);
    Sumn is Sum),
    sum_from_zero(Ts,T,In,Maxn,Sumn,Sumr).

%find diff-----
find_diff(Main,Sec,T,Diff):-
       ((Main>=Sec)->
        Diff is Main-Sec;
        Diff is T - Sec + Main).

%check validity (same as ml)-----
valid(Sum,Diff):-
    (Sum + 1) >= (2*Diff) .

%find min town-----
search(_,T,_,Min,Mint,T,_,_,Min,Mint).
search(C,T,Lis,Min,Mint,Main,Sec,Sum,X,Y):-
%  here we use 2 pointers (variables that store indexes not actual pointers) 
% the main goes through the list once and the sec keeps the max (next non zero value)   
    
    (is_equal(Main,Sec)-> next_non_zero(Lis,Sec,0,T,Secn); Secn is Sec),%if main == sec update sec
    
    find_diff(Main,Secn,T,Diff),

    nth0(Main,Lis,Nth),
    Sumn is Sum + C - (T * Nth ),%calculate sum
    Mainn is Main+1,%move main pointer

    (valid(Sumn,Diff) -> 
            (Min > Sumn->
                search(C,T,Lis,Sumn,Main,Mainn,Secn,Sumn,X,Y)
            ;
                (Min =:= Sumn->
                    minimum(Mint,Main,MinC),
                    search(C,T,Lis,Sumn,MinC,Mainn,Secn,Sumn,X,Y)
                ;
                    search(C,T,Lis,Min,Mint,Mainn,Secn,Sumn,X,Y))
            ;
            search(C,T,Lis,Min,Mint,Mainn,Secn,Sumn,X,Y))
        ;

        search(C,T,Lis,Min,Mint,Mainn,Secn,Sumn,X,Y)).
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

round(File,X,Y):-
    read_input(File,T,C,Lis),
    sort(0,@=<,Lis,Lissorted),
    cars_of_city(Lissorted,0,0,T,Cars),
    sum_from_zero(Cars,T,0,0,0,Sum),
    once( search(C,T,Cars,Sum,0,1,1,Sum,X,Y)).    









