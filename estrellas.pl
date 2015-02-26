verif_rango([H|T]) :- H >= 1, H =< 16, verif_rango(T).
verif_rango([]).

estrella(Lista) :-
	Lista = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],
	Digitos = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
	permutar(Lista,Digitos),
	34 is B + C + D + E,
	34 is B + F + J + L,
	34 is L + M + N + O,
	34 is E + G + K + O,
	34 is A + C + F + H,
	34 is H + J + M + P,
	34 is P + N + K + I,
   34 is I + G + D + A.

permutar([X|Xs],Lista) :- select(X,Lista,L1), permutar(Xs,L1).
permutar([],Lista).






