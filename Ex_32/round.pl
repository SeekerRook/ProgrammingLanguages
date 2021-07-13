% cars_of_city ([Inhead|Intail],T,[Outhead|Outtail],Iterator).
is_equal(A,A).
rot_increment(L,I,R):-
    I < L-1 -> R is I+1; R is I - L + 1.

maximum(A,B,Maxn):- A >= B -> Maxn is A; Maxn is B.

cars_of_city([Head],T,Head,Count,Res,R):-
        Countn is Count+1,
        append(Res,Countn,R). 
cars_of_city([Head],T,I,Count,Res,R):-
        is_equal(Head,I) -> cars_of_city([Head],T,Head,Prev,Count,Res,R);
        append(Res,0,R).    
cars_of_city([Head|[Head|Tail]],T,Head,Count,Res,R):-
    Countn is Count + 1,
    cars_of_city([Head|Tail],T,Head,Countn,Res,R).   
cars_of_city([Head|[Next|Tail]],T,Head,Count,Res,R):-
    Countn is Count+1,
    append(Res,Countn,NR),
    Next = Head+1,
    cars_of_city([Next|Tail],T,Next,0,NR,R).
cars_of_city([Head|[Next|Tail]],T,I,Count,Res,R):-
    is_equal(Head,I) -> cars_of_city([Head|[Next|Tail]],T,Head,Prev,Count,Res,R)
    ; 
   (append(Res,0,NR),
    Next is I+1,
    cars_of_city([Next|Tail],T,Next,0,NR,R)).



next_non_zero(_,I,1,_,I).    
next_non_zero(List,I,0,T,R):-
    rot_increment(T,I,In),
    nth0(In,List,Cars),
    is_equal(Cars,0) -> next_non_zero(List,In,0,T,R); 
    rot_increment(T,I,In),
    next_non_zero(List,In,1,T,R).

sum_from_zero([],_,_,Max,Sum,Max,Sum).% Use without the first head
sum_from_zero([Hs|Ts],T,I,Max,Sum,Maxr,Sumr):-
    maximum(Hs,Max,Maxn),
    In is I+1,
    Sumn is Sum + Hs*(T-I),
    sum_from_zero(Ts,T,In,Maxn,Sumn,Maxr,Sumr).






