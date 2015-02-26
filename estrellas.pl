verif_rango([H|T]) :- H >= 1, H =< 16, verif_rango(T).
verif_rango([]).

estrella(Lista) :-
	Lista = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],
	Digitos = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
	permutar([B,C,D,E],Digitos),
	34 is B + C + D + E,
	select(B,Digitos,Digitos1),
	select(C,Digitos1,Digitos2),
	select(D,Digitos2,Digitos3),
	select(E,Digitos3,Digitos4),
	permutar([F,J,L],Digitos4),
	34 is B + F + J + L,
	select(F,Digitos4,Digitos5),
	select(J,Digitos5,Digitos6),
	select(L,Digitos6,Digitos7),
	permutar([M,N,O],Digitos7),
	34 is L + M + N + O,
	select(M,Digitos7,Digitos8),
	select(N,Digitos8,Digitos9),
	select(O,Digitos9,Digitos10),
	permutar([K,G],Digitos10),
	34 is E + G + K + O,
	select(G,Digitos10,Digitos11),
	select(K,Digitos11,Digitos12),
	permutar([A,H],Digitos12),
	34 is A + C + F + H,
	select(A,Digitos12,Digitos13),
	select(H,Digitos13,Digitos14),
	permutar([P],Digitos14),
	34 is H + J + M + P,
	select(P,Digitos14,Digitos15),
	permutar([I],Digitos15),
	34 is P + N + K + I,
	34 is I + G + D + A.

permutar([X|Xs],Lista) :- select(X,Lista,L1), permutar(Xs,L1).
permutar([],Lista).
/*
obtener(_,Lista,Lista,0).
obtener([Head|Tail],Lista,ListaMocha,numElem):- 
	numElem1 is numElem - 1,
	select(Head,Lista,ListaMocha),
	obtener(Tail,ListaMocha,numElem1)
*/




