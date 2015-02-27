unifica(X,Y) :- atomic(X), atomic(Y), X = Y, !.
unifica(X,Y) :- var(X), \+ ocurre(X,Y), X = Y, !.
unifica(X,Y) :- var(Y), unifica(Y,X), !.
unifica(X,Y) :-
	compound(X), compound(Y),
	=..(X,[Hx|Tx]), =..(Y,[Hy|Ty]), Hx == Hy, unificaArgs(Tx,Ty), !.

/* ocurre(A,B) tiene exito si la variable A ocurre en el termino (posiblemente complejo) B*/
ocurre(X,Y) :- compound(Y), =..(Y,[_|T]), ocAux(X,T).
ocurre(_,Y) :- var(Y), fail.
ocurre(_,Y) :- atomic(Y), fail.

/* ocAux(X,L) tiene exito si la variable X ocurre en algun elemento de la lista de argumentos L, donde cada elemento puede ser un termino complejo*/
ocAux(X,[X|_]) :- var(X).
ocAux(X,[H|T]) :- compound(H), =..(H,[_|T1]), \+ ocAux(X,T1), ocAux(X,T).
ocAux(X,[_|T]) :- ocAux(X,T).

/* unificaArgs(L1,L2) tiene exito si cada elemento de L1 se puede unificar con el elemento de L2 en la misma posicion*/
unificaArgs([H1|T1],[H2|T2]) :- unifica(H1,H2), unificaArgs(T1,T2).
unificaArgs([],[]).
unificaArgs([],_) :- fail.
unificaArgs(_,[]) :- fail.
