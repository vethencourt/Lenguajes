unifica(X,Y) :- atomic(X), atomic(Y), X = Y.
unifica(X,Y) :- var(X), \+ ocurre(X,Y).
unifica(X,Y) :- var(Y), unifica(Y,X).
unifica(X,Y) :-
	compound(X), compound(Y),
	=..(X,[Hx|Tx]), =..(Y,[Hy|Ty]), Hx == Hy, unificaArgs(Tx,Ty).

% 'X' es una variable, 'Y' es un termino posiblemente complejo
ocurre(X,Y) :- compound(Y), =..(Y,[_|T]), occAux(X,T).
ocurre(_,Y) :- var(Y), fail.
ocurre(_,Y) :- atomic(Y), fail.

ocAux(X,[X|_]).
ocAux(X,[H|T]) :- compound(H), =..(H,[_|T1]), \+ ocAux(X,T1), ocAux(X,T).
ocAux(X,[_|T]) :- ocAux(X,T).

unificaArgs([H1|T1],[H2|T2]) :- unifica(H1,H2), unificaArgs(T1,T2).
unificaArgs([],[]).
unificaArgs([],_) :- fail.
unificaArgs(_,[]) :- fail.
