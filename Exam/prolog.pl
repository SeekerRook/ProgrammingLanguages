% p(17).
% p(42).
% p(7).

% qa(X,Y) :-p(X), p(Y), X >= Y.
% qb(X,Y) :-p(X), !, p(Y), X >= Y.
% pc(X) :-p(X), !.
% qc(X,Y) :-pc(X), pc(Y), X >= Y.

unique([]).
unique([Item | Rest]) :-
    member(Item, Rest) -> fail ; unique(Rest).
% unique([_ | Rest]) :-
    % unique(Rest).