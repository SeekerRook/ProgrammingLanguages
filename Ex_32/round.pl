% cars_of_city ([Inhead|Intail],T,[Outhead|Outtail],Iterator).
is_equal(A,A).
rot_increment(L,I,R):-
    I < L-1 -> R is I+1; R is I - L + 1.

maximum(A,B,Maxn):- A >= B -> Maxn is A; Maxn is B.
minimum(A,B,Min):- A >= B -> Min is B; Min is A.
first([Head|_],Head).
% cars_of_city([Head],T,Head,Count,Res,R):-
%         print("1"),
%         Countn is Count+1,
%         append(Res,[Countn],R). 
% cars_of_city([Head],T,I,Count,Res,R):-
%         print("2"),
%         % is_equal(Head,I) -> cars_of_city([Head],T,Head,Prev,Count,Res,R);
%         append(Res,[0],R).    
% cars_of_city([Head|[Head|Tail]],T,Head,Count,Res,R):-
%     print("3"),
%     Countn is Count + 1,
%     cars_of_city([Head|Tail],T,Head,Countn,Res,R).   
% cars_of_city([Head|[Next|Tail]],T,Head,Count,Res,R):-
%     print("4"),
%     Countn is Count+1,
%     append(Res,[Countn],NR),
%     Nex is Head+1,
%     cars_of_city([Next|Tail],T,Nex,0,NR,R).
% cars_of_city([Head|[Next|Tail]],T,I,Count,Res,R):-
%     print("5"),
%     % is_equal(Head,I) -> cars_of_city([Head|[Next|Tail]],T,Head,Prev,Count,Res,R)
%     % ; 
%    append(Res,[0],NR),
%     Nex is I+1,
%     cars_of_city([Next|Tail],T,Nex,0,NR,R).

zeros(N,L):-
    (N =\= 0 ->     Nn is N-1,
        zeros(Nn, NL)  ,
        L = [0| NL]
    ;   L = []
    ).

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

next_non_zero(_,I,1,_,I).    
next_non_zero(List,I,0,T,R):-
    rot_increment(T,I,In),
    nth0(In,List,Cars),
    is_equal(Cars,0) -> next_non_zero(List,In,0,T,R); 
    rot_increment(T,I,In),
    next_non_zero(List,In,1,T,R).

sum_from_zero([],_,_,_,Sum,Sum).% Use without the first head
sum_from_zero([Hs|Ts],T,I,Max,Sum,Sumr):-
    maximum(Hs,Max,Maxn),
    In is I+1,
    (I =\= 0 ->
    Sumn is Sum + Hs*(T-I);
    Sumn is Sum),
    sum_from_zero(Ts,T,In,Maxn,Sumn,Sumr).

find_diff(Main,Sec,T,Diff):-
       ((Main>=Sec)->
        Diff is Main-Sec;
        Diff is T - Sec + Main).
valid(Sum,Diff):-
    (Sum + 1) >= (2*Diff) .

search(_,T,_,Min,Mint,T,_,_,Min,Mint).

search(C,T,Lis,Min,Mint,Main,Sec,Sum,X,Y):-
    
    (is_equal(Main,Sec)-> next_non_zero(Lis,Sec,0,T,Secn); Secn is Sec),
    
    find_diff(Main,Secn,T,Diff),

    nth0(Main,Lis,Nth),
    Sumn is Sum + C - (T * Nth ),
    Mainn is Main+1,
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
%----
round(File,X,Y):-
    read_input(File,T,C,Lis),
    sort(0,@=<,Lis,Lissorted),
    cars_of_city(Lissorted,0,0,T,Cars),
    sum_from_zero(Cars,T,0,0,0,Sum),
    once( search(C,T,Cars,Sum,0,1,1,Sum,X,Y)).    









