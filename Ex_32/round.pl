% cars_of_city ([Inhead|Intail],T,[Outhead|Outtail],Iterator).

rot_increment(L,I,R):-
    I < L-1 -> R is I+1; R is I - L + 1.
    
next_non_zero(List,I,1,T,R):-
    
next_non_zero(List,I,0,T,R):-

next_non_zero(List,0,_,T,R):-
    Next
    next_non_zero(List,nth())

